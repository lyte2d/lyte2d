/* (c) mg */

#include <morebase.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include <signal.h>

#include "lyte.h"

#include "_boot_zip.h"

#define LUA_BOOT_ZIP "bootzip"
#define LUA_BOOT_FILENAME "lyte_boot"

#define LUA_GAME_BINARY "GAME_BINARY"
#define LUA_ARCHIVE_ESTIMATED_SIZE (120*1024*1024)
#define LUA_GAME_BINARY_ESTIMATED_SIZE (120*1024*1024)
#define LUA_MODULE_FILES_MAX_SIZE (10*1024*1024)

static bool need_to_load_binaries = false;
static bool has_repl = false; // enable with repl=lua or repl=fnl in the commandline

#ifndef __EMSCRIPTEN__
static LYTE_LANG repl_lang = LUA;
#endif

//// TODO: make app_filename by default null. _load_lua_file will in this case look for init.lua init.fnl files
/// if it's a name it's a fullname app=my.fnl so it needs to be detected.  app can end in / meaning it's a folder where the above rule will apply
/// there's also dir and zip.  app rules apply inside a zip too!
/// dir tells where the zip or app can be found
///
/// unfortunately we need to do this in C not boot lua. because even boot lua is loaded here :(
/// but perhaps we can keep boot in lua, do the rest in lua?

static M_Config cfg = {0};
char *_app_filename = "app";
char *_archive_filename = "app.zip";

///////////////////// (copied from lua interpreter)

static lua_State *globalL = NULL;

static void l_message (const char *pname, const char *msg) {
  if (pname) fprintf(stderr, "%s: ", pname);
  fprintf(stderr, "%s\n", msg);
  fflush(stderr);
}

static void lstop (lua_State *L, lua_Debug *ar) {
  (void)ar;  /* unused arg. */
  lua_sethook(L, NULL, 0, 0);
  luaL_error(L, "interrupted!");
}


static void laction (int i) {
  signal(i, SIG_DFL); /* if another SIGINT happens before lstop,
                              terminate process (default action) */
  lua_sethook(globalL, lstop, LUA_MASKCALL | LUA_MASKRET | LUA_MASKCOUNT, 1);
}

static int traceback (lua_State *L) {
  if (!lua_isstring(L, 1))  /* 'message' not a string? */
    return 1;  /* keep it intact */
  lua_getfield(L, LUA_GLOBALSINDEX, "debug");
  if (!lua_istable(L, -1)) {
    lua_pop(L, 1);
    return 1;
  }
  lua_getfield(L, -1, "traceback");
  if (!lua_isfunction(L, -1)) {
    lua_pop(L, 2);
    return 1;
  }
  lua_pushvalue(L, 1);  /* pass error message */
  lua_pushinteger(L, 2);  /* skip this function and traceback */
  lua_call(L, 2, 1);  /* call debug.traceback */
  return 1;
}


static inline int docall (lua_State *L, int narg, int clear) {
  int status;
  int base = lua_gettop(L) - narg;  /* function index */
  lua_pushcfunction(L, traceback);  /* push traceback function */
  lua_insert(L, base);  /* put it under chunk and args */
  signal(SIGINT, laction);
  status = lua_pcall(L, narg, (clear ? 0 : LUA_MULTRET), base);
  signal(SIGINT, SIG_DFL);
  lua_remove(L, base);  /* remove traceback function */
  /* force a complete garbage collection in case of errors */
  if (status != 0) lua_gc(L, LUA_GCCOLLECT, 0);
  return status;
}

/////////////////////

static inline bool _lyte_find_module_path(lua_State *L, char *str, const char *module_name, const char *ext) {
    sprintf(str, "return (string.gsub('%s', '(%%w+)[.]', '%%1/') .. '%s')\n", module_name, ext);
    int err = luaL_dostring(L, (const char *)str);
    (void)err;
    const char *path_name = luaL_checkstring(L, 1);
    (void)path_name;
    bool exists = M_path_exists(path_name);
    return exists;
}


