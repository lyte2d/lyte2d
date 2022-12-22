/* (c) mg */

#define LOG(...)

#include <morebase.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include "lyte.h"

#include "_boot_zip.h"

#define LUA_BOOT_ZIP "bootzip"
#define LUA_BOOT_FILENAME "lyte_boot.lua"

#define LUA_GAME_BINARY "GAME_BINARY"
#define LUA_ARCHIVE_ESTIMATED_SIZE (120*1024*1024)
#define LUA_GAME_BINARY_ESTIMATED_SIZE (120*1024*1024)
#define LUA_MODULE_FILES_MAX_SIZE (10*1024*1024)

static bool need_to_load_binaries = false;

static M_Config cfg = {0};
char *_app_filename = "app.lua";
char *_archive_filename = "app.zip";

static inline int _load_lua_file(lua_State *L, const char *path) {
    LOG(" ------> LUA LOADING FILE %s\n", path);
    CHK_STACK(0);
    int sz, err;
    (void) err;
    uint8_t *str = malloc(LUA_MODULE_FILES_MAX_SIZE);
    memset(str, 0,LUA_MODULE_FILES_MAX_SIZE);
    sz =  M_path_readbytes(path, str, LUA_MODULE_FILES_MAX_SIZE);
    if (sz == 0) {
        LOG("FILE NOT FOUND: %s\n", path);
        assert(false);
    }
    CHK_STACK(0);
    luaL_loadstring(L,(const char *)str);
    lua_pcall(L, 0, LUA_MULTRET,0);

    return LUA_MULTRET;
}

// string -- string
static int _lyte_name_to_path(lua_State *L) {
    CHK_STACK(1);
    int err; (void)err;
    const char *module_name = luaL_checkstring(L, 1);
    LOG("lyte_module: %s\n", module_name);
    lua_pop(L, 1);
    CHK_STACK(0);
    char str[400] = {0};
    sprintf(str, "return (string.gsub('%s', '(%%w+)[.]', '%%1/') .. '.lua')\n", module_name);
    err = luaL_dostring(L, (const char *)str);
    const char *path_name = luaL_checkstring(L, 1);
    (void)path_name
    LOG(".... lyte_path: %s\n", path_name);
    CHK_STACK(1);
    return 1;
}

// [ pathstring --  ]
static int _lyte_loader(lua_State *L) {
    const char *module_name =luaL_checkstring(L, -1);
    _lyte_name_to_path(L);
    const char *path_name = luaL_checkstring(L, -1);
    LOG("lyte_loader: mod: %s, path: %s\n", module_name, path_name);
    lua_pop(L, 1);
    int sz, err=0; (void)err;
    uint8_t *str = malloc(LUA_MODULE_FILES_MAX_SIZE);
    memset(str, 0,LUA_MODULE_FILES_MAX_SIZE);
    sz = M_path_readbytes(path_name, str, LUA_MODULE_FILES_MAX_SIZE);
    if (sz == 0) {
        LOG("Error: file not found: %s\n", path_name);
        lua_error(L);
    }
    CHK_STACK(0);
    lua_getglobal(L, "package");
    CHK_STACK(1);
    lua_getfield(L, 1, "loaded");
    CHK_STACK(2);
    lua_pushstring(L, module_name);
    CHK_STACK(3);
    err = luaL_dostring(L, (const char *)str);
    LOG("...-> %d %d\n", lua_gettop(L), lua_type(L, -1));
    if (lua_gettop(L) == 3) {
        LOG("pushing value boolean into lib: %s\n", module_name);
        lua_pushboolean(L, true);
    } else {
        LOG("package:  %s  top: %d \n", module_name, lua_gettop(L));
    }
    CHK_STACK(4);
    lua_settable(L, 2);
    CHK_STACK(2);

    lua_settop(L, 0);
    free(str);
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
    LOG("Updating package loaders: %d\n", err);
    CHK_STACK(0);
}



static void check_binary_downloads(lua_State *L) {
    // LOG("checking resources....:");
    bool archive_done = M_filesystem_zippath_is_done(_archive_filename);
    bool binary_done = M_filesystem_zippath_is_done(LUA_GAME_BINARY);
    if (need_to_load_binaries && archive_done && binary_done) {
        update_package_loaders(L);
        M_app_seticon(cfg.icon);
        need_to_load_binaries = false;
        _load_lua_file(L, LUA_BOOT_FILENAME);
        _load_lua_file(L, _app_filename);
        if (lua_gettop(L) != 0) {
            const char *str = lua_tostring(L, -1);
            (void)str;
            LOG("###############> %s\n", str);
            lua_pop(L, 1);
        }
    }
}


