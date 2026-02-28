// generated -- do not edit
// ==== begin: api_lyte_core_gen.c ====

#include <lua.h>
#include <lauxlib.h>
#include <stdbool.h>
#include "api_lyte_core_gen.h"
#include "api_lyte_core.impl.c"

// lightuserdata  helper (modeled after luaL_check* functions in lauxlib.c)
static inline void *_checklightuserdata(lua_State *L, int narg) {
    void *ret = lua_touserdata(L, narg);
    if (ret == NULL && !lua_islightuserdata(L, narg)) {
        luaL_typerror(L, narg, lua_typename(L, LUA_TLIGHTUSERDATA));
    }
    return ret;
}

static inline size_t _checktable_getcount(lua_State *L, int narg) {
    if (lua_type(L, narg) != LUA_TTABLE) {
        fprintf(stderr, "Expected a list, got %s", lua_typename(L, narg));
        lua_error(L);
    }
    size_t cnt = lua_objlen(L, narg);
    return cnt;
}

// enum helpers
typedef struct EnumStrInt {
    const char *str;
    int value;
} EnumStrInt;

static int enumstring_to_int(EnumStrInt *vals, const char *str) {
    while (vals->str && (strcmp(str, vals->str)!=0)) vals++;
    return vals->value;
}
static const char *int_to_enumstring(EnumStrInt *vals, int ival) {
    while (vals->str && vals->value != ival) vals++;
    return vals->str;
}
EnumStrInt lyte_core_UniformType_strings[] = {
    {"_invalid", _UNIFORMTYPE__INVALID},
    {"float", _UNIFORMTYPE_FLOAT},
    {"vec2", _UNIFORMTYPE_VEC2},
    {"vec3", _UNIFORMTYPE_VEC3},
    {"vec4", _UNIFORMTYPE_VEC4},
    {"int", _UNIFORMTYPE_INT},
    {"ivec2", _UNIFORMTYPE_IVEC2},
    {"ivec3", _UNIFORMTYPE_IVEC3},
    {"ivec4", _UNIFORMTYPE_IVEC4},
    {"mat4", _UNIFORMTYPE_MAT4},
    {"sampler2D", _UNIFORMTYPE_SAMPLER2D},
    {NULL, -1},
};
EnumStrInt lyte_core_BlendMode_strings[] = {
    {"none", _BLENDMODE_NONE},
    {"blend", _BLENDMODE_BLEND},
    {"add", _BLENDMODE_ADD},
    {"mod", _BLENDMODE_MOD},
    {"mul", _BLENDMODE_MUL},
    {NULL, -1},
};
EnumStrInt lyte_core_FilterMode_strings[] = {
    {"nearest", _FILTERMODE_NEAREST},
    {"linear", _FILTERMODE_LINEAR},
    {NULL, -1},
};
EnumStrInt lyte_core_GamepadAxis_strings[] = {
    {"left_x", _GAMEPADAXIS_LEFT_X},
    {"left_y", _GAMEPADAXIS_LEFT_Y},
    {"right_x", _GAMEPADAXIS_RIGHT_X},
    {"right_y", _GAMEPADAXIS_RIGHT_Y},
    {"left_trigger", _GAMEPADAXIS_LEFT_TRIGGER},
    {"right_trigger", _GAMEPADAXIS_RIGHT_TRIGGER},
    {NULL, -1},
};
EnumStrInt lyte_core_GamepadButton_strings[] = {
    {"pad_a", _GAMEPADBUTTON_PAD_A},
    {"pad_b", _GAMEPADBUTTON_PAD_B},
    {"pad_x", _GAMEPADBUTTON_PAD_X},
    {"pad_y", _GAMEPADBUTTON_PAD_Y},
    {"left_bumper", _GAMEPADBUTTON_LEFT_BUMPER},
    {"right_bumper", _GAMEPADBUTTON_RIGHT_BUMPER},
    {"back", _GAMEPADBUTTON_BACK},
    {"start", _GAMEPADBUTTON_START},
    {"guide", _GAMEPADBUTTON_GUIDE},
    {"left_thumb", _GAMEPADBUTTON_LEFT_THUMB},
    {"right_thumb", _GAMEPADBUTTON_RIGHT_THUMB},
    {"dpad_up", _GAMEPADBUTTON_DPAD_UP},
    {"dpad_right", _GAMEPADBUTTON_DPAD_RIGHT},
    {"dpad_down", _GAMEPADBUTTON_DPAD_DOWN},
    {"dpad_left", _GAMEPADBUTTON_DPAD_LEFT},
    {NULL, -1},
};
EnumStrInt lyte_core_MouseButton_strings[] = {
    {"mb1", _MOUSEBUTTON_MB1},
    {"mb2", _MOUSEBUTTON_MB2},
    {"mb3", _MOUSEBUTTON_MB3},
    {"mb4", _MOUSEBUTTON_MB4},
    {"mb5", _MOUSEBUTTON_MB5},
    {"mb6", _MOUSEBUTTON_MB6},
    {"mb7", _MOUSEBUTTON_MB7},
    {"mb8", _MOUSEBUTTON_MB8},
    {"scrollup", _MOUSEBUTTON_SCROLLUP},
    {"scrolldown", _MOUSEBUTTON_SCROLLDOWN},
    {NULL, -1},
};
EnumStrInt lyte_core_KeyboardKey_strings[] = {
    {"space", _KEYBOARDKEY_SPACE},
    {"'", _KEYBOARDKEY_TICK},
    {",", _KEYBOARDKEY_COMMA},
    {"-", _KEYBOARDKEY_DASH},
    {".", _KEYBOARDKEY_PERIOD},
    {"/", _KEYBOARDKEY_SLASH},
    {"0", _KEYBOARDKEY_0},
    {"1", _KEYBOARDKEY_1},
    {"2", _KEYBOARDKEY_2},
    {"3", _KEYBOARDKEY_3},
    {"4", _KEYBOARDKEY_4},
    {"5", _KEYBOARDKEY_5},
    {"6", _KEYBOARDKEY_6},
    {"7", _KEYBOARDKEY_7},
    {"8", _KEYBOARDKEY_8},
    {"9", _KEYBOARDKEY_9},
    {";", _KEYBOARDKEY_SEMICOLON},
    {"=", _KEYBOARDKEY_EQUAL},
    {"a", _KEYBOARDKEY_A},
    {"b", _KEYBOARDKEY_B},
    {"c", _KEYBOARDKEY_C},
    {"d", _KEYBOARDKEY_D},
    {"e", _KEYBOARDKEY_E},
    {"f", _KEYBOARDKEY_F},
    {"g", _KEYBOARDKEY_G},
    {"h", _KEYBOARDKEY_H},
    {"i", _KEYBOARDKEY_I},
    {"j", _KEYBOARDKEY_J},
    {"k", _KEYBOARDKEY_K},
    {"l", _KEYBOARDKEY_L},
    {"m", _KEYBOARDKEY_M},
    {"n", _KEYBOARDKEY_N},
    {"o", _KEYBOARDKEY_O},
    {"p", _KEYBOARDKEY_P},
    {"q", _KEYBOARDKEY_Q},
    {"r", _KEYBOARDKEY_R},
    {"s", _KEYBOARDKEY_S},
    {"t", _KEYBOARDKEY_T},
    {"u", _KEYBOARDKEY_U},
    {"v", _KEYBOARDKEY_V},
    {"w", _KEYBOARDKEY_W},
    {"x", _KEYBOARDKEY_X},
    {"y", _KEYBOARDKEY_Y},
    {"z", _KEYBOARDKEY_Z},
    {"[", _KEYBOARDKEY_OPEN_BRACKET},
    {"\\", _KEYBOARDKEY_BACKSLASH},
    {"]", _KEYBOARDKEY_CLOSE_BRACKET},
    {"`", _KEYBOARDKEY_BACKTICK},
    {"world_1", _KEYBOARDKEY_WORLD_1},
    {"world_2", _KEYBOARDKEY_WORLD_2},
    {"escape", _KEYBOARDKEY_ESCAPE},
    {"enter", _KEYBOARDKEY_ENTER},
    {"tab", _KEYBOARDKEY_TAB},
    {"backspace", _KEYBOARDKEY_BACKSPACE},
    {"insert", _KEYBOARDKEY_INSERT},
    {"delete", _KEYBOARDKEY_DELETE},
    {"right", _KEYBOARDKEY_RIGHT},
    {"left", _KEYBOARDKEY_LEFT},
    {"down", _KEYBOARDKEY_DOWN},
    {"up", _KEYBOARDKEY_UP},
    {"page_up", _KEYBOARDKEY_PAGE_UP},
    {"page_down", _KEYBOARDKEY_PAGE_DOWN},
    {"home", _KEYBOARDKEY_HOME},
    {"end", _KEYBOARDKEY_END},
    {"caps_lock", _KEYBOARDKEY_CAPS_LOCK},
    {"scroll_lock", _KEYBOARDKEY_SCROLL_LOCK},
    {"num_lock", _KEYBOARDKEY_NUM_LOCK},
    {"print_screen", _KEYBOARDKEY_PRINT_SCREEN},
    {"pause", _KEYBOARDKEY_PAUSE},
    {"f1", _KEYBOARDKEY_F1},
    {"f2", _KEYBOARDKEY_F2},
    {"f3", _KEYBOARDKEY_F3},
    {"f4", _KEYBOARDKEY_F4},
    {"f5", _KEYBOARDKEY_F5},
    {"f6", _KEYBOARDKEY_F6},
    {"f7", _KEYBOARDKEY_F7},
    {"f8", _KEYBOARDKEY_F8},
    {"f9", _KEYBOARDKEY_F9},
    {"f10", _KEYBOARDKEY_F10},
    {"f11", _KEYBOARDKEY_F11},
    {"f12", _KEYBOARDKEY_F12},
    {"f13", _KEYBOARDKEY_F13},
    {"f14", _KEYBOARDKEY_F14},
    {"f15", _KEYBOARDKEY_F15},
    {"f16", _KEYBOARDKEY_F16},
    {"f17", _KEYBOARDKEY_F17},
    {"f18", _KEYBOARDKEY_F18},
    {"f19", _KEYBOARDKEY_F19},
    {"f20", _KEYBOARDKEY_F20},
    {"f21", _KEYBOARDKEY_F21},
    {"f22", _KEYBOARDKEY_F22},
    {"f23", _KEYBOARDKEY_F23},
    {"f24", _KEYBOARDKEY_F24},
    {"f25", _KEYBOARDKEY_F25},
    {"kp_0", _KEYBOARDKEY_KP_0},
    {"kp_1", _KEYBOARDKEY_KP_1},
    {"kp_2", _KEYBOARDKEY_KP_2},
    {"kp_3", _KEYBOARDKEY_KP_3},
    {"kp_4", _KEYBOARDKEY_KP_4},
    {"kp_5", _KEYBOARDKEY_KP_5},
    {"kp_6", _KEYBOARDKEY_KP_6},
    {"kp_7", _KEYBOARDKEY_KP_7},
    {"kp_8", _KEYBOARDKEY_KP_8},
    {"kp_9", _KEYBOARDKEY_KP_9},
    {"kp_decimal", _KEYBOARDKEY_KP_DECIMAL},
    {"kp_divide", _KEYBOARDKEY_KP_DIVIDE},
    {"kp_multiply", _KEYBOARDKEY_KP_MULTIPLY},
    {"kp_subtract", _KEYBOARDKEY_KP_SUBTRACT},
    {"kp_add", _KEYBOARDKEY_KP_ADD},
    {"kp_enter", _KEYBOARDKEY_KP_ENTER},
    {"kp_equal", _KEYBOARDKEY_KP_EQUAL},
    {"left_shift", _KEYBOARDKEY_LEFT_SHIFT},
    {"left_control", _KEYBOARDKEY_LEFT_CONTROL},
    {"left_alt", _KEYBOARDKEY_LEFT_ALT},
    {"left_super", _KEYBOARDKEY_LEFT_SUPER},
    {"right_shift", _KEYBOARDKEY_RIGHT_SHIFT},
    {"right_control", _KEYBOARDKEY_RIGHT_CONTROL},
    {"right_alt", _KEYBOARDKEY_RIGHT_ALT},
    {"right_super", _KEYBOARDKEY_RIGHT_SUPER},
    {"menu", _KEYBOARDKEY_MENU},
    {NULL, -1},
};

