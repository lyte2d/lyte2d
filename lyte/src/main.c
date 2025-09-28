// mg

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include <signal.h>

#include "api_lyte_core_gen.h"

#include "lyte_core.h"



#include "_boot_zip_generated.c"


// luautf8 library doesn't have a header file...
int luaopen_utf8 (lua_State *L);

// TODO: file/line info
#define CHK_STACK(n)                                                                         \
    if (lua_gettop(L) != (n)) {                                                              \
        fprintf(stderr, "Stack top was expected to be %d but is %d.\n", (n), lua_gettop(L)); \
    }

// TODO: make these configureable
#define LYTE_APP_ZIP_MAX_SIZE (120*1024*1024)
#define LYTE_APP_EXE_MAX_SIZE (120*1024*1024)

// TODO: remove (from C config as well)
#define LYTE_INIT_WIDTH 400 // not used
#define LYTE_INIT_HEIGHT 260 // not used

static bool _need_to_load_archives = false;

static char *_app_modulename = "app";
static char *_app_zip_filename = "app.zip";

static uint32_t _download_zip_handle = 0;
static uint32_t _download_exe_handle = 0;


// --begin-- copied from lua.c

static lua_State *_global_L = NULL;

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
  lua_sethook(_global_L, lstop, LUA_MASKCALL | LUA_MASKRET | LUA_MASKCOUNT, 1);
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

// --end-- copied from lua.c


// given module in 'bla.blo.blu' format and an extension: find the module name 'bla/blo/blu.lua'
static inline bool _find_module_path(lua_State *L, char *str, const char *module_name, const char *ext) {
    sprintf(str, "return (string.gsub('%s', '(%%w+)[.]', '%%1/') .. '%s')\n", module_name, ext);
    int err = luaL_dostring(L, (const char *)str);
    (void)err;
    const char *path_name = luaL_checkstring(L, 1);
    (void)path_name;
    bool exists = true; // TODO: check via a '_path_exists(path_name);'

    return exists;
}