// [ pathstring --  ]
static int _try_load(lua_State *L, bool error_if_missing) {
    CHK_STACK(1);
    const char *module_name = luaL_checkstring(L, 1);
    lua_pop(L, 1);
    CHK_STACK(0);


    // -------------------------- load ---
    char str[400] = {0};
    bool exists = false;
    bool is_fennel = false;

    exists = _lyte_find_module_path(L, str, module_name, ".lua");
    if (!exists) {
        lua_pop(L, 1);
        exists = _lyte_find_module_path(L, str, module_name, ".fnl");
        if (!exists) {
            lua_pop(L, 1);
            if (error_if_missing) {
                fprintf(stderr, "Warning: couldn't find file: %s.lua or %s.fnl\n", module_name, module_name);
                lua_error(L);
            } else {
                fprintf(stderr, "Couldn't find file: %s.lua or %s.fnl\n", module_name, module_name);
                CHK_STACK(0);
                return 0;
            }
        } else {
            is_fennel = true;
        }
    }

    CHK_STACK(1);
    //
    const char *path_name = luaL_checkstring(L, -1);
    lua_pop(L, 1);
    int sz, err=0; (void)err;
    char *module_file_buf = malloc(LUA_MODULE_FILES_MAX_SIZE);
    memset(module_file_buf, 0,LUA_MODULE_FILES_MAX_SIZE);

    char *fennel_eval_open = "";
    char *fennel_eval_close_1 = "";
    char *fennel_eval_close_2 = "";
    char *fennel_eval_close_3 = "";



    if (is_fennel) {
        fennel_eval_open = "return fennel.eval([===[";
        fennel_eval_close_1 = "]===], ";
        fennel_eval_close_2 = "{correlate=true, filename='";
        fennel_eval_close_3 = "', allowedGlobals=false})";
        sprintf((char *)module_file_buf, "%s", fennel_eval_open);
    }

    size_t MAX_LEN = LUA_MODULE_FILES_MAX_SIZE - 1024; //TODO: strlen(fennel_eval_open) - strlen(fennel_eval_close);

    sz = M_path_readbytes(path_name, (const uint8_t *)(module_file_buf + strlen(fennel_eval_open)), MAX_LEN);
    if (sz == 0) {
        lua_error(L);
    }
    if (is_fennel) {
        sprintf((char *)module_file_buf + sz + strlen(fennel_eval_open)  , "%s%s%s%s", fennel_eval_close_1, fennel_eval_close_2, module_name, fennel_eval_close_3);
    }

    // ---------------- load

    CHK_STACK(0);
    lua_getglobal(L, "package");
    CHK_STACK(1);
    lua_getfield(L, 1, "loaded");
    CHK_STACK(2);
    lua_pushstring(L, module_name);
    CHK_STACK(3);

    //err = luaL_dostring(L, (const char *)module_file_buf);
    char path_with_at[1024] = {0};
    sprintf(path_with_at, "@%s", path_name); // @ in the path_name tells lua that this is a filepatha and not part of code
    err = luaL_loadbuffer(L, (const char *)module_file_buf, strlen(module_file_buf), (const char *)path_with_at);
    if (err == 0) {
        // err = lua_pcall(L, 0, LUA_MULTRET, 0);
        //lua_call(L, 0, LUA_MULTRET);
         err = docall(L, 0, 0);
        if (err &&  lua_gettop(L) > 0) {
            // remove loaded modules..
            lua_remove(L, 1);
            lua_remove(L, 1);
            lua_remove(L, 1);
            lua_getglobal(L, "print");
            lua_insert(L, 1);
            if (lua_pcall(L, lua_gettop(L)-1, 0, 0) != 0) {
                l_message(path_name, lua_pushfstring(L,
                                    "error calling " LUA_QL("print") " (%s)",
                                    lua_tostring(L, -1)));
            }
            // quit on error for now
            exit(1);
        }
    } else if (err != 0)  {
        printf("ERROR: dostring() on file %s\n", path_name);
        // traceback(L);
        lua_error(L);
        exit(1);
    }
    if (lua_gettop(L) == 3) {
        lua_pushboolean(L, true);
        //printf("error??");
    } else {
        // printf("package:  %s  top: %d \n", module_name, lua_gettop(L));
    }

    CHK_STACK(4);
    lua_settable(L, 2);
    CHK_STACK(2);

    lua_settop(L, 0);
    free(module_file_buf);
    return 0;
}

