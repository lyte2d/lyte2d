// BEGIN: This file is generated
// -- do not edit directly use code gen --
//---------------------------------------------------------------------------------------

// lyte api code

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

#include <lua.h>
#include <lauxlib.h>

#include "api_generated.h"

#include "api.impl.c"  // inline implementations in this file

// enum helpers
typedef struct EnumStrInt {
    const char *str;
    int value;
} EnumStrInt;

static int enumstring_to_int(EnumStrInt *vals, const char *str) {
    while (vals->str && (strcmp(str, vals->str)!=0)) vals++;
    return vals->value;
}

EnumStrInt lyte_UniformType_strings[] = {
    {"_invalid", LYTE_UNIFORMTYPE__INVALID},
    {"float", LYTE_UNIFORMTYPE_FLOAT},
    {"vec2", LYTE_UNIFORMTYPE_VEC2},
    {"vec3", LYTE_UNIFORMTYPE_VEC3},
    {"vec4", LYTE_UNIFORMTYPE_VEC4},
    {"int", LYTE_UNIFORMTYPE_INT},
    {"ivec2", LYTE_UNIFORMTYPE_IVEC2},
    {"ivec3", LYTE_UNIFORMTYPE_IVEC3},
    {"ivec4", LYTE_UNIFORMTYPE_IVEC4},
    {"mat4", LYTE_UNIFORMTYPE_MAT4},
    {"sampler2D", LYTE_UNIFORMTYPE_SAMPLER2D},
    {NULL, -1},
};
EnumStrInt lyte_BlendMode_strings[] = {
    {"none", LYTE_BLENDMODE_NONE},
    {"blend", LYTE_BLENDMODE_BLEND},
    {"add", LYTE_BLENDMODE_ADD},
    {"mod", LYTE_BLENDMODE_MOD},
    {"mul", LYTE_BLENDMODE_MUL},
    {NULL, -1},
};
EnumStrInt lyte_FilterMode_strings[] = {
    {"_invalid", LYTE_FILTERMODE__INVALID},
    {"nearest", LYTE_FILTERMODE_NEAREST},
    {"linear", LYTE_FILTERMODE_LINEAR},
    {NULL, -1},
};
EnumStrInt lyte_GamepadAxis_strings[] = {
    {"left_x", LYTE_GAMEPADAXIS_LEFT_X},
    {"left_y", LYTE_GAMEPADAXIS_LEFT_Y},
    {"right_x", LYTE_GAMEPADAXIS_RIGHT_X},
    {"right_y", LYTE_GAMEPADAXIS_RIGHT_Y},
    {"left_trigger", LYTE_GAMEPADAXIS_LEFT_TRIGGER},
    {"right_trigger", LYTE_GAMEPADAXIS_RIGHT_TRIGGER},
    {NULL, -1},
};
EnumStrInt lyte_GamepadButton_strings[] = {
    {"pad_a", LYTE_GAMEPADBUTTON_PAD_A},
    {"pad_b", LYTE_GAMEPADBUTTON_PAD_B},
    {"pad_x", LYTE_GAMEPADBUTTON_PAD_X},
    {"pad_y", LYTE_GAMEPADBUTTON_PAD_Y},
    {"left_bumper", LYTE_GAMEPADBUTTON_LEFT_BUMPER},
    {"right_bumper", LYTE_GAMEPADBUTTON_RIGHT_BUMPER},
    {"back", LYTE_GAMEPADBUTTON_BACK},
    {"start", LYTE_GAMEPADBUTTON_START},
    {"guide", LYTE_GAMEPADBUTTON_GUIDE},
    {"left_thumb", LYTE_GAMEPADBUTTON_LEFT_THUMB},
    {"right_thumb", LYTE_GAMEPADBUTTON_RIGHT_THUMB},
    {"dpad_up", LYTE_GAMEPADBUTTON_DPAD_UP},
    {"dpad_right", LYTE_GAMEPADBUTTON_DPAD_RIGHT},
    {"dpad_down", LYTE_GAMEPADBUTTON_DPAD_DOWN},
    {"dpad_left", LYTE_GAMEPADBUTTON_DPAD_LEFT},
    {NULL, -1},
};
EnumStrInt lyte_MouseButton_strings[] = {
    {"mb1", LYTE_MOUSEBUTTON_MB1},
    {"mb2", LYTE_MOUSEBUTTON_MB2},
    {"mb3", LYTE_MOUSEBUTTON_MB3},
    {"mb4", LYTE_MOUSEBUTTON_MB4},
    {"mb5", LYTE_MOUSEBUTTON_MB5},
    {"mb6", LYTE_MOUSEBUTTON_MB6},
    {"mb7", LYTE_MOUSEBUTTON_MB7},
    {"mb8", LYTE_MOUSEBUTTON_MB8},
    {NULL, -1},
};
EnumStrInt lyte_KeyboardKey_strings[] = {
    {"space", LYTE_KEYBOARDKEY_SPACE},
    {"\'", LYTE_KEYBOARDKEY_TICK},
    {",", LYTE_KEYBOARDKEY_COMMA},
    {"-", LYTE_KEYBOARDKEY_DASH},
    {".", LYTE_KEYBOARDKEY_PERIOD},
    {"/", LYTE_KEYBOARDKEY_SLASH},
    {"0", LYTE_KEYBOARDKEY_0},
    {"1", LYTE_KEYBOARDKEY_1},
    {"2", LYTE_KEYBOARDKEY_2},
    {"3", LYTE_KEYBOARDKEY_3},
    {"4", LYTE_KEYBOARDKEY_4},
    {"5", LYTE_KEYBOARDKEY_5},
    {"6", LYTE_KEYBOARDKEY_6},
    {"7", LYTE_KEYBOARDKEY_7},
    {"8", LYTE_KEYBOARDKEY_8},
    {"9", LYTE_KEYBOARDKEY_9},
    {";", LYTE_KEYBOARDKEY_SEMICOLON},
    {"=", LYTE_KEYBOARDKEY_EQUAL},
    {"a", LYTE_KEYBOARDKEY_A},
    {"b", LYTE_KEYBOARDKEY_B},
    {"c", LYTE_KEYBOARDKEY_C},
    {"d", LYTE_KEYBOARDKEY_D},
    {"e", LYTE_KEYBOARDKEY_E},
    {"f", LYTE_KEYBOARDKEY_F},
    {"g", LYTE_KEYBOARDKEY_G},
    {"h", LYTE_KEYBOARDKEY_H},
    {"i", LYTE_KEYBOARDKEY_I},
    {"j", LYTE_KEYBOARDKEY_J},
    {"k", LYTE_KEYBOARDKEY_K},
    {"l", LYTE_KEYBOARDKEY_L},
    {"m", LYTE_KEYBOARDKEY_M},
    {"n", LYTE_KEYBOARDKEY_N},
    {"o", LYTE_KEYBOARDKEY_O},
    {"p", LYTE_KEYBOARDKEY_P},
    {"q", LYTE_KEYBOARDKEY_Q},
    {"r", LYTE_KEYBOARDKEY_R},
    {"s", LYTE_KEYBOARDKEY_S},
    {"t", LYTE_KEYBOARDKEY_T},
    {"u", LYTE_KEYBOARDKEY_U},
    {"v", LYTE_KEYBOARDKEY_V},
    {"w", LYTE_KEYBOARDKEY_W},
    {"x", LYTE_KEYBOARDKEY_X},
    {"y", LYTE_KEYBOARDKEY_Y},
    {"z", LYTE_KEYBOARDKEY_Z},
    {"[", LYTE_KEYBOARDKEY_OPEN_BRACKET},
    {"\\", LYTE_KEYBOARDKEY_BACKSLASH},
    {"]", LYTE_KEYBOARDKEY_CLOSE_BRACKET},
    {"`", LYTE_KEYBOARDKEY_BACKTICK},
    {"world_1", LYTE_KEYBOARDKEY_WORLD_1},
    {"world_2", LYTE_KEYBOARDKEY_WORLD_2},
    {"escape", LYTE_KEYBOARDKEY_ESCAPE},
    {"enter", LYTE_KEYBOARDKEY_ENTER},
    {"tab", LYTE_KEYBOARDKEY_TAB},
    {"backspace", LYTE_KEYBOARDKEY_BACKSPACE},
    {"insert", LYTE_KEYBOARDKEY_INSERT},
    {"delete", LYTE_KEYBOARDKEY_DELETE},
    {"right", LYTE_KEYBOARDKEY_RIGHT},
    {"left", LYTE_KEYBOARDKEY_LEFT},
    {"down", LYTE_KEYBOARDKEY_DOWN},
    {"up", LYTE_KEYBOARDKEY_UP},
    {"page_up", LYTE_KEYBOARDKEY_PAGE_UP},
    {"page_down", LYTE_KEYBOARDKEY_PAGE_DOWN},
    {"home", LYTE_KEYBOARDKEY_HOME},
    {"end", LYTE_KEYBOARDKEY_END},
    {"caps_lock", LYTE_KEYBOARDKEY_CAPS_LOCK},
    {"scroll_lock", LYTE_KEYBOARDKEY_SCROLL_LOCK},
    {"num_lock", LYTE_KEYBOARDKEY_NUM_LOCK},
    {"print_screen", LYTE_KEYBOARDKEY_PRINT_SCREEN},
    {"pause", LYTE_KEYBOARDKEY_PAUSE},
    {"f1", LYTE_KEYBOARDKEY_F1},
    {"f2", LYTE_KEYBOARDKEY_F2},
    {"f3", LYTE_KEYBOARDKEY_F3},
    {"f4", LYTE_KEYBOARDKEY_F4},
    {"f5", LYTE_KEYBOARDKEY_F5},
    {"f6", LYTE_KEYBOARDKEY_F6},
    {"f7", LYTE_KEYBOARDKEY_F7},
    {"f8", LYTE_KEYBOARDKEY_F8},
    {"f9", LYTE_KEYBOARDKEY_F9},
    {"f10", LYTE_KEYBOARDKEY_F10},
    {"f11", LYTE_KEYBOARDKEY_F11},
    {"f12", LYTE_KEYBOARDKEY_F12},
    {"f13", LYTE_KEYBOARDKEY_F13},
    {"f14", LYTE_KEYBOARDKEY_F14},
    {"f15", LYTE_KEYBOARDKEY_F15},
    {"f16", LYTE_KEYBOARDKEY_F16},
    {"f17", LYTE_KEYBOARDKEY_F17},
    {"f18", LYTE_KEYBOARDKEY_F18},
    {"f19", LYTE_KEYBOARDKEY_F19},
    {"f20", LYTE_KEYBOARDKEY_F20},
    {"f21", LYTE_KEYBOARDKEY_F21},
    {"f22", LYTE_KEYBOARDKEY_F22},
    {"f23", LYTE_KEYBOARDKEY_F23},
    {"f24", LYTE_KEYBOARDKEY_F24},
    {"f25", LYTE_KEYBOARDKEY_F25},
    {"kp_0", LYTE_KEYBOARDKEY_KP_0},
    {"kp_1", LYTE_KEYBOARDKEY_KP_1},
    {"kp_2", LYTE_KEYBOARDKEY_KP_2},
    {"kp_3", LYTE_KEYBOARDKEY_KP_3},
    {"kp_4", LYTE_KEYBOARDKEY_KP_4},
    {"kp_5", LYTE_KEYBOARDKEY_KP_5},
    {"kp_6", LYTE_KEYBOARDKEY_KP_6},
    {"kp_7", LYTE_KEYBOARDKEY_KP_7},
    {"kp_8", LYTE_KEYBOARDKEY_KP_8},
    {"kp_9", LYTE_KEYBOARDKEY_KP_9},
    {"kp_decimal", LYTE_KEYBOARDKEY_KP_DECIMAL},
    {"kp_divide", LYTE_KEYBOARDKEY_KP_DIVIDE},
    {"kp_multiply", LYTE_KEYBOARDKEY_KP_MULTIPLY},
    {"kp_subtract", LYTE_KEYBOARDKEY_KP_SUBTRACT},
    {"kp_add", LYTE_KEYBOARDKEY_KP_ADD},
    {"kp_enter", LYTE_KEYBOARDKEY_KP_ENTER},
    {"kp_equal", LYTE_KEYBOARDKEY_KP_EQUAL},
    {"left_shift", LYTE_KEYBOARDKEY_LEFT_SHIFT},
    {"left_control", LYTE_KEYBOARDKEY_LEFT_CONTROL},
    {"left_alt", LYTE_KEYBOARDKEY_LEFT_ALT},
    {"left_super", LYTE_KEYBOARDKEY_LEFT_SUPER},
    {"right_shift", LYTE_KEYBOARDKEY_RIGHT_SHIFT},
    {"right_control", LYTE_KEYBOARDKEY_RIGHT_CONTROL},
    {"right_alt", LYTE_KEYBOARDKEY_RIGHT_ALT},
    {"right_super", LYTE_KEYBOARDKEY_RIGHT_SUPER},
    {"menu", LYTE_KEYBOARDKEY_MENU},
    {NULL, -1},
};
// quit: [-- ]
static int api_quit(lua_State *L) {
    (void)L;
    int _err = _quit();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// cls: [ number  number  number  number -- ]
static int api_cls(lua_State *L) {
    (void)L;
    double r = luaL_checknumber(L, 1);
    double g = luaL_checknumber(L, 2);
    double b = luaL_checknumber(L, 3);
    double a = luaL_checknumber(L, 4);
    int _err = _cls(r, g, b, a);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_color: [ number  number  number  number -- ]
static int api_set_color(lua_State *L) {
    (void)L;
    double r = luaL_checknumber(L, 1);
    double g = luaL_checknumber(L, 2);
    double b = luaL_checknumber(L, 3);
    double a = luaL_checknumber(L, 4);
    int _err = _set_color(r, g, b, a);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_color: [-- ]
static int api_reset_color(lua_State *L) {
    (void)L;
    int _err = _reset_color();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_point: [ number  number -- ]
static int api_draw_point(lua_State *L) {
    (void)L;
    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    int _err = _draw_point(x, y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_line: [ number  number  number  number -- ]
static int api_draw_line(lua_State *L) {
    (void)L;
    int x1 = luaL_checkinteger(L, 1);
    int y1 = luaL_checkinteger(L, 2);
    int x2 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);
    int _err = _draw_line(x1, y1, x2, y2);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_rect: [ number  number  number  number -- ]
static int api_draw_rect(lua_State *L) {
    (void)L;
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int rect_width = luaL_checkinteger(L, 3);
    int rect_height = luaL_checkinteger(L, 4);
    int _err = _draw_rect(dest_x, dest_y, rect_width, rect_height);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_rect_line: [ number  number  number  number -- ]
static int api_draw_rect_line(lua_State *L) {
    (void)L;
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int rect_width = luaL_checkinteger(L, 3);
    int rect_height = luaL_checkinteger(L, 4);
    int _err = _draw_rect_line(dest_x, dest_y, rect_width, rect_height);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_circle: [ number  number  number -- ]
static int api_draw_circle(lua_State *L) {
    (void)L;
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int radius = luaL_checkinteger(L, 3);
    int _err = _draw_circle(dest_x, dest_y, radius);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_circle_line: [ number  number  number -- ]
static int api_draw_circle_line(lua_State *L) {
    (void)L;
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int radius = luaL_checkinteger(L, 3);
    int _err = _draw_circle_line(dest_x, dest_y, radius);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// load_image: [ string --  userdata ] (ctor: true)
static int api_load_image(lua_State *L) {
    (void)L;
    const char * image_path = luaL_checkstring(L, 1);
    lyte_Image *val = lua_newuserdata(L, sizeof(lyte_Image));
    int _err = _load_image(image_path, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// draw_image: [ userdata  number  number -- ]
static int api_draw_image(lua_State *L) {
    (void)L;
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);
    int _err = _draw_image(*image, dest_x, dest_y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_image_rect: [ userdata  number  number  number  number  number  number -- ]
static int api_draw_image_rect(lua_State *L) {
    (void)L;
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);
    int src_x = luaL_checkinteger(L, 4);
    int src_y = luaL_checkinteger(L, 5);
    int rect_width = luaL_checkinteger(L, 6);
    int rect_height = luaL_checkinteger(L, 7);
    int _err = _draw_image_rect(*image, dest_x, dest_y, src_x, src_y, rect_width, rect_height);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_image_width: [ userdata --  number ]
static int api_get_image_width(lua_State *L) {
    (void)L;
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int val = {0};
    int _err = _get_image_width(*image, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_image_height: [ userdata --  number ]
static int api_get_image_height(lua_State *L) {
    (void)L;
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int val = {0};
    int _err = _get_image_height(*image, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// new_canvas: [ number  number --  userdata ] (ctor: true)
static int api_new_canvas(lua_State *L) {
    (void)L;
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);
    lyte_Image *val = lua_newuserdata(L, sizeof(lyte_Image));
    int _err = _new_canvas(width, height, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// set_canvas: [ userdata -- ]
static int api_set_canvas(lua_State *L) {
    (void)L;
    lyte_Image *canvas_image = luaL_checkudata(L, 1, "lyte.Image");
    // save this value to registry to prevent it from being GC'd
    lua_pushvalue(L, -1); // duplicate the object
    lua_setfield(L, LUA_REGISTRYINDEX, "lyte_canvas_image_SAVE");
    int _err = _set_canvas(*canvas_image);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_canvas: [-- ]
static int api_reset_canvas(lua_State *L) {
    (void)L;
    int _err = _reset_canvas();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_image_canvas: [ userdata --  boolean ]
static int api_is_image_canvas(lua_State *L) {
    (void)L;
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    bool val = {0};
    int _err = _is_image_canvas(*image, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// load_font: [ string  number --  userdata ] (ctor: true)
static int api_load_font(lua_State *L) {
    (void)L;
    const char * font_path = luaL_checkstring(L, 1);
    double size = luaL_checknumber(L, 2);
    lyte_Font *val = lua_newuserdata(L, sizeof(lyte_Font));
    int _err = _load_font(font_path, size, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Font");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// set_font: [ userdata -- ]
static int api_set_font(lua_State *L) {
    (void)L;
    lyte_Font *font = luaL_checkudata(L, 1, "lyte.Font");
    // save this value to registry to prevent it from being GC'd
    lua_pushvalue(L, -1); // duplicate the object
    lua_setfield(L, LUA_REGISTRYINDEX, "lyte_font_SAVE");
    int _err = _set_font(*font);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// draw_text: [ string  number  number -- ]
static int api_draw_text(lua_State *L) {
    (void)L;
    const char * text = luaL_checkstring(L, 1);
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);
    int _err = _draw_text(text, dest_x, dest_y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_text_width: [ string --  number ]
static int api_get_text_width(lua_State *L) {
    (void)L;
    const char * text = luaL_checkstring(L, 1);
    int val = {0};
    int _err = _get_text_width(text, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_text_height: [ string --  number ]
static int api_get_text_height(lua_State *L) {
    (void)L;
    const char * text = luaL_checkstring(L, 1);
    int val = {0};
    int _err = _get_text_height(text, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_monitor_count: [--  number ]
static int api_get_monitor_count(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_monitor_count(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_monitor_name: [ number --  string ]
static int api_get_monitor_name(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char * val = {0};
    int _err = _get_monitor_name(index, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushstring(L, val);
    return 1; // number of return values
}
// get_monitor_width: [ number --  number ]
static int api_get_monitor_width(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    int val = {0};
    int _err = _get_monitor_width(index, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_monitor_height: [ number --  number ]
static int api_get_monitor_height(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    int val = {0};
    int _err = _get_monitor_height(index, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// set_window_monitor: [ number -- ]
static int api_set_window_monitor(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    int _err = _set_window_monitor(index);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_resizable: [ boolean -- ]
static int api_set_window_resizable(lua_State *L) {
    (void)L;
    bool resizable = lua_toboolean(L, 1);
    int _err = _set_window_resizable(resizable);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_minsize: [ number  number -- ]
static int api_set_window_minsize(lua_State *L) {
    (void)L;
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);
    int _err = _set_window_minsize(width, height);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_size: [ number  number -- ]
static int api_set_window_size(lua_State *L) {
    (void)L;
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);
    int _err = _set_window_size(width, height);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_window_width: [--  number ]
static int api_get_window_width(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_window_width(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_window_height: [--  number ]
static int api_get_window_height(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_window_height(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// set_window_position: [ number  number -- ]
static int api_set_window_position(lua_State *L) {
    (void)L;
    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);
    int _err = _set_window_position(x, y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_fullscreen: [ boolean -- ]
static int api_set_fullscreen(lua_State *L) {
    (void)L;
    bool fullscreen = lua_toboolean(L, 1);
    int _err = _set_fullscreen(fullscreen);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_fullscreen: [--  boolean ]
static int api_is_fullscreen(lua_State *L) {
    (void)L;
    bool val = {0};
    int _err = _is_fullscreen(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// set_window_title: [ string -- ]
static int api_set_window_title(lua_State *L) {
    (void)L;
    const char * title = luaL_checkstring(L, 1);
    int _err = _set_window_title(title);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_vsync: [ boolean -- ]
static int api_set_window_vsync(lua_State *L) {
    (void)L;
    bool vsync = lua_toboolean(L, 1);
    int _err = _set_window_vsync(vsync);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_window_vsync: [--  boolean ]
static int api_is_window_vsync(lua_State *L) {
    (void)L;
    bool val = {0};
    int _err = _is_window_vsync(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// set_window_icon_file: [ string -- ]
static int api_set_window_icon_file(lua_State *L) {
    (void)L;
    const char * icon_path = luaL_checkstring(L, 1);
    int _err = _set_window_icon_file(icon_path);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_margins: [ number  number  number  number -- ]
static int api_set_window_margins(lua_State *L) {
    (void)L;
    int left = luaL_checkinteger(L, 1);
    int right = luaL_checkinteger(L, 2);
    int top = luaL_checkinteger(L, 3);
    int bottom = luaL_checkinteger(L, 4);
    int _err = _set_window_margins(left, right, top, bottom);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_window_paddings: [ number  number  number  number -- ]
static int api_set_window_paddings(lua_State *L) {
    (void)L;
    int left = luaL_checkinteger(L, 1);
    int right = luaL_checkinteger(L, 2);
    int top = luaL_checkinteger(L, 3);
    int bottom = luaL_checkinteger(L, 4);
    int _err = _set_window_paddings(left, right, top, bottom);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_key_down: [ string --  boolean ]
static int api_is_key_down(lua_State *L) {
    (void)L;
    const char *key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    bool val = {0};
    int _err = _is_key_down(key, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_key_pressed: [ string --  boolean ]
static int api_is_key_pressed(lua_State *L) {
    (void)L;
    const char *key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    bool val = {0};
    int _err = _is_key_pressed(key, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_key_released: [ string --  boolean ]
static int api_is_key_released(lua_State *L) {
    (void)L;
    const char *key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    bool val = {0};
    int _err = _is_key_released(key, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_key_repeat: [ string --  boolean ]
static int api_is_key_repeat(lua_State *L) {
    (void)L;
    const char *key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    bool val = {0};
    int _err = _is_key_repeat(key, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_mouse_down: [ string --  boolean ]
static int api_is_mouse_down(lua_State *L) {
    (void)L;
    const char *mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    bool val = {0};
    int _err = _is_mouse_down(mouse_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_mouse_pressed: [ string --  boolean ]
static int api_is_mouse_pressed(lua_State *L) {
    (void)L;
    const char *mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    bool val = {0};
    int _err = _is_mouse_pressed(mouse_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_mouse_released: [ string --  boolean ]
static int api_is_mouse_released(lua_State *L) {
    (void)L;
    const char *mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    bool val = {0};
    int _err = _is_mouse_released(mouse_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// get_mouse_x: [--  number ]
static int api_get_mouse_x(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_mouse_x(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_mouse_y: [--  number ]
static int api_get_mouse_y(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_mouse_y(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_gamepad_count: [--  number ]
static int api_get_gamepad_count(lua_State *L) {
    (void)L;
    int val = {0};
    int _err = _get_gamepad_count(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushinteger(L, val);
    return 1; // number of return values
}
// get_gamepad_name: [ number --  string ]
static int api_get_gamepad_name(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char * val = {0};
    int _err = _get_gamepad_name(index, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushstring(L, val);
    return 1; // number of return values
}
// is_gamepad_down: [ number  string --  boolean ]
static int api_is_gamepad_down(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char *gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    bool val = {0};
    int _err = _is_gamepad_down(index, gamepad_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_gamepad_pressed: [ number  string --  boolean ]
static int api_is_gamepad_pressed(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char *gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    bool val = {0};
    int _err = _is_gamepad_pressed(index, gamepad_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// is_gamepad_released: [ number  string --  boolean ]
static int api_is_gamepad_released(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char *gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    bool val = {0};
    int _err = _is_gamepad_released(index, gamepad_button, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// get_gamepad_axis: [ number  string --  number ]
static int api_get_gamepad_axis(lua_State *L) {
    (void)L;
    int index = luaL_checkinteger(L, 1);
    const char *gamepad_axis_str = luaL_checkstring(L, 2);
    lyte_GamepadAxis gamepad_axis = enumstring_to_int(lyte_GamepadAxis_strings, gamepad_axis_str);
    double val = {0};
    int _err = _get_gamepad_axis(index, gamepad_axis, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// set_mastervolume: [ number -- ]
static int api_set_mastervolume(lua_State *L) {
    (void)L;
    double mastervolume = luaL_checknumber(L, 1);
    int _err = _set_mastervolume(mastervolume);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_mastervolume: [--  number ]
static int api_get_mastervolume(lua_State *L) {
    (void)L;
    double val = {0};
    int _err = _get_mastervolume(&val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// load_music: [ string --  userdata ] (ctor: true)
static int api_load_music(lua_State *L) {
    (void)L;
    const char * music_path = luaL_checkstring(L, 1);
    lyte_Music *val = lua_newuserdata(L, sizeof(lyte_Music));
    int _err = _load_music(music_path, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Music");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// play_music: [ userdata -- ]
static int api_play_music(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // save this value to registry to prevent it from being GC'd
    lua_pushvalue(L, -1); // duplicate the object
    lua_setfield(L, LUA_REGISTRYINDEX, "lyte_music_SAVE");
    int _err = _play_music(*music);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// pause_music: [ userdata -- ]
static int api_pause_music(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    int _err = _pause_music(*music);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// resume_music: [ userdata -- ]
static int api_resume_music(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    int _err = _resume_music(*music);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// stop_music: [ userdata -- ]
static int api_stop_music(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    int _err = _stop_music(*music);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_music_playing: [ userdata --  boolean ]
static int api_is_music_playing(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    bool val = {0};
    int _err = _is_music_playing(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// get_music_length: [ userdata --  number ]
static int api_get_music_length(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double val = {0};
    int _err = _get_music_length(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// get_music_length_played: [ userdata --  number ]
static int api_get_music_length_played(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double val = {0};
    int _err = _get_music_length_played(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// seek_music: [ userdata  number -- ]
static int api_seek_music(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double secs = luaL_checknumber(L, 2);
    int _err = _seek_music(*music, secs);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_music_volume: [ userdata  number -- ]
static int api_set_music_volume(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double volume = luaL_checknumber(L, 2);
    int _err = _set_music_volume(*music, volume);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_music_pan: [ userdata  number -- ]
static int api_set_music_pan(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double pan = luaL_checknumber(L, 2);
    int _err = _set_music_pan(*music, pan);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_music_pitch: [ userdata  number -- ]
static int api_set_music_pitch(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double pitch = luaL_checknumber(L, 2);
    int _err = _set_music_pitch(*music, pitch);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_music_volume: [ userdata --  number ]
static int api_get_music_volume(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double val = {0};
    int _err = _get_music_volume(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// get_music_pan: [ userdata --  number ]
static int api_get_music_pan(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double val = {0};
    int _err = _get_music_pan(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// get_music_pitch: [ userdata --  number ]
static int api_get_music_pitch(lua_State *L) {
    (void)L;
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double val = {0};
    int _err = _get_music_pitch(*music, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// load_sound: [ string --  userdata ] (ctor: true)
static int api_load_sound(lua_State *L) {
    (void)L;
    const char * sound_path = luaL_checkstring(L, 1);
    lyte_Sound *val = lua_newuserdata(L, sizeof(lyte_Sound));
    int _err = _load_sound(sound_path, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Sound");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// clone_sound: [ userdata --  userdata ] (ctor: true)
static int api_clone_sound(lua_State *L) {
    (void)L;
    lyte_Sound *orig = luaL_checkudata(L, 1, "lyte.Sound");
    lyte_Sound *val = lua_newuserdata(L, sizeof(lyte_Sound));
    int _err = _clone_sound(*orig, val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Sound");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// play_sound: [ userdata -- ]
static int api_play_sound(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    int _err = _play_sound(*sound);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// pause_sound: [ userdata -- ]
static int api_pause_sound(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    int _err = _pause_sound(*sound);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// resume_sound: [ userdata -- ]
static int api_resume_sound(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    int _err = _resume_sound(*sound);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// stop_sound: [ userdata -- ]
static int api_stop_sound(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    int _err = _stop_sound(*sound);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// is_sound_playing: [ userdata --  boolean ]
static int api_is_sound_playing(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    bool val = {0};
    int _err = _is_sound_playing(*sound, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushboolean(L, val);
    return 1; // number of return values
}
// set_sound_volume: [ userdata  number -- ]
static int api_set_sound_volume(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double volume = luaL_checknumber(L, 2);
    int _err = _set_sound_volume(*sound, volume);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_sound_pan: [ userdata  number -- ]
static int api_set_sound_pan(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double pan = luaL_checknumber(L, 2);
    int _err = _set_sound_pan(*sound, pan);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_sound_pitch: [ userdata  number -- ]
static int api_set_sound_pitch(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double pitch = luaL_checknumber(L, 2);
    int _err = _set_sound_pitch(*sound, pitch);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// get_sound_volume: [ userdata --  number ]
static int api_get_sound_volume(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double val = {0};
    int _err = _get_sound_volume(*sound, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// get_sound_pan: [ userdata --  number ]
static int api_get_sound_pan(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double val = {0};
    int _err = _get_sound_pan(*sound, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// get_sound_pitch: [ userdata --  number ]
static int api_get_sound_pitch(lua_State *L) {
    (void)L;
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double val = {0};
    int _err = _get_sound_pitch(*sound, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushnumber(L, val);
    return 1; // number of return values
}
// load_textfile: [ string --  string ]
static int api_load_textfile(lua_State *L) {
    (void)L;
    const char * file_path = luaL_checkstring(L, 1);
    const char * val = {0};
    int _err = _load_textfile(file_path, &val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    lua_pushstring(L, val);
    return 1; // number of return values
}
// save_textfile: [ string  string -- ]
static int api_save_textfile(lua_State *L) {
    (void)L;
    const char * file_path = luaL_checkstring(L, 1);
    const char * data = luaL_checkstring(L, 2);
    int _err = _save_textfile(file_path, data);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// save_textfile_append: [ string  string -- ]
static int api_save_textfile_append(lua_State *L) {
    (void)L;
    const char * file_path = luaL_checkstring(L, 1);
    const char * data = luaL_checkstring(L, 2);
    int _err = _save_textfile_append(file_path, data);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// push_matrix: [-- ]
static int api_push_matrix(lua_State *L) {
    (void)L;
    int _err = _push_matrix();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// pop_matrix: [-- ]
static int api_pop_matrix(lua_State *L) {
    (void)L;
    int _err = _pop_matrix();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_matrix: [-- ]
static int api_reset_matrix(lua_State *L) {
    (void)L;
    int _err = _reset_matrix();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// translate: [ number  number -- ]
static int api_translate(lua_State *L) {
    (void)L;
    int delta_x = luaL_checkinteger(L, 1);
    int delta_y = luaL_checkinteger(L, 2);
    int _err = _translate(delta_x, delta_y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// rotate: [ number -- ]
static int api_rotate(lua_State *L) {
    (void)L;
    double angle = luaL_checknumber(L, 1);
    int _err = _rotate(angle);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// rotate_at: [ number  number  number -- ]
static int api_rotate_at(lua_State *L) {
    (void)L;
    double angle = luaL_checknumber(L, 1);
    int x = luaL_checkinteger(L, 2);
    int y = luaL_checkinteger(L, 3);
    int _err = _rotate_at(angle, x, y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// scale: [ number  number -- ]
static int api_scale(lua_State *L) {
    (void)L;
    double scale_x = luaL_checknumber(L, 1);
    double scale_y = luaL_checknumber(L, 2);
    int _err = _scale(scale_x, scale_y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// scale_at: [ number  number  number  number -- ]
static int api_scale_at(lua_State *L) {
    (void)L;
    int scale_x = luaL_checkinteger(L, 1);
    int scale_y = luaL_checkinteger(L, 2);
    double x = luaL_checknumber(L, 3);
    double y = luaL_checknumber(L, 4);
    int _err = _scale_at(scale_x, scale_y, x, y);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_default_blendmode: [ string -- ]
static int api_set_default_blendmode(lua_State *L) {
    (void)L;
    const char *blendmode_str = luaL_checkstring(L, 1);
    lyte_BlendMode blendmode = enumstring_to_int(lyte_BlendMode_strings, blendmode_str);
    int _err = _set_default_blendmode(blendmode);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_blendmode: [ string -- ]
static int api_set_blendmode(lua_State *L) {
    (void)L;
    const char *blendmode_str = luaL_checkstring(L, 1);
    lyte_BlendMode blendmode = enumstring_to_int(lyte_BlendMode_strings, blendmode_str);
    int _err = _set_blendmode(blendmode);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_blendmode: [-- ]
static int api_reset_blendmode(lua_State *L) {
    (void)L;
    int _err = _reset_blendmode();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_default_filtermode: [ string -- ]
static int api_set_default_filtermode(lua_State *L) {
    (void)L;
    const char *filtermode_str = luaL_checkstring(L, 1);
    lyte_FilterMode filtermode = enumstring_to_int(lyte_FilterMode_strings, filtermode_str);
    int _err = _set_default_filtermode(filtermode);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_filtermode: [ string -- ]
static int api_set_filtermode(lua_State *L) {
    (void)L;
    const char *filtermode_str = luaL_checkstring(L, 1);
    lyte_FilterMode filtermode = enumstring_to_int(lyte_FilterMode_strings, filtermode_str);
    int _err = _set_filtermode(filtermode);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_filtermode: [-- ]
static int api_reset_filtermode(lua_State *L) {
    (void)L;
    int _err = _reset_filtermode();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_shader: [ userdata -- ]
static int api_set_shader(lua_State *L) {
    (void)L;
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    int _err = _set_shader(*shader);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_shader: [-- ]
static int api_reset_shader(lua_State *L) {
    (void)L;
    int _err = _reset_shader();
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// set_shader_uniform: [ userdata  string  __UNKNOWN_one_of_lyte__ -- ]
static int api_set_shader_uniform(lua_State *L) {
    (void)L;
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    const char * uniform_name = luaL_checkstring(L, 2);
    lyte_ShaderUniformValue uniform_value = {0}; // WIP: uniform_value;
    int luatype_id = lua_type(L, 3);
    // opt: 0 -->  number, 3;
    if (luatype_id == 3) {
        uniform_value.which = 0;
        // TODO
        float val = luaL_checknumber(L, 3);
        uniform_value.options.float_val = val;
    }
    // opt: 1 -->  table, 5;
    if (luatype_id == 5) {
        uniform_value.which = 1;
        // TODO
        lyte_FloatVec4 *val = &(lyte_FloatVec4){0};
    // TABLE_tuple__FloatVec4::float Idx: 3 max: 4
    if (lua_type(L, 3) != LUA_TTABLE) { fprintf(stderr, "Expected table, got:%s\n", lua_typename(L, 3));  lua_error(L); }; // todo: push error info to stack
    size_t val_count_3 = lua_objlen(L, 3);
    if (val_count_3 > 4) { printf("Warning: too many items passed in the tuple. Ignoring extras"); val_count_3 = 4; }
    val->count = val_count_3;
    for (size_t i = 1; i <= val_count_3; i++) {
        // iterate
        lua_rawgeti(L, 3, i);
        float listval = luaL_checknumber(L, -1);
        lua_pop(L, 1);
        // insert into val...;
        val->data[i - 1] = listval;
    }
        uniform_value.options.vec_val = *val;
    }
    // opt: 2 -->  userdata, 7;
    if (luatype_id == 7) {
        uniform_value.which = 2;
        // TODO
        lyte_Image *val = luaL_checkudata(L, 3, "lyte.Image");
        uniform_value.options.sampler2D_val = *val;
    }
    int _err = _set_shader_uniform(*shader, uniform_name, uniform_value);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// reset_shader_uniform: [ userdata  string -- ]
static int api_reset_shader_uniform(lua_State *L) {
    (void)L;
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    const char * uniform_name = luaL_checkstring(L, 2);
    int _err = _reset_shader_uniform(*shader, uniform_name);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// new_shaderbuilder: [--  userdata ] (ctor: true)
static int api_new_shaderbuilder(lua_State *L) {
    (void)L;
    lyte_ShaderBuilder *val = lua_newuserdata(L, sizeof(lyte_ShaderBuilder));
    int _err = _new_shaderbuilder(val);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.ShaderBuilder");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}
// shaderbuilder_uniform: [ userdata  string  string -- ]
static int api_shaderbuilder_uniform(lua_State *L) {
    (void)L;
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * uniform_name = luaL_checkstring(L, 2);
    const char *uniform_type_str = luaL_checkstring(L, 3);
    lyte_UniformType uniform_type = enumstring_to_int(lyte_UniformType_strings, uniform_type_str);
    int _err = _shaderbuilder_uniform(*shaderbuilder, uniform_name, uniform_type);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// shaderbuilder_vertex: [ userdata  string -- ]
static int api_shaderbuilder_vertex(lua_State *L) {
    (void)L;
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * vertex_code = luaL_checkstring(L, 2);
    int _err = _shaderbuilder_vertex(*shaderbuilder, vertex_code);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// shaderbuilder_fragment: [ userdata  string -- ]
static int api_shaderbuilder_fragment(lua_State *L) {
    (void)L;
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * fragment_code = luaL_checkstring(L, 2);
    int _err = _shaderbuilder_fragment(*shaderbuilder, fragment_code);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    return 0; // number of return values
}
// shaderbuilder_build: [ userdata --  userdata ] (ctor: true)
static int api_shaderbuilder_build(lua_State *L) {
    (void)L;
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    lyte_Shader *shader = lua_newuserdata(L, sizeof(lyte_Shader));
    int _err = _shaderbuilder_build(*shaderbuilder, shader);
    (void)_err;  // TODO: handle '_err' in case it's not 0
    // constructed value is already on top of the stack
    luaL_getmetatable(L, "lyte.Shader");
    lua_setmetatable(L, -2);
    return 1; // number of return values
}

enum Image_keys_index {
    IDX_Image_width,
    IDX_Image_height,
    IDX_Image_is_canvas,
    IDX_COUNT_Image,
};
static const char *Image_keys[] = {
    "width",
    "height",
    "is_canvas",
    NULL,  // required sentinel
};
static int Image_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Image_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_Image_width: { api_get_image_width(L); } break;
        case IDX_Image_height: { api_get_image_height(L); } break;
        case IDX_Image_is_canvas: { api_is_image_canvas(L); } break;
    }
    return 1;
}
static int Image_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, Image_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int Image_metatable_tostring(lua_State *L) {
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    const char *str = _tostring_lyte_Image(image);
    lua_pushstring(L, str);
    return 1;
}
static int Image_metatable_gc(lua_State *L) {
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    _cleanup_lyte_Image(image);
    return 1;
}
static const struct luaL_Reg Image_metatable[] = {
    {"__index", Image_metatable_index },
    {"__newindex", Image_metatable_newindex },
    {"__tostring", Image_metatable_tostring },
    {"__gc", Image_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_Image_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.Image");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, Image_metatable);
    lua_settop(L, 0);
    return 0;
}
enum Font_keys_index {
    IDX_COUNT_Font,
};
static const char *Font_keys[] = {
    NULL,  // required sentinel
};
static int Font_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Font_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
    }
    return 1;
}
static int Font_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, Font_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int Font_metatable_tostring(lua_State *L) {
    lyte_Font *font = luaL_checkudata(L, 1, "lyte.Font");
    const char *str = _tostring_lyte_Font(font);
    lua_pushstring(L, str);
    return 1;
}
static int Font_metatable_gc(lua_State *L) {
    lyte_Font *font = luaL_checkudata(L, 1, "lyte.Font");
    _cleanup_lyte_Font(font);
    return 1;
}
static const struct luaL_Reg Font_metatable[] = {
    {"__index", Font_metatable_index },
    {"__newindex", Font_metatable_newindex },
    {"__tostring", Font_metatable_tostring },
    {"__gc", Font_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_Font_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.Font");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, Font_metatable);
    lua_settop(L, 0);
    return 0;
}
enum Music_keys_index {
    IDX_Music_playing,
    IDX_Music_length,
    IDX_Music_length_played,
    IDX_Music_pan,
    IDX_Music_pitch,
    IDX_Music_volume,
    IDX_Music_play,
    IDX_Music_pause,
    IDX_Music_resume,
    IDX_Music_stop,
    IDX_Music_seek,
    IDX_COUNT_Music,
};
static const char *Music_keys[] = {
    "playing",
    "length",
    "length_played",
    "pan",
    "pitch",
    "volume",
    "play",
    "pause",
    "resume",
    "stop",
    "seek",
    NULL,  // required sentinel
};
static int Music_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Music_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_Music_playing: { api_is_music_playing(L); } break;
        case IDX_Music_length: { api_get_music_length(L); } break;
        case IDX_Music_length_played: { api_get_music_length_played(L); } break;
        case IDX_Music_pan: { api_get_music_pan(L); } break;
        case IDX_Music_pitch: { api_get_music_pitch(L); } break;
        case IDX_Music_volume: { api_get_music_volume(L); } break;
        case IDX_Music_play: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "play_music"); lua_remove(L, -2); } break;
        case IDX_Music_pause: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "pause_music"); lua_remove(L, -2); } break;
        case IDX_Music_resume: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "resume_music"); lua_remove(L, -2); } break;
        case IDX_Music_stop: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "stop_music"); lua_remove(L, -2); } break;
        case IDX_Music_seek: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "seek_music"); lua_remove(L, -2); } break;
    }
    return 1;
}
static int Music_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, Music_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        case IDX_Music_pan: { api_set_music_pan(L); } break;
        case IDX_Music_pitch: { api_set_music_pitch(L); } break;
        case IDX_Music_volume: { api_set_music_volume(L); } break;
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int Music_metatable_tostring(lua_State *L) {
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    const char *str = _tostring_lyte_Music(music);
    lua_pushstring(L, str);
    return 1;
}
static int Music_metatable_gc(lua_State *L) {
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    _cleanup_lyte_Music(music);
    return 1;
}
static const struct luaL_Reg Music_metatable[] = {
    {"__index", Music_metatable_index },
    {"__newindex", Music_metatable_newindex },
    {"__tostring", Music_metatable_tostring },
    {"__gc", Music_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_Music_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.Music");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, Music_metatable);
    lua_settop(L, 0);
    return 0;
}
enum Sound_keys_index {
    IDX_Sound_pan,
    IDX_Sound_pitch,
    IDX_Sound_volume,
    IDX_Sound_clone,
    IDX_Sound_pause,
    IDX_Sound_play,
    IDX_Sound_resume,
    IDX_Sound_stop,
    IDX_COUNT_Sound,
};
static const char *Sound_keys[] = {
    "pan",
    "pitch",
    "volume",
    "clone",
    "pause",
    "play",
    "resume",
    "stop",
    NULL,  // required sentinel
};
static int Sound_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Sound_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_Sound_pan: { api_get_sound_pan(L); } break;
        case IDX_Sound_pitch: { api_get_sound_pitch(L); } break;
        case IDX_Sound_volume: { api_get_sound_volume(L); } break;
        case IDX_Sound_clone: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "clone_sound"); lua_remove(L, -2); } break;
        case IDX_Sound_pause: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "pause_sound"); lua_remove(L, -2); } break;
        case IDX_Sound_play: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "play_sound"); lua_remove(L, -2); } break;
        case IDX_Sound_resume: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "resume_sound"); lua_remove(L, -2); } break;
        case IDX_Sound_stop: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "stop_sound"); lua_remove(L, -2); } break;
    }
    return 1;
}
static int Sound_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, Sound_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        case IDX_Sound_pan: { api_set_sound_pan(L); } break;
        case IDX_Sound_pitch: { api_set_sound_pitch(L); } break;
        case IDX_Sound_volume: { api_set_sound_volume(L); } break;
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int Sound_metatable_tostring(lua_State *L) {
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    const char *str = _tostring_lyte_Sound(sound);
    lua_pushstring(L, str);
    return 1;
}
static int Sound_metatable_gc(lua_State *L) {
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    _cleanup_lyte_Sound(sound);
    return 1;
}
static const struct luaL_Reg Sound_metatable[] = {
    {"__index", Sound_metatable_index },
    {"__newindex", Sound_metatable_newindex },
    {"__tostring", Sound_metatable_tostring },
    {"__gc", Sound_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_Sound_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.Sound");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, Sound_metatable);
    lua_settop(L, 0);
    return 0;
}
enum Shader_keys_index {
    IDX_Shader_set,
    IDX_Shader_reset,
    IDX_COUNT_Shader,
};
static const char *Shader_keys[] = {
    "set",
    "reset",
    NULL,  // required sentinel
};
static int Shader_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Shader_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_Shader_set: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "set_shader_uniform"); lua_remove(L, -2); } break;
        case IDX_Shader_reset: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "reset_shader_uniform"); lua_remove(L, -2); } break;
    }
    return 1;
}
static int Shader_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, Shader_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int Shader_metatable_tostring(lua_State *L) {
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    const char *str = _tostring_lyte_Shader(shader);
    lua_pushstring(L, str);
    return 1;
}
static int Shader_metatable_gc(lua_State *L) {
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    _cleanup_lyte_Shader(shader);
    return 1;
}
static const struct luaL_Reg Shader_metatable[] = {
    {"__index", Shader_metatable_index },
    {"__newindex", Shader_metatable_newindex },
    {"__tostring", Shader_metatable_tostring },
    {"__gc", Shader_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_Shader_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.Shader");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, Shader_metatable);
    lua_settop(L, 0);
    return 0;
}
enum ShaderBuilder_keys_index {
    IDX_ShaderBuilder_uniform,
    IDX_ShaderBuilder_vertex,
    IDX_ShaderBuilder_fragment,
    IDX_ShaderBuilder_build,
    IDX_COUNT_ShaderBuilder,
};
static const char *ShaderBuilder_keys[] = {
    "uniform",
    "vertex",
    "fragment",
    "build",
    NULL,  // required sentinel
};
static int ShaderBuilder_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, ShaderBuilder_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_ShaderBuilder_uniform: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "shaderbuilder_uniform"); lua_remove(L, -2); } break;
        case IDX_ShaderBuilder_vertex: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "shaderbuilder_vertex"); lua_remove(L, -2); } break;
        case IDX_ShaderBuilder_fragment: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "shaderbuilder_fragment"); lua_remove(L, -2); } break;
        case IDX_ShaderBuilder_build: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "shaderbuilder_build"); lua_remove(L, -2); } break;
    }
    return 1;
}
static int ShaderBuilder_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, ShaderBuilder_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int ShaderBuilder_metatable_tostring(lua_State *L) {
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char *str = _tostring_lyte_ShaderBuilder(shaderbuilder);
    lua_pushstring(L, str);
    return 1;
}
static int ShaderBuilder_metatable_gc(lua_State *L) {
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    _cleanup_lyte_ShaderBuilder(shaderbuilder);
    return 1;
}
static const struct luaL_Reg ShaderBuilder_metatable[] = {
    {"__index", ShaderBuilder_metatable_index },
    {"__newindex", ShaderBuilder_metatable_newindex },
    {"__tostring", ShaderBuilder_metatable_tostring },
    {"__gc", ShaderBuilder_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_ShaderBuilder_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.ShaderBuilder");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, ShaderBuilder_metatable);
    lua_settop(L, 0);
    return 0;
}

static const struct luaL_Reg lyte_api_functions[] = {    {"quit", api_quit},
    {"cls", api_cls},
    {"set_color", api_set_color},
    {"reset_color", api_reset_color},
    {"draw_point", api_draw_point},
    {"draw_line", api_draw_line},
    {"draw_rect", api_draw_rect},
    {"draw_rect_line", api_draw_rect_line},
    {"draw_circle", api_draw_circle},
    {"draw_circle_line", api_draw_circle_line},
    {"load_image", api_load_image},
    {"draw_image", api_draw_image},
    {"draw_image_rect", api_draw_image_rect},
    {"get_image_width", api_get_image_width},
    {"get_image_height", api_get_image_height},
    {"new_canvas", api_new_canvas},
    {"set_canvas", api_set_canvas},
    {"reset_canvas", api_reset_canvas},
    {"is_image_canvas", api_is_image_canvas},
    {"load_font", api_load_font},
    {"set_font", api_set_font},
    {"draw_text", api_draw_text},
    {"get_text_width", api_get_text_width},
    {"get_text_height", api_get_text_height},
    {"get_monitor_count", api_get_monitor_count},
    {"get_monitor_name", api_get_monitor_name},
    {"get_monitor_width", api_get_monitor_width},
    {"get_monitor_height", api_get_monitor_height},
    {"set_window_monitor", api_set_window_monitor},
    {"set_window_resizable", api_set_window_resizable},
    {"set_window_minsize", api_set_window_minsize},
    {"set_window_size", api_set_window_size},
    {"get_window_width", api_get_window_width},
    {"get_window_height", api_get_window_height},
    {"set_window_position", api_set_window_position},
    {"set_fullscreen", api_set_fullscreen},
    {"is_fullscreen", api_is_fullscreen},
    {"set_window_title", api_set_window_title},
    {"set_window_vsync", api_set_window_vsync},
    {"is_window_vsync", api_is_window_vsync},
    {"set_window_icon_file", api_set_window_icon_file},
    {"set_window_margins", api_set_window_margins},
    {"set_window_paddings", api_set_window_paddings},
    {"is_key_down", api_is_key_down},
    {"is_key_pressed", api_is_key_pressed},
    {"is_key_released", api_is_key_released},
    {"is_key_repeat", api_is_key_repeat},
    {"is_mouse_down", api_is_mouse_down},
    {"is_mouse_pressed", api_is_mouse_pressed},
    {"is_mouse_released", api_is_mouse_released},
    {"get_mouse_x", api_get_mouse_x},
    {"get_mouse_y", api_get_mouse_y},
    {"get_gamepad_count", api_get_gamepad_count},
    {"get_gamepad_name", api_get_gamepad_name},
    {"is_gamepad_down", api_is_gamepad_down},
    {"is_gamepad_pressed", api_is_gamepad_pressed},
    {"is_gamepad_released", api_is_gamepad_released},
    {"get_gamepad_axis", api_get_gamepad_axis},
    {"set_mastervolume", api_set_mastervolume},
    {"get_mastervolume", api_get_mastervolume},
    {"load_music", api_load_music},
    {"play_music", api_play_music},
    {"pause_music", api_pause_music},
    {"resume_music", api_resume_music},
    {"stop_music", api_stop_music},
    {"is_music_playing", api_is_music_playing},
    {"get_music_length", api_get_music_length},
    {"get_music_length_played", api_get_music_length_played},
    {"seek_music", api_seek_music},
    {"set_music_volume", api_set_music_volume},
    {"set_music_pan", api_set_music_pan},
    {"set_music_pitch", api_set_music_pitch},
    {"get_music_volume", api_get_music_volume},
    {"get_music_pan", api_get_music_pan},
    {"get_music_pitch", api_get_music_pitch},
    {"load_sound", api_load_sound},
    {"clone_sound", api_clone_sound},
    {"play_sound", api_play_sound},
    {"pause_sound", api_pause_sound},
    {"resume_sound", api_resume_sound},
    {"stop_sound", api_stop_sound},
    {"is_sound_playing", api_is_sound_playing},
    {"set_sound_volume", api_set_sound_volume},
    {"set_sound_pan", api_set_sound_pan},
    {"set_sound_pitch", api_set_sound_pitch},
    {"get_sound_volume", api_get_sound_volume},
    {"get_sound_pan", api_get_sound_pan},
    {"get_sound_pitch", api_get_sound_pitch},
    {"load_textfile", api_load_textfile},
    {"save_textfile", api_save_textfile},
    {"save_textfile_append", api_save_textfile_append},
    {"push_matrix", api_push_matrix},
    {"pop_matrix", api_pop_matrix},
    {"reset_matrix", api_reset_matrix},
    {"translate", api_translate},
    {"rotate", api_rotate},
    {"rotate_at", api_rotate_at},
    {"scale", api_scale},
    {"scale_at", api_scale_at},
    {"set_default_blendmode", api_set_default_blendmode},
    {"set_blendmode", api_set_blendmode},
    {"reset_blendmode", api_reset_blendmode},
    {"set_default_filtermode", api_set_default_filtermode},
    {"set_filtermode", api_set_filtermode},
    {"reset_filtermode", api_reset_filtermode},
    {"set_shader", api_set_shader},
    {"reset_shader", api_reset_shader},
    {"set_shader_uniform", api_set_shader_uniform},
    {"reset_shader_uniform", api_reset_shader_uniform},
    {"new_shaderbuilder", api_new_shaderbuilder},
    {"shaderbuilder_uniform", api_shaderbuilder_uniform},
    {"shaderbuilder_vertex", api_shaderbuilder_vertex},
    {"shaderbuilder_fragment", api_shaderbuilder_fragment},
    {"shaderbuilder_build", api_shaderbuilder_build},
    {NULL, NULL}, // sentinel
};
static int luaopen_lyte_api_functions(lua_State *L) {
    luaL_register(L, "lyte", lyte_api_functions);
    lua_settop(L, 0);
    return 0;
}

int register_lyte(lua_State *L) {
    luaopen_lyte_api_functions(L);
    luaopen_Image_metatable(L);
    luaopen_Font_metatable(L);
    luaopen_Music_metatable(L);
    luaopen_Sound_metatable(L);
    luaopen_Shader_metatable(L);
    luaopen_ShaderBuilder_metatable(L);
    return 0;
}

// ---

//---------------------------------------------------------------------------------------
// EOF: This file is generated