static int api_quit(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _quit();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_cls(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double r; double g; double b; double a;
    r = luaL_checknumber(L, 1);
    g = luaL_checknumber(L, 2);
    b = luaL_checknumber(L, 3);
    a = luaL_checknumber(L, 4);
    err = _cls(r, g, b, a);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_color(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double r; double g; double b; double a;
    r = luaL_checknumber(L, 1);
    g = luaL_checknumber(L, 2);
    b = luaL_checknumber(L, 3);
    a = luaL_checknumber(L, 4);
    err = _set_color(r, g, b, a);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_color(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_color();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_point(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    double x; double y;
    x = luaL_checknumber(L, 1);
    y = luaL_checknumber(L, 2);
    err = _draw_point(x, y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_line(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double x1; double y1; double x2; double y2;
    x1 = luaL_checknumber(L, 1);
    y1 = luaL_checknumber(L, 2);
    x2 = luaL_checknumber(L, 3);
    y2 = luaL_checknumber(L, 4);
    err = _draw_line(x1, y1, x2, y2);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_triangle(lua_State *L) { // arity: 6 => 0
    (void)L; int err = 0;
    double ax; double ay; double bx; double by; double cx; double cy;
    ax = luaL_checknumber(L, 1);
    ay = luaL_checknumber(L, 2);
    bx = luaL_checknumber(L, 3);
    by = luaL_checknumber(L, 4);
    cx = luaL_checknumber(L, 5);
    cy = luaL_checknumber(L, 6);
    err = _draw_triangle(ax, ay, bx, by, cx, cy);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_triangle_line(lua_State *L) { // arity: 6 => 0
    (void)L; int err = 0;
    double ax; double ay; double bx; double by; double cx; double cy;
    ax = luaL_checknumber(L, 1);
    ay = luaL_checknumber(L, 2);
    bx = luaL_checknumber(L, 3);
    by = luaL_checknumber(L, 4);
    cx = luaL_checknumber(L, 5);
    cy = luaL_checknumber(L, 6);
    err = _draw_triangle_line(ax, ay, bx, by, cx, cy);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_rect(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double rect_width; double rect_height;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    rect_width = luaL_checknumber(L, 3);
    rect_height = luaL_checknumber(L, 4);
    err = _draw_rect(dest_x, dest_y, rect_width, rect_height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_rect_line(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double rect_width; double rect_height;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    rect_width = luaL_checknumber(L, 3);
    rect_height = luaL_checknumber(L, 4);
    err = _draw_rect_line(dest_x, dest_y, rect_width, rect_height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_circle(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double radius;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    radius = luaL_checknumber(L, 3);
    err = _draw_circle(dest_x, dest_y, radius);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_circle_line(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double radius;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    radius = luaL_checknumber(L, 3);
    err = _draw_circle_line(dest_x, dest_y, radius);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_ellipse(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double radius_x; double radius_y;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    radius_x = luaL_checknumber(L, 3);
    radius_y = luaL_checknumber(L, 4);
    err = _draw_ellipse(dest_x, dest_y, radius_x, radius_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_ellipse_line(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double dest_x; double dest_y; double radius_x; double radius_y;
    dest_x = luaL_checknumber(L, 1);
    dest_y = luaL_checknumber(L, 2);
    radius_x = luaL_checknumber(L, 3);
    radius_y = luaL_checknumber(L, 4);
    err = _draw_ellipse_line(dest_x, dest_y, radius_x, radius_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *image;
    image = _checklightuserdata(L, 1);
    err = _image_cleanup(image);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_load(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *image_path; void *val;
    image_path = luaL_checkstring(L, 1);
    err = _image_load(image_path, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_image_draw(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    void *image; double dest_x; double dest_y;
    image = _checklightuserdata(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    err = _image_draw(image, dest_x, dest_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_draw_ex(lua_State *L) { // arity: 8 => 0
    (void)L; int err = 0;
    void *image; double dest_x; double dest_y; double angle; double origin_x; double origin_y; double scale_x; double scale_y;
    image = _checklightuserdata(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    angle = luaL_checknumber(L, 4);
    origin_x = luaL_checknumber(L, 5);
    origin_y = luaL_checknumber(L, 6);
    scale_x = luaL_checknumber(L, 7);
    scale_y = luaL_checknumber(L, 8);
    err = _image_draw_ex(image, dest_x, dest_y, angle, origin_x, origin_y, scale_x, scale_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_draw_rect(lua_State *L) { // arity: 7 => 0
    (void)L; int err = 0;
    void *image; double dest_x; double dest_y; double src_x; double src_y; double src_width; double src_height;
    image = _checklightuserdata(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    src_x = luaL_checknumber(L, 4);
    src_y = luaL_checknumber(L, 5);
    src_width = luaL_checknumber(L, 6);
    src_height = luaL_checknumber(L, 7);
    err = _image_draw_rect(image, dest_x, dest_y, src_x, src_y, src_width, src_height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_draw_rect_ex(lua_State *L) { // arity: 12 => 0
    (void)L; int err = 0;
    void *image; double dest_x; double dest_y; double src_x; double src_y; double src_width; double src_height; double angle; double origin_x; double origin_y; double scale_x; double scale_y;
    image = _checklightuserdata(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    src_x = luaL_checknumber(L, 4);
    src_y = luaL_checknumber(L, 5);
    src_width = luaL_checknumber(L, 6);
    src_height = luaL_checknumber(L, 7);
    angle = luaL_checknumber(L, 8);
    origin_x = luaL_checknumber(L, 9);
    origin_y = luaL_checknumber(L, 10);
    scale_x = luaL_checknumber(L, 11);
    scale_y = luaL_checknumber(L, 12);
    err = _image_draw_rect_ex(image, dest_x, dest_y, src_x, src_y, src_width, src_height, angle, origin_x, origin_y, scale_x, scale_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_get_width(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *image; int val;
    image = _checklightuserdata(L, 1);
    err = _image_get_width(image, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_image_get_height(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *image; int val;
    image = _checklightuserdata(L, 1);
    err = _image_get_height(image, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_image_new_canvas(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    int width; int height; void *val;
    width = luaL_checknumber(L, 1);
    height = luaL_checknumber(L, 2);
    err = _image_new_canvas(width, height, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_image_set_canvas(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *canvas_image;
    canvas_image = _checklightuserdata(L, 1);
    err = _image_set_canvas(canvas_image);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_canvas(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_canvas();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_image_is_canvas(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *image; bool val;
    image = _checklightuserdata(L, 1);
    err = _image_is_canvas(image, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_capture_image(lua_State *L) { // arity: 4 => 1
    (void)L; int err = 0;
    int x; int y; int w; int h; void *val;
    x = luaL_checknumber(L, 1);
    y = luaL_checknumber(L, 2);
    w = luaL_checknumber(L, 3);
    h = luaL_checknumber(L, 4);
    err = _capture_image(x, y, w, h, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_imagebatch_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *imagebatch;
    imagebatch = _checklightuserdata(L, 1);
    err = _imagebatch_cleanup(imagebatch);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_imagebatch_new(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *image; void *val;
    image = _checklightuserdata(L, 1);
    err = _imagebatch_new(image, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_imagebatch_reset(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *imagebatch;
    imagebatch = _checklightuserdata(L, 1);
    err = _imagebatch_reset(imagebatch);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_imagebatch_add_rect(lua_State *L) { // arity: 9 => 0
    (void)L; int err = 0;
    void *imagebatch; double dest_x; double dest_y; double dest_width; double dest_height; double src_x; double src_y; double src_width; double src_height;
    imagebatch = _checklightuserdata(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    dest_width = luaL_checknumber(L, 4);
    dest_height = luaL_checknumber(L, 5);
    src_x = luaL_checknumber(L, 6);
    src_y = luaL_checknumber(L, 7);
    src_width = luaL_checknumber(L, 8);
    src_height = luaL_checknumber(L, 9);
    err = _imagebatch_add_rect(imagebatch, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_imagebatch_get_rect_count(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *imagebatch; int val;
    imagebatch = _checklightuserdata(L, 1);
    err = _imagebatch_get_rect_count(imagebatch, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_imagebatch_draw(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *imagebatch;
    imagebatch = _checklightuserdata(L, 1);
    err = _imagebatch_draw(imagebatch);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_font_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *font;
    font = _checklightuserdata(L, 1);
    err = _font_cleanup(font);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_font_load(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    const char *font_path; double size; void *val;
    font_path = luaL_checkstring(L, 1);
    size = luaL_checknumber(L, 2);
    err = _font_load(font_path, size, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_font_set(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *font;
    font = _checklightuserdata(L, 1);
    err = _font_set(font);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_draw_text(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    const char *text; double dest_x; double dest_y;
    text = luaL_checkstring(L, 1);
    dest_x = luaL_checknumber(L, 2);
    dest_y = luaL_checknumber(L, 3);
    err = _draw_text(text, dest_x, dest_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_get_text_width(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *text; int val;
    text = luaL_checkstring(L, 1);
    err = _get_text_width(text, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_text_height(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *text; int val;
    text = luaL_checkstring(L, 1);
    err = _get_text_height(text, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_monitor_count(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_monitor_count(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_monitor_name(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    int index; const char *val = {0};
    index = luaL_checknumber(L, 1);
    err = _get_monitor_name(index, &val);
    lua_pushstring(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_monitor_width(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    int index; int val;
    index = luaL_checknumber(L, 1);
    err = _get_monitor_width(index, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_monitor_height(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    int index; int val;
    index = luaL_checknumber(L, 1);
    err = _get_monitor_height(index, &val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_set_window_monitor(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    int index;
    index = luaL_checknumber(L, 1);
    err = _set_window_monitor(index);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_resizable(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    bool resizable;
    resizable = lua_toboolean(L, 1);
    err = _set_window_resizable(resizable);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_minsize(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    int width; int height;
    width = luaL_checknumber(L, 1);
    height = luaL_checknumber(L, 2);
    err = _set_window_minsize(width, height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_size(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    int width; int height;
    width = luaL_checknumber(L, 1);
    height = luaL_checknumber(L, 2);
    err = _set_window_size(width, height);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_get_window_width(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_window_width(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_window_height(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_window_height(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_set_window_position(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    int x; int y;
    x = luaL_checknumber(L, 1);
    y = luaL_checknumber(L, 2);
    err = _set_window_position(x, y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_fullscreen(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    bool fullscreen;
    fullscreen = lua_toboolean(L, 1);
    err = _set_fullscreen(fullscreen);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_is_fullscreen(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    bool val;
    err = _is_fullscreen(&val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_set_window_title(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *title;
    title = luaL_checkstring(L, 1);
    err = _set_window_title(title);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_icon_file(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *icon_path;
    icon_path = luaL_checkstring(L, 1);
    err = _set_window_icon_file(icon_path);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_margins(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    int left; int right; int top; int bottom;
    left = luaL_checknumber(L, 1);
    right = luaL_checknumber(L, 2);
    top = luaL_checknumber(L, 3);
    bottom = luaL_checknumber(L, 4);
    err = _set_window_margins(left, right, top, bottom);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_window_paddings(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    int left; int right; int top; int bottom;
    left = luaL_checknumber(L, 1);
    right = luaL_checknumber(L, 2);
    top = luaL_checknumber(L, 3);
    bottom = luaL_checknumber(L, 4);
    err = _set_window_paddings(left, right, top, bottom);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_is_key_down(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *key_str; int key; bool val;
    key_str = luaL_checkstring(L, 1);
    key = enumstring_to_int(lyte_core_KeyboardKey_strings, key_str);
    err = _is_key_down(key, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_key_pressed(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *key_str; int key; bool val;
    key_str = luaL_checkstring(L, 1);
    key = enumstring_to_int(lyte_core_KeyboardKey_strings, key_str);
    err = _is_key_pressed(key, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_key_released(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *key_str; int key; bool val;
    key_str = luaL_checkstring(L, 1);
    key = enumstring_to_int(lyte_core_KeyboardKey_strings, key_str);
    err = _is_key_released(key, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_key_repeat(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *key_str; int key; bool val;
    key_str = luaL_checkstring(L, 1);
    key = enumstring_to_int(lyte_core_KeyboardKey_strings, key_str);
    err = _is_key_repeat(key, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_pressed_keys(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int *val; size_t val_count;
    err = _get_pressed_keys(&val, &val_count);
    lua_newtable(L);
    for (size_t i=0; i<val_count; i++) {
        lua_pushinteger(L, i+1);
        lua_pushstring(L, int_to_enumstring(lyte_core_KeyboardKey_strings, val[i]));
        lua_settable(L, -3);
    }
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_textinput(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    const char *val = {0};
    err = _get_textinput(&val);
    lua_pushstring(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_mouse_down(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *mouse_button_str; int mouse_button; bool val;
    mouse_button_str = luaL_checkstring(L, 1);
    mouse_button = enumstring_to_int(lyte_core_MouseButton_strings, mouse_button_str);
    err = _is_mouse_down(mouse_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_mouse_pressed(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *mouse_button_str; int mouse_button; bool val;
    mouse_button_str = luaL_checkstring(L, 1);
    mouse_button = enumstring_to_int(lyte_core_MouseButton_strings, mouse_button_str);
    err = _is_mouse_pressed(mouse_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_mouse_released(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *mouse_button_str; int mouse_button; bool val;
    mouse_button_str = luaL_checkstring(L, 1);
    mouse_button = enumstring_to_int(lyte_core_MouseButton_strings, mouse_button_str);
    err = _is_mouse_released(mouse_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_mouse_x(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_mouse_x(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_mouse_y(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_mouse_y(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_gamepad_count(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    int val;
    err = _get_gamepad_count(&val);
    lua_pushinteger(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_gamepad_name(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    int index; const char *val = {0};
    index = luaL_checknumber(L, 1);
    err = _get_gamepad_name(index, &val);
    lua_pushstring(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_gamepad_down(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    int index; const char *gamepad_button_str; int gamepad_button; bool val;
    index = luaL_checknumber(L, 1);
    gamepad_button_str = luaL_checkstring(L, 2);
    gamepad_button = enumstring_to_int(lyte_core_GamepadButton_strings, gamepad_button_str);
    err = _is_gamepad_down(index, gamepad_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_gamepad_pressed(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    int index; const char *gamepad_button_str; int gamepad_button; bool val;
    index = luaL_checknumber(L, 1);
    gamepad_button_str = luaL_checkstring(L, 2);
    gamepad_button = enumstring_to_int(lyte_core_GamepadButton_strings, gamepad_button_str);
    err = _is_gamepad_pressed(index, gamepad_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_is_gamepad_released(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    int index; const char *gamepad_button_str; int gamepad_button; bool val;
    index = luaL_checknumber(L, 1);
    gamepad_button_str = luaL_checkstring(L, 2);
    gamepad_button = enumstring_to_int(lyte_core_GamepadButton_strings, gamepad_button_str);
    err = _is_gamepad_released(index, gamepad_button, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_get_gamepad_axis(lua_State *L) { // arity: 2 => 1
    (void)L; int err = 0;
    int index; const char *gamepad_axis_str; int gamepad_axis; double val;
    index = luaL_checknumber(L, 1);
    gamepad_axis_str = luaL_checkstring(L, 2);
    gamepad_axis = enumstring_to_int(lyte_core_GamepadAxis_strings, gamepad_axis_str);
    err = _get_gamepad_axis(index, gamepad_axis, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_set_mastervolume(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    double mastervolume;
    mastervolume = luaL_checknumber(L, 1);
    err = _set_mastervolume(mastervolume);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_get_mastervolume(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    double val;
    err = _get_mastervolume(&val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *music;
    music = _checklightuserdata(L, 1);
    err = _music_cleanup(music);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_load(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *music_path; void *val;
    music_path = luaL_checkstring(L, 1);
    err = _music_load(music_path, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_play(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *music;
    music = _checklightuserdata(L, 1);
    err = _music_play(music);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_pause(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *music;
    music = _checklightuserdata(L, 1);
    err = _music_pause(music);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_resume(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *music;
    music = _checklightuserdata(L, 1);
    err = _music_resume(music);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_stop(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *music;
    music = _checklightuserdata(L, 1);
    err = _music_stop(music);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_is_playing(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; bool val;
    music = _checklightuserdata(L, 1);
    err = _music_is_playing(music, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_get_length(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; double val;
    music = _checklightuserdata(L, 1);
    err = _music_get_length(music, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_get_length_played(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; double val;
    music = _checklightuserdata(L, 1);
    err = _music_get_length_played(music, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_seek(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *music; double secs;
    music = _checklightuserdata(L, 1);
    secs = luaL_checknumber(L, 2);
    err = _music_seek(music, secs);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_set_volume(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *music; double volume;
    music = _checklightuserdata(L, 1);
    volume = luaL_checknumber(L, 2);
    err = _music_set_volume(music, volume);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_set_pan(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *music; double pan;
    music = _checklightuserdata(L, 1);
    pan = luaL_checknumber(L, 2);
    err = _music_set_pan(music, pan);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_set_pitch(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *music; double pitch;
    music = _checklightuserdata(L, 1);
    pitch = luaL_checknumber(L, 2);
    err = _music_set_pitch(music, pitch);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_music_get_volume(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; double val;
    music = _checklightuserdata(L, 1);
    err = _music_get_volume(music, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_get_pan(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; double val;
    music = _checklightuserdata(L, 1);
    err = _music_get_pan(music, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_music_get_pitch(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *music; double val;
    music = _checklightuserdata(L, 1);
    err = _music_get_pitch(music, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *sound;
    sound = _checklightuserdata(L, 1);
    err = _sound_cleanup(sound);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_load(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *sound_path; void *val;
    sound_path = luaL_checkstring(L, 1);
    err = _sound_load(sound_path, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_clone(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *orig; void *val;
    orig = _checklightuserdata(L, 1);
    err = _sound_clone(orig, &val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_play(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *sound;
    sound = _checklightuserdata(L, 1);
    err = _sound_play(sound);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_pause(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *sound;
    sound = _checklightuserdata(L, 1);
    err = _sound_pause(sound);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_resume(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *sound;
    sound = _checklightuserdata(L, 1);
    err = _sound_resume(sound);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_stop(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *sound;
    sound = _checklightuserdata(L, 1);
    err = _sound_stop(sound);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_is_playing(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *sound; bool val;
    sound = _checklightuserdata(L, 1);
    err = _sound_is_playing(sound, &val);
    lua_pushboolean(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_set_volume(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *sound; double volume;
    sound = _checklightuserdata(L, 1);
    volume = luaL_checknumber(L, 2);
    err = _sound_set_volume(sound, volume);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_set_pan(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *sound; double pan;
    sound = _checklightuserdata(L, 1);
    pan = luaL_checknumber(L, 2);
    err = _sound_set_pan(sound, pan);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_set_pitch(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *sound; double pitch;
    sound = _checklightuserdata(L, 1);
    pitch = luaL_checknumber(L, 2);
    err = _sound_set_pitch(sound, pitch);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_sound_get_volume(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *sound; double val;
    sound = _checklightuserdata(L, 1);
    err = _sound_get_volume(sound, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_get_pan(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *sound; double val;
    sound = _checklightuserdata(L, 1);
    err = _sound_get_pan(sound, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_sound_get_pitch(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *sound; double val;
    sound = _checklightuserdata(L, 1);
    err = _sound_get_pitch(sound, &val);
    lua_pushnumber(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_load_textfile(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    const char *file_path; const char *val = {0};
    file_path = luaL_checkstring(L, 1);
    err = _load_textfile(file_path, &val);
    lua_pushstring(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_save_textfile(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    const char *file_path; const char *data;
    file_path = luaL_checkstring(L, 1);
    data = luaL_checkstring(L, 2);
    err = _save_textfile(file_path, data);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_save_textfile_append(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    const char *file_path; const char *data;
    file_path = luaL_checkstring(L, 1);
    data = luaL_checkstring(L, 2);
    err = _save_textfile_append(file_path, data);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_push_matrix(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _push_matrix();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_pop_matrix(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _pop_matrix();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_matrix(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_matrix();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_translate(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    double delta_x; double delta_y;
    delta_x = luaL_checknumber(L, 1);
    delta_y = luaL_checknumber(L, 2);
    err = _translate(delta_x, delta_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_rotate(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    double angle;
    angle = luaL_checknumber(L, 1);
    err = _rotate(angle);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_rotate_at(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    double angle; double x; double y;
    angle = luaL_checknumber(L, 1);
    x = luaL_checknumber(L, 2);
    y = luaL_checknumber(L, 3);
    err = _rotate_at(angle, x, y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_scale(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    double scale_x; double scale_y;
    scale_x = luaL_checknumber(L, 1);
    scale_y = luaL_checknumber(L, 2);
    err = _scale(scale_x, scale_y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_scale_at(lua_State *L) { // arity: 4 => 0
    (void)L; int err = 0;
    double scale_x; double scale_y; double x; double y;
    scale_x = luaL_checknumber(L, 1);
    scale_y = luaL_checknumber(L, 2);
    x = luaL_checknumber(L, 3);
    y = luaL_checknumber(L, 4);
    err = _scale_at(scale_x, scale_y, x, y);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_default_blendmode(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *blendmode_str; int blendmode;
    blendmode_str = luaL_checkstring(L, 1);
    blendmode = enumstring_to_int(lyte_core_BlendMode_strings, blendmode_str);
    err = _set_default_blendmode(blendmode);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_blendmode(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *blendmode_str; int blendmode;
    blendmode_str = luaL_checkstring(L, 1);
    blendmode = enumstring_to_int(lyte_core_BlendMode_strings, blendmode_str);
    err = _set_blendmode(blendmode);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_blendmode(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_blendmode();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_default_filtermode(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *filtermode_str; int filtermode;
    filtermode_str = luaL_checkstring(L, 1);
    filtermode = enumstring_to_int(lyte_core_FilterMode_strings, filtermode_str);
    err = _set_default_filtermode(filtermode);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_set_filtermode(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    const char *filtermode_str; int filtermode;
    filtermode_str = luaL_checkstring(L, 1);
    filtermode = enumstring_to_int(lyte_core_FilterMode_strings, filtermode_str);
    err = _set_filtermode(filtermode);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_filtermode(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_filtermode();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shaderbuilder_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *shaderbuilder;
    shaderbuilder = _checklightuserdata(L, 1);
    err = _shaderbuilder_cleanup(shaderbuilder);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shaderbuilder_new(lua_State *L) { // arity: 0 => 1
    (void)L; int err = 0;
    void *val;
    err = _shaderbuilder_new(&val);
    lua_pushlightuserdata(L, val);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_shaderbuilder_uniform(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    void *shaderbuilder; const char *uniform_name; const char *uniform_type_str; int uniform_type;
    shaderbuilder = _checklightuserdata(L, 1);
    uniform_name = luaL_checkstring(L, 2);
    uniform_type_str = luaL_checkstring(L, 3);
    uniform_type = enumstring_to_int(lyte_core_UniformType_strings, uniform_type_str);
    err = _shaderbuilder_uniform(shaderbuilder, uniform_name, uniform_type);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shaderbuilder_vertex(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *shaderbuilder; const char *vertex_code;
    shaderbuilder = _checklightuserdata(L, 1);
    vertex_code = luaL_checkstring(L, 2);
    err = _shaderbuilder_vertex(shaderbuilder, vertex_code);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shaderbuilder_fragment(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *shaderbuilder; const char *fragment_code;
    shaderbuilder = _checklightuserdata(L, 1);
    fragment_code = luaL_checkstring(L, 2);
    err = _shaderbuilder_fragment(shaderbuilder, fragment_code);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shaderbuilder_build(lua_State *L) { // arity: 1 => 1
    (void)L; int err = 0;
    void *shaderbuilder; void *shader;
    shaderbuilder = _checklightuserdata(L, 1);
    err = _shaderbuilder_build(shaderbuilder, &shader);
    lua_pushlightuserdata(L, shader);
    (void)err; // TODO: handle when err is not 0
    return 1; // number of values returned in the stack
}
static int api_shader_cleanup(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *shader;
    shader = _checklightuserdata(L, 1);
    err = _shader_cleanup(shader);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shader_set(lua_State *L) { // arity: 1 => 0
    (void)L; int err = 0;
    void *shader;
    shader = _checklightuserdata(L, 1);
    err = _shader_set(shader);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_reset_shader(lua_State *L) { // arity: 0 => 0
    (void)L; int err = 0;
    err = _reset_shader();
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shader_set_uniform_float(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    void *shader; const char *uniform_name; float uniform_value;
    shader = _checklightuserdata(L, 1);
    uniform_name = luaL_checkstring(L, 2);
    uniform_value = luaL_checknumber(L, 3);
    err = _shader_set_uniform_float(shader, uniform_name, uniform_value);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shader_set_uniform_floatvec4(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    void *shader; const char *uniform_name; float uniform_value[4] = {0}; size_t uniform_value_count;
    shader = _checklightuserdata(L, 1);
    uniform_name = luaL_checkstring(L, 2);
    uniform_value_count = _checktable_getcount(L, 3);
    if (uniform_value_count > 4) {
        fprintf(stderr, "Exceeded max count for list: expected: %d but got: %d\n", 4, (int)uniform_value_count);
        lua_error(L);
    }
    for (size_t i=1; i<=uniform_value_count; i++) {
        lua_rawgeti(L, 3, i);
        float uniform_value_v = luaL_checknumber(L, -1);
        lua_pop(L, 1);
        uniform_value[i - 1] = uniform_value_v;
    }
    err = _shader_set_uniform_floatvec4(shader, uniform_name, uniform_value, uniform_value_count);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shader_set_uniform_image(lua_State *L) { // arity: 3 => 0
    (void)L; int err = 0;
    void *shader; const char *uniform_name; void *uniform_value;
    shader = _checklightuserdata(L, 1);
    uniform_name = luaL_checkstring(L, 2);
    uniform_value = _checklightuserdata(L, 3);
    err = _shader_set_uniform_image(shader, uniform_name, uniform_value);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}
static int api_shader_reset_uniform(lua_State *L) { // arity: 2 => 0
    (void)L; int err = 0;
    void *shader; const char *uniform_name;
    shader = _checklightuserdata(L, 1);
    uniform_name = luaL_checkstring(L, 2);
    err = _shader_reset_uniform(shader, uniform_name);
    (void)err; // TODO: handle when err is not 0
    return 0; // number of values returned in the stack
}

static const struct luaL_Reg lyte_core_api_functions[] = {
    {"quit", api_quit},
    {"cls", api_cls},
    {"set_color", api_set_color},
    {"reset_color", api_reset_color},
    {"draw_point", api_draw_point},
    {"draw_line", api_draw_line},
    {"draw_triangle", api_draw_triangle},
    {"draw_triangle_line", api_draw_triangle_line},
    {"draw_rect", api_draw_rect},
    {"draw_rect_line", api_draw_rect_line},
    {"draw_circle", api_draw_circle},
    {"draw_circle_line", api_draw_circle_line},
    {"draw_ellipse", api_draw_ellipse},
    {"draw_ellipse_line", api_draw_ellipse_line},
    {"image_cleanup", api_image_cleanup},
    {"image_load", api_image_load},
    {"image_draw", api_image_draw},
    {"image_draw_ex", api_image_draw_ex},
    {"image_draw_rect", api_image_draw_rect},
    {"image_draw_rect_ex", api_image_draw_rect_ex},
    {"image_get_width", api_image_get_width},
    {"image_get_height", api_image_get_height},
    {"image_new_canvas", api_image_new_canvas},
    {"image_set_canvas", api_image_set_canvas},
    {"reset_canvas", api_reset_canvas},
    {"image_is_canvas", api_image_is_canvas},
    {"capture_image", api_capture_image},
    {"imagebatch_cleanup", api_imagebatch_cleanup},
    {"imagebatch_new", api_imagebatch_new},
    {"imagebatch_reset", api_imagebatch_reset},
    {"imagebatch_add_rect", api_imagebatch_add_rect},
    {"imagebatch_get_rect_count", api_imagebatch_get_rect_count},
    {"imagebatch_draw", api_imagebatch_draw},
    {"font_cleanup", api_font_cleanup},
    {"font_load", api_font_load},
    {"font_set", api_font_set},
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
    {"set_window_icon_file", api_set_window_icon_file},
    {"set_window_margins", api_set_window_margins},
    {"set_window_paddings", api_set_window_paddings},
    {"is_key_down", api_is_key_down},
    {"is_key_pressed", api_is_key_pressed},
    {"is_key_released", api_is_key_released},
    {"is_key_repeat", api_is_key_repeat},
    {"get_pressed_keys", api_get_pressed_keys},
    {"get_textinput", api_get_textinput},
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
    {"music_cleanup", api_music_cleanup},
    {"music_load", api_music_load},
    {"music_play", api_music_play},
    {"music_pause", api_music_pause},
    {"music_resume", api_music_resume},
    {"music_stop", api_music_stop},
    {"music_is_playing", api_music_is_playing},
    {"music_get_length", api_music_get_length},
    {"music_get_length_played", api_music_get_length_played},
    {"music_seek", api_music_seek},
    {"music_set_volume", api_music_set_volume},
    {"music_set_pan", api_music_set_pan},
    {"music_set_pitch", api_music_set_pitch},
    {"music_get_volume", api_music_get_volume},
    {"music_get_pan", api_music_get_pan},
    {"music_get_pitch", api_music_get_pitch},
    {"sound_cleanup", api_sound_cleanup},
    {"sound_load", api_sound_load},
    {"sound_clone", api_sound_clone},
    {"sound_play", api_sound_play},
    {"sound_pause", api_sound_pause},
    {"sound_resume", api_sound_resume},
    {"sound_stop", api_sound_stop},
    {"sound_is_playing", api_sound_is_playing},
    {"sound_set_volume", api_sound_set_volume},
    {"sound_set_pan", api_sound_set_pan},
    {"sound_set_pitch", api_sound_set_pitch},
    {"sound_get_volume", api_sound_get_volume},
    {"sound_get_pan", api_sound_get_pan},
    {"sound_get_pitch", api_sound_get_pitch},
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
    {"shaderbuilder_cleanup", api_shaderbuilder_cleanup},
    {"shaderbuilder_new", api_shaderbuilder_new},
    {"shaderbuilder_uniform", api_shaderbuilder_uniform},
    {"shaderbuilder_vertex", api_shaderbuilder_vertex},
    {"shaderbuilder_fragment", api_shaderbuilder_fragment},
    {"shaderbuilder_build", api_shaderbuilder_build},
    {"shader_cleanup", api_shader_cleanup},
    {"shader_set", api_shader_set},
    {"reset_shader", api_reset_shader},
    {"shader_set_uniform_float", api_shader_set_uniform_float},
    {"shader_set_uniform_floatvec4", api_shader_set_uniform_floatvec4},
    {"shader_set_uniform_image", api_shader_set_uniform_image},
    {"shader_reset_uniform", api_shader_reset_uniform},
    {NULL, NULL} // sentinel
};

int register_lyte_core_api(lua_State *L) {
    luaL_register(L, "lyte_core", lyte_core_api_functions);
    lua_settop(L, 0);
    return 0;
}

// ==== end: api_lyte_core_gen.c ====