// [ pathstring --  ]
static int _lyte_loader(lua_State *L) {
    _try_load(L, true);
    return 0;
}

// [ pathstring -- loaderfunction ]
static int _lyte_searcher(lua_State *L) {
    int err; (void)err;
    CHK_STACK(1);
    lua_pushcclosure(L, _lyte_loader, 1);
    CHK_STACK(1);
    return 1;
}

// update the second loader so that we can find lua libraries inside the zip or the exe file (which can also be a zip in fused state)
static void update_package_loaders(lua_State *L) {
    CHK_STACK(0);

    int err=0; (void)err;
    lua_register(L, "_lyte_searcher", _lyte_searcher);
    err = luaL_dostring(L, "table.insert(package.loaders, 2, _lyte_searcher) \n");
    CHK_STACK(0);
}

static inline int _load_lua_file(lua_State *L, const char *path, bool error_if_missing) {
    lua_pushstring(L, path);
    return _try_load(L, error_if_missing);
}


static void check_binary_downloads(lua_State *L) {
    bool archive_done = M_filesystem_zippath_is_done(_archive_filename);
    bool binary_done = M_filesystem_zippath_is_done(LUA_GAME_BINARY);
    if (need_to_load_binaries && archive_done && binary_done) {
        update_package_loaders(L);
        // TODO: investigate: fails on Linux build
        // M_app_seticon(cfg.icon);
        need_to_load_binaries = false;
        _load_lua_file(L, LUA_BOOT_FILENAME, true);
        _load_lua_file(L, _app_filename, !has_repl); // if we don't have repl (parameter) than missing app.lua file will be an error
        if (lua_gettop(L) != 0) {
            lua_error(L);
        }
        if (has_repl) {
            repl_prompt();
        }
    }
}


static int _lua_panic_fn(lua_State *L) {
    traceback(L);
    const char *str = lua_tostring(L, -1);
    if (str) {
        fprintf(stderr, "\n%s\n", str);
    } else {
        fprintf(stderr, "\nQuitting with error.\n");
    }
    return 0;
}


float _angle = 0.0f;
float _loading_time = 0.0f;

bool _skip_tick = false;

static void tick_fn(void *data, float dt, int width, int height, bool resized, bool fullscreen) {
    lua_State *L = data;
    int status = 0;
    CHK_STACK(0);
    if(need_to_load_binaries) {
        _loading_time += dt;
        int ww = 190;
        int hh = 30;
        if (_loading_time > 0.5) {
            _angle += dt * 1;
        }
        // loading screen
        M_gfx_pushmatrix();
        M_gfx_translate(width/2,height/2);
        M_gfx_rotate(_angle);
        M_gfx_clear(0,0,0,1);
        M_gfx_setcolor(1.0,0.4,0.2,0.7);
        M_gfx_drawrect_filled(-ww/2,-hh/2,ww,hh);
        M_gfx_popmatrix();
        check_binary_downloads(L);

        // TODO: once done, set tick func again. we should have multiple tick fns.
        // one for the error case as well
    } else {
        // can skip one frame when returning from repl (so that DT isn't crazy high!)
        if (!_skip_tick) {
            // TODO make some error checks before starting.. like tick exists..
            lua_getglobal(L, "lyte");
            lua_pushstring(L, "tick");
            lua_gettable(L, -2);
            lua_remove(L, -2);

            lua_pushnumber(L,dt);
            lua_pushinteger(L,width);
            lua_pushinteger(L,height);
            lua_pushboolean(L,resized);
            lua_pushboolean(L,fullscreen);
            status = docall(L, 5, 0);
            if (status &&  lua_gettop(L) > 0) {
                lua_getglobal(L, "print");
                lua_insert(L, 1);
                if (lua_pcall(L, lua_gettop(L)-1, 0, 0) != 0)
                    l_message("program_name", lua_pushfstring(L,
                                        "error calling " LUA_QL("print") " (%s)",
                                        lua_tostring(L, -1)));
                // quit on error for now
                exit(1);
            }
            //lua_call(L,5,0);
        } else {
            _skip_tick = false;
        }
        if (has_repl) {
            _skip_tick = repl_check(L);
        }
    }
}