static int _try_load(lua_State *L) {
    CHK_STACK(1);
    const char *module_name = luaL_checkstring(L, 1);
    lua_pop(L, 1);
    CHK_STACK(0);

    char str[4096] = {0};
    bool exists = false;
    (void)exists;

    exists = _find_module_path(L, str, module_name, ".lua"); // has side effect: pushes the module name to the path

    CHK_STACK(1);

    const char *path_name = luaL_checkstring(L, -1);

    lua_pop(L, 1);
    int err=0;

    const char *file_content = NULL;
    err = lyte_load_textfile(path_name, &file_content);
    if (err) {
        fprintf(stderr, "Warning: load failed: %s\n", path_name);
        return 0;
        // exit(1);
    } else {
        // printf("%s", file_content);
    }

    CHK_STACK(0);
    lua_getglobal(L, "package");
    CHK_STACK(1);
    lua_getfield(L, 1, "loaded");
    CHK_STACK(2);
    lua_pushstring(L, module_name);
    CHK_STACK(3);

    char path_with_at[4096] = {0};
    sprintf(path_with_at, "@%s", path_name); // @ in the path_name tells lua that this is a filepath and not part of code

    size_t fc_len = strlen(file_content);
    err = luaL_loadbuffer(L, (const char *)file_content,fc_len , (const char *)path_with_at);
    if (err == 0) {
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
        fprintf(stderr, "Error: dostring() on file %s\n", path_name);
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
    // free(module_file_buf);
    return 0;
}

static inline int _load_lua_file(lua_State *L, const char *path, bool error_if_missing) {
    (void)error_if_missing;
    lua_pushstring(L, path);
    // printf("Load_lua_file %s\n", path);
    return _try_load(L);
}

static void _check_fetch_file_status(lua_State *L) {
    bool archive_done;
    bool binary_done;
    archive_done = !lyte_core_filesystem_check_fetch_file_in_progress(_download_zip_handle);
    binary_done = !lyte_core_filesystem_check_fetch_file_in_progress(_download_exe_handle);

    if (_need_to_load_archives && archive_done && binary_done) {

        _need_to_load_archives = false;

        lua_pushstring(L, _app_modulename);
        lua_setglobal(L, "LYTE_APP_MODULENAME");

        lua_getglobal(L, "require");
        lua_pushstring(L, _app_modulename);

        docall(L, 1, 0);

        if (lua_gettop(L) != 0) {
            lua_settop(L, 0);
        }

    }
}

static int _lua_panic_fn(lua_State *L) {
    traceback(L);
    const char *str = lua_tostring(L, -1);
    if (str) {
        fprintf(stderr, "\nPanic: %s\n", str);
    } else {
        fprintf(stderr, "\nPanic. (Quitting)\n");
    }
    return 0;
}

static void tick_fn_active(void *data, float dt, int width, int height, bool resized, bool fullscreen) {
    lua_State *L = data;
    int status = 0;

    // TODO make some error checks before starting.. like 'lyte.tick' exists..
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

    if (status != 0) {
        const char * err =luaL_checkstring(L, -1);
        lua_remove(L, -1);
        fprintf(stderr, "(Error) %s\n", err);
        lua_getglobal(L, "LYTE_SET_ERROR_TEXT_AND_LINE");
        lua_pushstring(L, err);
        lua_call(L, 1, 0);
        lua_getglobal(L, "lyte");
        lua_getglobal(L, "LYTE_TICK_ERROR_FUNC");
        lua_setfield(L, -2, "tick");

        lua_settop(L, 0);
    }

    if (lua_gettop(L) > 0) {
        // shouldn't happen...
        // fprintf(stderr, "Error!!!!\n");
        lua_getglobal(L, "print");
        lua_insert(L, 1);
        if (lua_pcall(L, lua_gettop(L)-1, 0, 0) != 0)
            l_message("program_name", lua_pushfstring(L,
                                "error calling " LUA_QL("print") " (%s)",
                                lua_tostring(L, -1)));
        // quit on error for now
        exit(1);
    }
}


static void tick_fn_active_tick_loading(void *data, float dt, int width, int height, bool resized, bool fullscreen) {
    lua_State *L = data;
    int status = 0;

    lua_getglobal(L, "lyte");
    lua_pushstring(L, "tick_loading");
    lua_gettable(L, -2);
    lua_remove(L, -2);

    lua_pushnumber(L,dt);
    lua_pushinteger(L,width);
    lua_pushinteger(L,height);
    lua_pushboolean(L,resized);
    lua_pushboolean(L,fullscreen);

    status = docall(L, 5, 0);

    if (status &&  lua_gettop(L) > 0) {
        // TODO: check if this triggers
        lua_getglobal(L, "print");
        lua_insert(L, 1);
        if (lua_pcall(L, lua_gettop(L)-1, 0, 0) != 0)
            l_message("program_name", lua_pushfstring(L,
                                "error calling " LUA_QL("print") " (%s)",
                                lua_tostring(L, -1)));
        // quit on error for now
        exit(1);
    }
}

static void tick_fn_loading(void *data, float dt, int width, int height, bool resized, bool fullscreen) {
    lua_State *L = data;

    CHK_STACK(0);
    if(_need_to_load_archives) {
        tick_fn_active_tick_loading(data, dt, width, height, resized, fullscreen);

        _check_fetch_file_status(L);

    } else {
        lyte_core_set_loop(tick_fn_active, L);
    }
}

static int init(lyte_Config cfg) {
    int err = 0;

    err = lyte_core_filesystem_init();
    err = lyte_core_image_init();
    err = lyte_core_audio_init();
    err = lyte_core_font_init();
    err = lyte_core_shader_init();
    // err = lyte_core_physics_init();

    lua_State *L = luaL_newstate();
    lua_atpanic(L, _lua_panic_fn);
    _global_L = L;
    luaL_openlibs(L);
    // load utf8 library (5.1 doesn't normally have it)
    luaopen_utf8(L);


    register_lyte_core_api(L);

    lua_gc(L, LUA_GCCOLLECT, 0);

    _need_to_load_archives = true;
    const char *localpath = lyte_core_state_get_arg_default("dir", ".");
    const char *app_zip_filename = lyte_core_state_get_arg_default("zip", _app_zip_filename);

    char archivepath[4096];
    strcpy(archivepath, localpath);
    strcat(archivepath, "/");
    strcat(archivepath, app_zip_filename);

    // default: "app.lua"
    if (lyte_core_state_has_arg("app")) {
        _app_modulename = (char *)lyte_core_state_get_arg("app");
    }

    lyte_core_filesystem_set_writeable_path(localpath);
    lyte_core_filesystem_add_path_local(localpath, "/");
    lyte_core_filesystem_add_path_memory("BOOT_ZIP", boot_zip, boot_zip_len, "/");
    _download_zip_handle = lyte_core_filesystem_fetch_file_async("APP_ZIP", archivepath, LYTE_APP_ZIP_MAX_SIZE, "/");
    _download_exe_handle = lyte_core_filesystem_fetch_file_async("APP_EXE", cfg.exe_name, LYTE_APP_EXE_MAX_SIZE, "/");

    lua_gc(L, LUA_GCCOLLECT, 0);

    // LOAD BOOT
    _load_lua_file(L, "lyte_boot", true);

    return err;
}


static int cleanup(void) {
    int err = 0;
    err = lyte_core_image_cleanup();
    err = lyte_core_audio_cleanup();
    err = lyte_core_font_cleanup();
    err = lyte_core_shader_cleanup();
    err = lyte_core_filesystem_cleanup();
    // err = lyte_core_physics_cleanup();

    return err;
}


int main(int argc, char *argv[]) {
    int err  = 0;
    lyte_Config cfg = (lyte_Config){
        .args.argc = argc,
        .args.argv = argv,
        .exe_name = argv[0],
        .fullscreen = false,
        .vsync = true,
        .blendmode = LYTE_BLENDMODE_BLEND,
        .filtermode = LYTE_FILTERMODE_NEAREST,
        // .window_title = "lyte",
        .window_size = (lyte_Size){ .width=LYTE_INIT_WIDTH, .height=LYTE_INIT_HEIGHT },
        .window_min_size = (lyte_Size){ .width=0, .height=0 },
    };

    err = lyte_core_state_init(cfg);

    err = init(cfg);

    err = lyte_core_start_loop((lyte_TickFunction)tick_fn_loading, _global_L);

    err = lyte_core_window_cleanup();

    err = cleanup();

    return err;
}