static int _lua_panic_fn(lua_State *L) {
    const char *str = lua_tostring(L, -1);
    fprintf(stderr, "\n\nLua error: !\nErr: %s\n\n", str);
    return 0;
}

float _angle = 0.0f;
float _loading_time = 0.0f;

static void frame_fn(void *data, float dt, int width, int height, bool resized, bool fullscreen) {
    lua_State *L = data;
    CHK_STACK(0);
    if(need_to_load_binaries) {
        _loading_time += dt;
        int ww = 190;
        int hh = 30;
        if (_loading_time > 0.5) {
            _angle += dt * 1;
        }
        // loading screen
        LOG("need to load resources: %d\n", need_to_load_binaries);
        M_gfx_pushmatrix();
        M_gfx_translate(width/2,height/2);
        M_gfx_rotate(_angle);
        M_gfx_clear(0,0,0,1);
        M_gfx_setcolor(1.0,0.4,0.2,0.7);
        M_gfx_drawrect_filled(-ww/2,-hh/2,ww,hh);
        M_gfx_popmatrix();
        check_binary_downloads(L);


    } else {
        lua_getglobal(L, "frame");
        lua_pushnumber(L,dt);
        lua_pushinteger(L,width);
        lua_pushinteger(L,height);
        lua_pushboolean(L,resized);
        lua_pushboolean(L,fullscreen);
        // lua_call(L,5,0);

        int err = lua_pcall(L,5,0, 0);
        if (err != 0) {
            _lua_panic_fn(L);
            M_app_quit();
        }
        // GC collect each frame?
    }
}


int main(int argc, char *argv[]) {
    LOG("\n=== !main entry ===================================================================================\n\n");
    LOG("ARGS: \n");
    for (int i=0; i<argc; i++) {
        LOG("arg at %d is '%s'\n", i, argv[i]);
    }
    LOG("/ARGS\n");
    lua_State *L = luaL_newstate();
    // lua_gc(L, LUA_GCCOLLECT, 0);
    lua_atpanic(L, _lua_panic_fn);
    luaL_openlibs(L);
    // lua_gc(L, LUA_GCCOLLECT, 0);
    lyteapi_open(L);
    // lua_gc(L, LUA_GCCOLLECT, 0);
    int err = 0;
    err = get_config(&cfg, argc, argv);
    if(err) { LOG("\nErrror: (get_config): %d\n", err); return err; }
    // lua_gc(L, LUA_GCCOLLECT, 0);
    err = M_app_init(&cfg);
    if(err) { LOG("\nError! (app_init): %d\n", err); return err; }
    // lua_gc(L, LUA_GCCOLLECT, 0);
    ////////////////////////////////////////////////////////////////////////////////

    need_to_load_binaries = true;
    char *localpath = ".";
    char *archivepath = _archive_filename;

    // check: 'zip' first. acrhive file name change.  default "app.zip"
    if (M_app_hasarg("zip")) {
        archivepath = M_app_getarg("zip");
    }

    // check: 'dir' second. default: "./"
    if (M_app_hasarg("dir")) {
        localpath = M_app_getarg("dir");
        char path[1024];
        ASSERT_(strlen(localpath)<1000, "local_path max length is 1000\n");
        sprintf(path, "%s/%s", localpath, _archive_filename);
        archivepath =path;
    }

    // check: 'app'.  default: "app.lua"
    if (M_app_hasarg("app")) {
        _app_filename = M_app_getarg("app");
    }

    LOG("LOCAL PATH: %s\n", localpath);
    M_filesystem_set_writepath(localpath);
    M_filesystem_add_localpath("local", localpath, "/");
    M_filesystem_add_memoryzippath_withbuf(LUA_BOOT_ZIP, "/", boot_zip, boot_zip_len);
    M_filesystem_add_zippath_async(_archive_filename, "/",archivepath, LUA_ARCHIVE_ESTIMATED_SIZE);
    // if (!M_system_WASM()) {
        M_filesystem_add_zippath_async(LUA_GAME_BINARY, "/", argv[0], LUA_GAME_BINARY_ESTIMATED_SIZE);
    // }

    lua_gc(L, LUA_GCCOLLECT, 0);
    // CHK_STACK(0);
    M_app_startframeloop(frame_fn, L);
    // lua_gc(L, LUA_GCCOLLECT, 0);

    ////////////////////////////////////////////////////////////////////////////////
    LOG("ABOUT TO CLEAN UP (GC first)\n");
    lua_gc(L, LUA_GCCOLLECT, 0);
    LOG("ABOUT TO CLEAN UP (Now cleanup)\n");
    M_app_cleanup();

    LOG("\n\n=== !main exit ====================================================================================\n");
}