int main(int argc, char *argv[]) {
    lua_State *L = luaL_newstate();
    // lua_gc(L, LUA_GCCOLLECT, 0);
    lua_atpanic(L, _lua_panic_fn);
    globalL = L;
    luaL_openlibs(L);
    // lua_gc(L, LUA_GCCOLLECT, 0);
    register_lyte(L);
    // lua_gc(L, LUA_GCCOLLECT, 0);
    int err = 0;
    err = get_config(&cfg, argc, argv);
    if(err) { printf("\nErrror: (get_config): %d\n", err); return err; }
    // lua_gc(L, LUA_GCCOLLECT, 0);
    err = M_app_init(&cfg);
    if(err) { printf("\nError! (app_init): %d\n", err); return err; }
    // lua_gc(L, LUA_GCCOLLECT, 0);
    ////////////////////////////////////////////////////////////////////////////////

    need_to_load_binaries = true;
    char *localpath = ".";
    char *archivepath = _archive_filename;

    // check: 'zip' first. acrhive file name change.  default "app.zip"
    if (M_app_hasarg("zip")) {
        archivepath = (char *)M_app_getarg("zip");
    }

    // check: 'dir' second. default: "./"
    if (M_app_hasarg("dir")) {
        localpath = (char *)M_app_getarg("dir");
        char path[1024];
        ASSERT_(strlen(localpath)<1000, "local_path max length is 1000\n");
        sprintf(path, "%s/%s", localpath, _archive_filename);
        archivepath =path;
    }

    // check: 'app'.  default: "app.lua"
    // TODO: check fennel version of the file too
    if (M_app_hasarg("app")) {
        _app_filename = (char *)M_app_getarg("app");
    }

    //printf("LOCAL PATH: %s\n", localpath);
    M_filesystem_set_writepath(localpath);
    M_filesystem_add_localpath("local", localpath, "/");
    M_filesystem_add_memoryzippath_withbuf(LUA_BOOT_ZIP, "/", boot_zip, boot_zip_len);
    M_filesystem_add_zippath_async(_archive_filename, "/",archivepath, LUA_ARCHIVE_ESTIMATED_SIZE);
    // if (!M_system_WASM()) {
        M_filesystem_add_zippath_async(LUA_GAME_BINARY, "/", argv[0], LUA_GAME_BINARY_ESTIMATED_SIZE);
    // }

    lua_gc(L, LUA_GCCOLLECT, 0);
    // CHK_STACK(0);
#ifndef __EMSCRIPTEN__
    if (M_app_hasarg("repl")) {
        has_repl = true;
        const char *lang = M_app_getarg("repl");
        if (strcmp(lang, "lua") == 0) {
            repl_lang = LUA;
        } else if (strcmp(lang, "fennel") == 0 || strcmp(lang, "fnl") == 0) {
            repl_lang = FENNEL;
        } else {
            printf("Unknown value for 'repl' parameter: '%s'\n", lang);
            lua_error(L);
        }
        repl_setup(repl_lang);
    }
#endif

    err = M_app_init_graphics(&cfg);
    if(err) { printf("\nError! (app_init_graphics): %d\n", err); return err; }


    M_app_startloop(tick_fn, L);
    // lua_gc(L, LUA_GCCOLLECT, 0);

    ////////////////////////////////////////////////////////////////////////////////
    lua_gc(L, LUA_GCCOLLECT, 0);
    M_app_cleanup();
}

