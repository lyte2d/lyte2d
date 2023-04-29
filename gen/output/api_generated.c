// GENERATED
// (c) 2023 MG

// api surface: do not edit directly
// (use codegen to update this file)

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
// ---
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
    {"'", LYTE_KEYBOARDKEY_TICK},
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

// union helpers
// which will be set 0 to 3 for known values. -1 for error
static inline lyte_ShaderUniformValue _get_union_lyte_ShaderUniformValue(lua_State *L, int n, int *which) {
    lyte_ShaderUniformValue retval = {0};
    int value_type = lua_type(L, n);
    if (value_type == LUA_TNUMBER) {
        // handle LUA_TNUMBER
        retval.float_val = luaL_checknumber(L, n);
        *which = 0;
    }  else if (value_type == LUA_TTABLE) {
        // handle LUA_TTABLE
        *which = 1;
        // list. item type: float max count: 4;
        static float _buffer[4] = {0};
        int _count = 0;
        lua_pushnil(L); // needed for traversing;
        while (lua_next(L, -2) != 0) {
            _buffer[_count] = luaL_checknumber(L, -1); // value.  key if needed is at index -2
            _count++;
            lua_pop(L, 1);
            if (_count > 4) { printf("Too many items in the list. Expected: 4\n"); break; };
        }
        retval.float_list.values = _buffer;
        retval.float_list.count = _count;
    }  else if (value_type == LUA_TUSERDATA) {
        // handle LUA_TUSERDATA
        retval.image_val = *(lyte_Image *) luaL_checkudata(L, n, "lyte.Image");
        *which = 2;
    }  else {
        // handle: not matches
        *which = -1;
    }
    return retval;
}


// Handling lyte apis

// [ number number number number  --  ]
static int api_cls(lua_State *L) {
    (void)L;
    // arguments
    double r = luaL_checknumber(L, 1);
    double g = luaL_checknumber(L, 2);
    double b = luaL_checknumber(L, 3);
    double a = luaL_checknumber(L, 4);

    // implementation
    int err = _impl_cls(r, g, b, a);
    if (err != 0) {
        printf("Warning:  api_cls");
    }
    return 0;
}
// [ integer integer integer  --  ]
static int api_draw_circle(lua_State *L) {
    (void)L;
    // arguments
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int radius = luaL_checkinteger(L, 3);

    // implementation
    int err = _impl_draw_circle(dest_x, dest_y, radius);
    if (err != 0) {
        printf("Warning:  api_draw_circle");
    }
    return 0;
}
// [ integer integer integer  --  ]
static int api_draw_circle_line(lua_State *L) {
    (void)L;
    // arguments
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int radius = luaL_checkinteger(L, 3);

    // implementation
    int err = _impl_draw_circle_line(dest_x, dest_y, radius);
    if (err != 0) {
        printf("Warning:  api_draw_circle_line");
    }
    return 0;
}
// [ Image integer integer  --  ]
static int api_draw_image(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);

    // implementation
    int err = _impl_draw_image(*image, dest_x, dest_y);
    if (err != 0) {
        printf("Warning:  api_draw_image");
    }
    return 0;
}
// [ Image integer integer integer integer integer integer  --  ]
static int api_draw_image_rect(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);
    int src_x = luaL_checkinteger(L, 4);
    int src_y = luaL_checkinteger(L, 5);
    int rect_width = luaL_checkinteger(L, 6);
    int rect_height = luaL_checkinteger(L, 7);

    // implementation
    int err = _impl_draw_image_rect(*image, dest_x, dest_y, src_x, src_y, rect_width, rect_height);
    if (err != 0) {
        printf("Warning:  api_draw_image_rect");
    }
    return 0;
}
// [ integer integer integer integer  --  ]
static int api_draw_line(lua_State *L) {
    (void)L;
    // arguments
    int x1 = luaL_checkinteger(L, 1);
    int y1 = luaL_checkinteger(L, 2);
    int x2 = luaL_checkinteger(L, 3);
    int y2 = luaL_checkinteger(L, 4);

    // implementation
    int err = _impl_draw_line(x1, y1, x2, y2);
    if (err != 0) {
        printf("Warning:  api_draw_line");
    }
    return 0;
}
// [ integer integer  --  ]
static int api_draw_point(lua_State *L) {
    (void)L;
    // arguments
    int x = luaL_checkinteger(L, 1);
    int y = luaL_checkinteger(L, 2);

    // implementation
    int err = _impl_draw_point(x, y);
    if (err != 0) {
        printf("Warning:  api_draw_point");
    }
    return 0;
}
// [ integer integer integer integer  --  ]
static int api_draw_rect(lua_State *L) {
    (void)L;
    // arguments
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int rect_width = luaL_checkinteger(L, 3);
    int rect_height = luaL_checkinteger(L, 4);

    // implementation
    int err = _impl_draw_rect(dest_x, dest_y, rect_width, rect_height);
    if (err != 0) {
        printf("Warning:  api_draw_rect");
    }
    return 0;
}
// [ integer integer integer integer  --  ]
static int api_draw_rect_line(lua_State *L) {
    (void)L;
    // arguments
    int dest_x = luaL_checkinteger(L, 1);
    int dest_y = luaL_checkinteger(L, 2);
    int rect_width = luaL_checkinteger(L, 3);
    int rect_height = luaL_checkinteger(L, 4);

    // implementation
    int err = _impl_draw_rect_line(dest_x, dest_y, rect_width, rect_height);
    if (err != 0) {
        printf("Warning:  api_draw_rect_line");
    }
    return 0;
}
// [ string integer integer  --  ]
static int api_draw_text(lua_State *L) {
    (void)L;
    // arguments
    const char * text = luaL_checkstring(L, 1);
    int dest_x = luaL_checkinteger(L, 2);
    int dest_y = luaL_checkinteger(L, 3);

    // implementation
    int err = _impl_draw_text(text, dest_x, dest_y);
    if (err != 0) {
        printf("Warning:  api_draw_text");
    }
    return 0;
}
// [ integer GamepadAxis  -- number  ]
static int api_get_gamepad_axis(lua_State *L) {
    (void)L;
    // arguments
    int index = luaL_checkinteger(L, 1);
    const char * gamepad_axis_str = luaL_checkstring(L, 2);
    lyte_GamepadAxis  gamepad_axis = enumstring_to_int(lyte_GamepadAxis_strings, gamepad_axis_str);
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_gamepad_axis(index, gamepad_axis, &val);
    if (err != 0) {
        printf("Warning:  api_get_gamepad_axis");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [  -- integer  ]
static int api_get_gamepad_count(lua_State *L) {
    (void)L;
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_gamepad_count(&val);
    if (err != 0) {
        printf("Warning:  api_get_gamepad_count");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [ integer  -- string  ]
static int api_get_gamepad_name(lua_State *L) {
    (void)L;
    // arguments
    int index = luaL_checkinteger(L, 1);
    // return variables
    const char * val = {0};

    // implementation
    int err = _impl_get_gamepad_name(index, &val);
    if (err != 0) {
        printf("Warning:  api_get_gamepad_name");
    }
    lua_pushstring(L, val);
    return 1;
}
// [  -- number  ]
static int api_get_mastervolume(lua_State *L) {
    (void)L;
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_mastervolume(&val);
    if (err != 0) {
        printf("Warning:  api_get_mastervolume");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [  -- integer  ]
static int api_get_mouse_x(lua_State *L) {
    (void)L;
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_mouse_x(&val);
    if (err != 0) {
        printf("Warning:  api_get_mouse_x");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [  -- integer  ]
static int api_get_mouse_y(lua_State *L) {
    (void)L;
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_mouse_y(&val);
    if (err != 0) {
        printf("Warning:  api_get_mouse_y");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [ Music  -- number  ]
static int api_get_music_length(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_music_length(*music, &val);
    if (err != 0) {
        printf("Warning:  api_get_music_length");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Music  -- number  ]
static int api_get_music_length_played(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_music_length_played(*music, &val);
    if (err != 0) {
        printf("Warning:  api_get_music_length_played");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Music  -- number  ]
static int api_get_music_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_music_pan(*music, &val);
    if (err != 0) {
        printf("Warning:  api_get_music_pan");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Music  -- number  ]
static int api_get_music_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_music_pitch(*music, &val);
    if (err != 0) {
        printf("Warning:  api_get_music_pitch");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Music  -- number  ]
static int api_get_music_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_music_volume(*music, &val);
    if (err != 0) {
        printf("Warning:  api_get_music_volume");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Sound  -- number  ]
static int api_get_sound_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sound_pan(*sound, &val);
    if (err != 0) {
        printf("Warning:  api_get_sound_pan");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Sound  -- number  ]
static int api_get_sound_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sound_pitch(*sound, &val);
    if (err != 0) {
        printf("Warning:  api_get_sound_pitch");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ Sound  -- number  ]
static int api_get_sound_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sound_volume(*sound, &val);
    if (err != 0) {
        printf("Warning:  api_get_sound_volume");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ SoundData  -- number  ]
static int api_get_sounddata_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sounddata_pan(*sounddata, &val);
    if (err != 0) {
        printf("Warning:  api_get_sounddata_pan");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ SoundData  -- number  ]
static int api_get_sounddata_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sounddata_pitch(*sounddata, &val);
    if (err != 0) {
        printf("Warning:  api_get_sounddata_pitch");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ SoundData  -- number  ]
static int api_get_sounddata_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    // return variables
    double val = {0};

    // implementation
    int err = _impl_get_sounddata_volume(*sounddata, &val);
    if (err != 0) {
        printf("Warning:  api_get_sounddata_volume");
    }
    lua_pushnumber(L, val);
    return 1;
}
// [ string  -- integer  ]
static int api_get_text_width(lua_State *L) {
    (void)L;
    // arguments
    const char * text = luaL_checkstring(L, 1);
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_text_width(text, &val);
    if (err != 0) {
        printf("Warning:  api_get_text_width");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [ string  -- integer  ]
static int api_get_text_height(lua_State *L) {
    (void)L;
    // arguments
    const char * text = luaL_checkstring(L, 1);
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_text_height(text, &val);
    if (err != 0) {
        printf("Warning:  api_get_text_height");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [  -- integer  ]
static int api_get_window_width(lua_State *L) {
    (void)L;
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_window_width(&val);
    if (err != 0) {
        printf("Warning:  api_get_window_width");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [  -- integer  ]
static int api_get_window_height(lua_State *L) {
    (void)L;
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_window_height(&val);
    if (err != 0) {
        printf("Warning:  api_get_window_height");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [ Image  -- integer  ]
static int api_get_image_width(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_image_width(*image, &val);
    if (err != 0) {
        printf("Warning:  api_get_image_width");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [ Image  -- integer  ]
static int api_get_image_height(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    // return variables
    int val = {0};

    // implementation
    int err = _impl_get_image_height(*image, &val);
    if (err != 0) {
        printf("Warning:  api_get_image_height");
    }
    lua_pushinteger(L, val);
    return 1;
}
// [  -- boolean  ]
static int api_is_fullscreen(lua_State *L) {
    (void)L;
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_fullscreen(&val);
    if (err != 0) {
        printf("Warning:  api_is_fullscreen");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ integer GamepadButton  -- boolean  ]
static int api_is_gamepad_down(lua_State *L) {
    (void)L;
    // arguments
    int index = luaL_checkinteger(L, 1);
    const char * gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton  gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_gamepad_down(index, gamepad_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_gamepad_down");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ integer GamepadButton  -- boolean  ]
static int api_is_gamepad_pressed(lua_State *L) {
    (void)L;
    // arguments
    int index = luaL_checkinteger(L, 1);
    const char * gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton  gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_gamepad_pressed(index, gamepad_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_gamepad_pressed");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ integer GamepadButton  -- boolean  ]
static int api_is_gamepad_released(lua_State *L) {
    (void)L;
    // arguments
    int index = luaL_checkinteger(L, 1);
    const char * gamepad_button_str = luaL_checkstring(L, 2);
    lyte_GamepadButton  gamepad_button = enumstring_to_int(lyte_GamepadButton_strings, gamepad_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_gamepad_released(index, gamepad_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_gamepad_released");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ KeyboardKey  -- boolean  ]
static int api_is_key_down(lua_State *L) {
    (void)L;
    // arguments
    const char * key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey  key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_key_down(key, &val);
    if (err != 0) {
        printf("Warning:  api_is_key_down");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ KeyboardKey  -- boolean  ]
static int api_is_key_pressed(lua_State *L) {
    (void)L;
    // arguments
    const char * key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey  key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_key_pressed(key, &val);
    if (err != 0) {
        printf("Warning:  api_is_key_pressed");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ KeyboardKey  -- boolean  ]
static int api_is_key_released(lua_State *L) {
    (void)L;
    // arguments
    const char * key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey  key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_key_released(key, &val);
    if (err != 0) {
        printf("Warning:  api_is_key_released");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ KeyboardKey  -- boolean  ]
static int api_is_key_repeat(lua_State *L) {
    (void)L;
    // arguments
    const char * key_str = luaL_checkstring(L, 1);
    lyte_KeyboardKey  key = enumstring_to_int(lyte_KeyboardKey_strings, key_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_key_repeat(key, &val);
    if (err != 0) {
        printf("Warning:  api_is_key_repeat");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ MouseButton  -- boolean  ]
static int api_is_mouse_down(lua_State *L) {
    (void)L;
    // arguments
    const char * mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton  mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_mouse_down(mouse_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_mouse_down");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ MouseButton  -- boolean  ]
static int api_is_mouse_pressed(lua_State *L) {
    (void)L;
    // arguments
    const char * mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton  mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_mouse_pressed(mouse_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_mouse_pressed");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ MouseButton  -- boolean  ]
static int api_is_mouse_released(lua_State *L) {
    (void)L;
    // arguments
    const char * mouse_button_str = luaL_checkstring(L, 1);
    lyte_MouseButton  mouse_button = enumstring_to_int(lyte_MouseButton_strings, mouse_button_str);
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_mouse_released(mouse_button, &val);
    if (err != 0) {
        printf("Warning:  api_is_mouse_released");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ Music  -- boolean  ]
static int api_is_music_playing(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_music_playing(*music, &val);
    if (err != 0) {
        printf("Warning:  api_is_music_playing");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ Sound  -- boolean  ]
static int api_is_sound_playing(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_sound_playing(*sound, &val);
    if (err != 0) {
        printf("Warning:  api_is_sound_playing");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [  -- boolean  ]
static int api_is_window_vsync(lua_State *L) {
    (void)L;
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_window_vsync(&val);
    if (err != 0) {
        printf("Warning:  api_is_window_vsync");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ Image  -- boolean  ]
static int api_is_image_canvas(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *image = luaL_checkudata(L, 1, "lyte.Image");
    // return variables
    bool val = {0};

    // implementation
    int err = _impl_is_image_canvas(*image, &val);
    if (err != 0) {
        printf("Warning:  api_is_image_canvas");
    }
    lua_pushboolean(L, val);
    return 1;
}
// [ string  -- string  ]
static int api_load_file(lua_State *L) {
    (void)L;
    // arguments
    const char * file_path = luaL_checkstring(L, 1);
    // return variables
    const char * val = {0};

    // implementation
    int err = _impl_load_file(file_path, &val);
    if (err != 0) {
        printf("Warning:  api_load_file");
    }
    lua_pushstring(L, val);
    return 1;
}
// [ string number  -- Font  ]
static int api_load_font(lua_State *L) {
    (void)L;
    // arguments
    const char * font_path = luaL_checkstring(L, 1);
    double size = luaL_checknumber(L, 2);
    // return variables
    lyte_Font *val = lua_newuserdata(L, sizeof(lyte_Font));
    // implementation
    int err = _impl_ctor_load_font(font_path, size, val);
    if (err != 0) {
        printf("Warning:  api_load_font");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Font");
    lua_setmetatable(L, -2);
    return 1;
}
// [ string  -- Image  ]
static int api_load_image(lua_State *L) {
    (void)L;
    // arguments
    const char * image_path = luaL_checkstring(L, 1);
    // return variables
    lyte_Image *val = lua_newuserdata(L, sizeof(lyte_Image));
    // implementation
    int err = _impl_ctor_load_image(image_path, val);
    if (err != 0) {
        printf("Warning:  api_load_image");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);
    return 1;
}
// [ string  -- Music  ]
static int api_load_music(lua_State *L) {
    (void)L;
    // arguments
    const char * music_path = luaL_checkstring(L, 1);
    // return variables
    lyte_Music *val = lua_newuserdata(L, sizeof(lyte_Music));
    // implementation
    int err = _impl_ctor_load_music(music_path, val);
    if (err != 0) {
        printf("Warning:  api_load_music");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Music");
    lua_setmetatable(L, -2);
    return 1;
}
// [ string  -- SoundData  ]
static int api_load_sounddata(lua_State *L) {
    (void)L;
    // arguments
    const char * sounddata_path = luaL_checkstring(L, 1);
    // return variables
    lyte_SoundData *val = lua_newuserdata(L, sizeof(lyte_SoundData));
    // implementation
    int err = _impl_ctor_load_sounddata(sounddata_path, val);
    if (err != 0) {
        printf("Warning:  api_load_sounddata");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.SoundData");
    lua_setmetatable(L, -2);
    return 1;
}
// [ integer integer  -- Image  ]
static int api_new_canvas(lua_State *L) {
    (void)L;
    // arguments
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);
    // return variables
    lyte_Image *val = lua_newuserdata(L, sizeof(lyte_Image));
    // implementation
    int err = _impl_ctor_new_canvas(width, height, val);
    if (err != 0) {
        printf("Warning:  api_new_canvas");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Image");
    lua_setmetatable(L, -2);
    return 1;
}

// [ SoundData  -- Sound  ]
static int api_new_sound(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    // return variables
    lyte_Sound *val = lua_newuserdata(L, sizeof(lyte_Sound));
    // implementation
    int err = _impl_ctor_new_sound(*sounddata, val);
    if (err != 0) {
        printf("Warning:  api_new_sound");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Sound");
    lua_setmetatable(L, -2);
    return 1;
}
// [ Music  --  ]
static int api_pause_music(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");

    // implementation
    int err = _impl_pause_music(*music);
    if (err != 0) {
        printf("Warning:  api_pause_music");
    }
    return 0;
}
// [ Sound  --  ]
static int api_pause_sound(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");

    // implementation
    int err = _impl_pause_sound(*sound);
    if (err != 0) {
        printf("Warning:  api_pause_sound");
    }
    return 0;
}
// [ Music  --  ]
static int api_play_music(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");

    // implementation
    int err = _impl_play_music(*music);
    if (err != 0) {
        printf("Warning:  api_play_music");
    }
    return 0;
}
// [ Sound  --  ]
static int api_play_sound(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");

    // implementation
    int err = _impl_play_sound(*sound);
    if (err != 0) {
        printf("Warning:  api_play_sound");
    }
    return 0;
}
// [  --  ]
static int api_pop_matrix(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_pop_matrix();
    if (err != 0) {
        printf("Warning:  api_pop_matrix");
    }
    return 0;
}
// [  --  ]
static int api_push_matrix(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_push_matrix();
    if (err != 0) {
        printf("Warning:  api_push_matrix");
    }
    return 0;
}
// [  --  ]
static int api_quit(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_quit();
    if (err != 0) {
        printf("Warning:  api_quit");
    }
    return 0;
}
// [  --  ]
static int api_reset_blendmode(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_blendmode();
    if (err != 0) {
        printf("Warning:  api_reset_blendmode");
    }
    return 0;
}
// [  --  ]
static int api_reset_canvas(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_canvas();
    if (err != 0) {
        printf("Warning:  api_reset_canvas");
    }
    return 0;
}
// [  --  ]
static int api_reset_color(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_color();
    if (err != 0) {
        printf("Warning:  api_reset_color");
    }
    return 0;
}
// [  --  ]
static int api_reset_filtermode(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_filtermode();
    if (err != 0) {
        printf("Warning:  api_reset_filtermode");
    }
    return 0;
}
// [  --  ]
static int api_reset_font(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_font();
    if (err != 0) {
        printf("Warning:  api_reset_font");
    }
    return 0;
}
// [  --  ]
static int api_reset_matrix(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_matrix();
    if (err != 0) {
        printf("Warning:  api_reset_matrix");
    }
    return 0;
}
// [  --  ]
static int api_reset_shader(lua_State *L) {
    (void)L;

    // implementation
    int err = _impl_reset_shader();
    if (err != 0) {
        printf("Warning:  api_reset_shader");
    }
    return 0;
}
// [ Music  --  ]
static int api_resume_music(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");

    // implementation
    int err = _impl_resume_music(*music);
    if (err != 0) {
        printf("Warning:  api_resume_music");
    }
    return 0;
}
// [ Sound  --  ]
static int api_resume_sound(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");

    // implementation
    int err = _impl_resume_sound(*sound);
    if (err != 0) {
        printf("Warning:  api_resume_sound");
    }
    return 0;
}
// [ number  --  ]
static int api_rotate(lua_State *L) {
    (void)L;
    // arguments
    double angle = luaL_checknumber(L, 1);

    // implementation
    int err = _impl_rotate(angle);
    if (err != 0) {
        printf("Warning:  api_rotate");
    }
    return 0;
}
// [ number integer integer  --  ]
static int api_rotate_at(lua_State *L) {
    (void)L;
    // arguments
    double angle = luaL_checknumber(L, 1);
    int x = luaL_checkinteger(L, 2);
    int y = luaL_checkinteger(L, 3);

    // implementation
    int err = _impl_rotate_at(angle, x, y);
    if (err != 0) {
        printf("Warning:  api_rotate_at");
    }
    return 0;
}
// [ string string  --  ]
static int api_save_file_append(lua_State *L) {
    (void)L;
    // arguments
    const char * file_path = luaL_checkstring(L, 1);
    const char * data = luaL_checkstring(L, 2);

    // implementation
    int err = _impl_save_file_append(file_path, data);
    if (err != 0) {
        printf("Warning:  api_save_file_append");
    }
    return 0;
}
// [ string string  --  ]
static int api_save_file_write(lua_State *L) {
    (void)L;
    // arguments
    const char * file_path = luaL_checkstring(L, 1);
    const char * data = luaL_checkstring(L, 2);

    // implementation
    int err = _impl_save_file_write(file_path, data);
    if (err != 0) {
        printf("Warning:  api_save_file_write");
    }
    return 0;
}
// [ number number  --  ]
static int api_scale(lua_State *L) {
    (void)L;
    // arguments
    double scale_x = luaL_checknumber(L, 1);
    double scale_y = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_scale(scale_x, scale_y);
    if (err != 0) {
        printf("Warning:  api_scale");
    }
    return 0;
}
// [ integer integer number number  --  ]
static int api_scale_at(lua_State *L) {
    (void)L;
    // arguments
    int scale_x = luaL_checkinteger(L, 1);
    int scale_y = luaL_checkinteger(L, 2);
    double x = luaL_checknumber(L, 3);
    double y = luaL_checknumber(L, 4);

    // implementation
    int err = _impl_scale_at(scale_x, scale_y, x, y);
    if (err != 0) {
        printf("Warning:  api_scale_at");
    }
    return 0;
}
// [ Music number  --  ]
static int api_seek_music(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double secs = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_seek_music(*music, secs);
    if (err != 0) {
        printf("Warning:  api_seek_music");
    }
    return 0;
}
// [ BlendMode  --  ]
static int api_set_blendmode(lua_State *L) {
    (void)L;
    // arguments
    const char * blendmode_str = luaL_checkstring(L, 1);
    lyte_BlendMode  blendmode = enumstring_to_int(lyte_BlendMode_strings, blendmode_str);

    // implementation
    int err = _impl_set_blendmode(blendmode);
    if (err != 0) {
        printf("Warning:  api_set_blendmode");
    }
    return 0;
}
// [ Image  --  ]
static int api_set_canvas(lua_State *L) {
    (void)L;
    // arguments
    lyte_Image *canvas_image = luaL_checkudata(L, 1, "lyte.Image");

    // implementation
    int err = _impl_set_canvas(*canvas_image);
    if (err != 0) {
        printf("Warning:  api_set_canvas");
    }
    return 0;
}
// [ number number number number  --  ]
static int api_set_color(lua_State *L) {
    (void)L;
    // arguments
    double r = luaL_checknumber(L, 1);
    double g = luaL_checknumber(L, 2);
    double b = luaL_checknumber(L, 3);
    double a = luaL_checknumber(L, 4);

    // implementation
    int err = _impl_set_color(r, g, b, a);
    if (err != 0) {
        printf("Warning:  api_set_color");
    }
    return 0;
}
// [ BlendMode  --  ]
static int api_set_default_blendmode(lua_State *L) {
    (void)L;
    // arguments
    const char * blendmode_str = luaL_checkstring(L, 1);
    lyte_BlendMode  blendmode = enumstring_to_int(lyte_BlendMode_strings, blendmode_str);

    // implementation
    int err = _impl_set_default_blendmode(blendmode);
    if (err != 0) {
        printf("Warning:  api_set_default_blendmode");
    }
    return 0;
}
// [ FilterMode  --  ]
static int api_set_default_filtermode(lua_State *L) {
    (void)L;
    // arguments
    const char * filtermode_str = luaL_checkstring(L, 1);
    lyte_FilterMode  filtermode = enumstring_to_int(lyte_FilterMode_strings, filtermode_str);

    // implementation
    int err = _impl_set_default_filtermode(filtermode);
    if (err != 0) {
        printf("Warning:  api_set_default_filtermode");
    }
    return 0;
}
// [ FilterMode  --  ]
static int api_set_filtermode(lua_State *L) {
    (void)L;
    // arguments
    const char * filtermode_str = luaL_checkstring(L, 1);
    lyte_FilterMode  filtermode = enumstring_to_int(lyte_FilterMode_strings, filtermode_str);

    // implementation
    int err = _impl_set_filtermode(filtermode);
    if (err != 0) {
        printf("Warning:  api_set_filtermode");
    }
    return 0;
}
// [ Font  --  ]
static int api_set_font(lua_State *L) {
    (void)L;
    // arguments
    lyte_Font *font = luaL_checkudata(L, 1, "lyte.Font");

    // implementation
    int err = _impl_set_font(*font);
    if (err != 0) {
        printf("Warning:  api_set_font");
    }
    return 0;
}
// [ boolean  --  ]
static int api_set_fullscreen(lua_State *L) {
    (void)L;
    // arguments
    bool fullscreen = lua_toboolean(L, 1);

    // implementation
    int err = _impl_set_fullscreen(fullscreen);
    if (err != 0) {
        printf("Warning:  api_set_fullscreen");
    }
    return 0;
}
// [ number  --  ]
static int api_set_mastervolume(lua_State *L) {
    (void)L;
    // arguments
    double mastervolume = luaL_checknumber(L, 1);

    // implementation
    int err = _impl_set_mastervolume(mastervolume);
    if (err != 0) {
        printf("Warning:  api_set_mastervolume");
    }
    return 0;
}
// [ Music number  --  ]
static int api_set_music_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double pan = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_music_pan(*music, pan);
    if (err != 0) {
        printf("Warning:  api_set_music_pan");
    }
    return 0;
}
// [ Music number  --  ]
static int api_set_music_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double pitch = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_music_pitch(*music, pitch);
    if (err != 0) {
        printf("Warning:  api_set_music_pitch");
    }
    return 0;
}
// [ Music number  --  ]
static int api_set_music_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");
    double volume = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_music_volume(*music, volume);
    if (err != 0) {
        printf("Warning:  api_set_music_volume");
    }
    return 0;
}
// [ Shader  --  ]
static int api_set_shader(lua_State *L) {
    (void)L;
    // arguments
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");

    // implementation
    int err = _impl_set_shader(*shader);
    if (err != 0) {
        printf("Warning:  api_set_shader");
    }
    return 0;
}
// [ Sound number  --  ]
static int api_set_sound_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double pan = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sound_pan(*sound, pan);
    if (err != 0) {
        printf("Warning:  api_set_sound_pan");
    }
    return 0;
}
// [ Sound number  --  ]
static int api_set_sound_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double pitch = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sound_pitch(*sound, pitch);
    if (err != 0) {
        printf("Warning:  api_set_sound_pitch");
    }
    return 0;
}
// [ Sound number  --  ]
static int api_set_sound_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");
    double volume = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sound_volume(*sound, volume);
    if (err != 0) {
        printf("Warning:  api_set_sound_volume");
    }
    return 0;
}
// [ SoundData number  --  ]
static int api_set_sounddata_pan(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    double pan = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sounddata_pan(*sounddata, pan);
    if (err != 0) {
        printf("Warning:  api_set_sounddata_pan");
    }
    return 0;
}
// [ SoundData number  --  ]
static int api_set_sounddata_pitch(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    double pitch = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sounddata_pitch(*sounddata, pitch);
    if (err != 0) {
        printf("Warning:  api_set_sounddata_pitch");
    }
    return 0;
}
// [ SoundData number  --  ]
static int api_set_sounddata_volume(lua_State *L) {
    (void)L;
    // arguments
    lyte_SoundData *sounddata = luaL_checkudata(L, 1, "lyte.SoundData");
    double volume = luaL_checknumber(L, 2);

    // implementation
    int err = _impl_set_sounddata_volume(*sounddata, volume);
    if (err != 0) {
        printf("Warning:  api_set_sounddata_volume");
    }
    return 0;
}
// [ string  --  ]
static int api_set_window_icon(lua_State *L) {
    (void)L;
    // arguments
    const char * icon_path = luaL_checkstring(L, 1);

    // implementation
    int err = _impl_set_window_icon(icon_path);
    if (err != 0) {
        printf("Warning:  api_set_window_icon");
    }
    return 0;
}
// [ integer integer integer integer  --  ]
static int api_set_window_margins(lua_State *L) {
    (void)L;
    // arguments
    int left = luaL_checkinteger(L, 1);
    int right = luaL_checkinteger(L, 2);
    int top = luaL_checkinteger(L, 3);
    int bottom = luaL_checkinteger(L, 4);

    // implementation
    int err = _impl_set_window_margins(left, right, top, bottom);
    if (err != 0) {
        printf("Warning:  api_set_window_margins");
    }
    return 0;
}
// [ integer integer  --  ]
static int api_set_window_minsize(lua_State *L) {
    (void)L;
    // arguments
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);

    // implementation
    int err = _impl_set_window_minsize(width, height);
    if (err != 0) {
        printf("Warning:  api_set_window_minsize");
    }
    return 0;
}
// [ integer integer integer integer  --  ]
static int api_set_window_paddings(lua_State *L) {
    (void)L;
    // arguments
    int left = luaL_checkinteger(L, 1);
    int right = luaL_checkinteger(L, 2);
    int top = luaL_checkinteger(L, 3);
    int bottom = luaL_checkinteger(L, 4);

    // implementation
    int err = _impl_set_window_paddings(left, right, top, bottom);
    if (err != 0) {
        printf("Warning:  api_set_window_paddings");
    }
    return 0;
}
// [ integer integer  --  ]
static int api_set_window_size(lua_State *L) {
    (void)L;
    // arguments
    int width = luaL_checkinteger(L, 1);
    int height = luaL_checkinteger(L, 2);

    // implementation
    int err = _impl_set_window_size(width, height);
    if (err != 0) {
        printf("Warning:  api_set_window_size");
    }
    return 0;
}
// [ string  --  ]
static int api_set_window_title(lua_State *L) {
    (void)L;
    // arguments
    const char * title = luaL_checkstring(L, 1);

    // implementation
    int err = _impl_set_window_title(title);
    if (err != 0) {
        printf("Warning:  api_set_window_title");
    }
    return 0;
}
// [ boolean  --  ]
static int api_set_window_vsync(lua_State *L) {
    (void)L;
    // arguments
    bool vsync = lua_toboolean(L, 1);

    // implementation
    int err = _impl_set_window_vsync(vsync);
    if (err != 0) {
        printf("Warning:  api_set_window_vsync");
    }
    return 0;
}
// [ Music  --  ]
static int api_stop_music(lua_State *L) {
    (void)L;
    // arguments
    lyte_Music *music = luaL_checkudata(L, 1, "lyte.Music");

    // implementation
    int err = _impl_stop_music(*music);
    if (err != 0) {
        printf("Warning:  api_stop_music");
    }
    return 0;
}
// [ Sound  --  ]
static int api_stop_sound(lua_State *L) {
    (void)L;
    // arguments
    lyte_Sound *sound = luaL_checkudata(L, 1, "lyte.Sound");

    // implementation
    int err = _impl_stop_sound(*sound);
    if (err != 0) {
        printf("Warning:  api_stop_sound");
    }
    return 0;
}
// [ integer integer  --  ]
static int api_translate(lua_State *L) {
    (void)L;
    // arguments
    int delta_x = luaL_checkinteger(L, 1);
    int delta_y = luaL_checkinteger(L, 2);

    // implementation
    int err = _impl_translate(delta_x, delta_y);
    if (err != 0) {
        printf("Warning:  api_translate");
    }
    return 0;
}
// [  -- ShaderBuilder  ]
static int api_new_shaderbuilder(lua_State *L) {
    (void)L;
    // return variables
    lyte_ShaderBuilder *val = lua_newuserdata(L, sizeof(lyte_ShaderBuilder));
    // implementation
    int err = _impl_ctor_new_shaderbuilder(val);
    if (err != 0) {
        printf("Warning:  api_new_shaderbuilder");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.ShaderBuilder");
    lua_setmetatable(L, -2);
    return 1;
}
// [ ShaderBuilder string UniformType  --  ]
static int api_shaderbuilder_uniform(lua_State *L) {
    (void)L;
    // arguments
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * uniform_name = luaL_checkstring(L, 2);
    const char * uniform_type_str = luaL_checkstring(L, 3);
    lyte_UniformType  uniform_type = enumstring_to_int(lyte_UniformType_strings, uniform_type_str);

    // implementation
    int err = _impl_shaderbuilder_uniform(*shaderbuilder, uniform_name, uniform_type);
    if (err != 0) {
        printf("Warning:  api_shaderbuilder_uniform");
    }
    return 0;
}
// [ ShaderBuilder string  --  ]
static int api_shaderbuilder_vertex(lua_State *L) {
    (void)L;
    // arguments
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * vertex_code = luaL_checkstring(L, 2);

    // implementation
    int err = _impl_shaderbuilder_vertex(*shaderbuilder, vertex_code);
    if (err != 0) {
        printf("Warning:  api_shaderbuilder_vertex");
    }
    return 0;
}
// [ ShaderBuilder string  --  ]
static int api_shaderbuilder_fragment(lua_State *L) {
    (void)L;
    // arguments
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char * fragment_code = luaL_checkstring(L, 2);

    // implementation
    int err = _impl_shaderbuilder_fragment(*shaderbuilder, fragment_code);
    if (err != 0) {
        printf("Warning:  api_shaderbuilder_fragment");
    }
    return 0;
}
// [ ShaderBuilder  -- Shader  ]
static int api_shaderbuilder_build(lua_State *L) {
    (void)L;
    // arguments
    lyte_ShaderBuilder *shaderbuilder = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    // return variables
    lyte_Shader *shader = lua_newuserdata(L, sizeof(lyte_Shader));
    // implementation
    int err = _impl_ctor_shaderbuilder_build(*shaderbuilder, shader);
    if (err != 0) {
        printf("Warning:  api_shaderbuilder_build");
    }
    // new value already on top of the stack
    luaL_getmetatable(L, "lyte.Shader");
    lua_setmetatable(L, -2);
    return 1;
}
// [ Shader string ShaderUniformValue  --  ]
static int api_send_shader_uniform(lua_State *L) {
    (void)L;
    // arguments
    lyte_Shader *shader = luaL_checkudata(L, 1, "lyte.Shader");
    const char * uniform_name = luaL_checkstring(L, 2);
    int which_uniform_value;
    lyte_ShaderUniformValue uniform_value = _get_union_lyte_ShaderUniformValue(L, 3, &which_uniform_value);

    // implementation
    int err = _impl_send_shader_uniform(*shader, uniform_name, uniform_value, which_uniform_value);
    if (err != 0) {
        printf("Warning:  api_send_shader_uniform");
    }
    return 0;
}

// record ShaderBuilder
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
    // lyte_ShaderBuilder *val = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    const char *str = "[lyte.ShaderBuilder]";
    lua_pushstring(L, str);
    return 1;
}
static int ShaderBuilder_metatable_gc(lua_State *L) {
    lyte_ShaderBuilder *val = luaL_checkudata(L, 1, "lyte.ShaderBuilder");
    _destroy_lyte_ShaderBuilder(val);
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
// record ShaderBuilder done


// record Shader
enum Shader_keys_index {
    IDX_Shader_send,
    IDX_COUNT_Shader,
};
static const char *Shader_keys[] = {
    "send",
    NULL,  // required sentinel
};
static int Shader_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, Shader_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_Shader_send: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "send_shader_uniform"); lua_remove(L, -2); } break;
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
    // lyte_Shader *val = luaL_checkudata(L, 1, "lyte.Shader");
    const char *str = "[lyte.Shader]";
    lua_pushstring(L, str);
    return 1;
}
static int Shader_metatable_gc(lua_State *L) {
    lyte_Shader *val = luaL_checkudata(L, 1, "lyte.Shader");
    _destroy_lyte_Shader(val);
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
// record Shader done

// record Image
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
    // lyte_Image *val = luaL_checkudata(L, 1, "lyte.Image");
    const char *str = "[lyte.Image]";
    lua_pushstring(L, str);
    return 1;
}
static int Image_metatable_gc(lua_State *L) {
    lyte_Image *val = luaL_checkudata(L, 1, "lyte.Image");
    _destroy_lyte_Image(val);
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
// record Image done

// record Font
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
    // lyte_Font *val = luaL_checkudata(L, 1, "lyte.Font");
    const char *str = "[lyte.Font]";
    lua_pushstring(L, str);
    return 1;
}
static int Font_metatable_gc(lua_State *L) {
    lyte_Font *val = luaL_checkudata(L, 1, "lyte.Font");
    _destroy_lyte_Font(val);
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
// record Font done

// record Music
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
        case IDX_Music_resume: { lua_getglobal(L, "lyte"); lua_getfield(L, -1, "resume _music"); lua_remove(L, -2); } break;
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
    // lyte_Music *val = luaL_checkudata(L, 1, "lyte.Music");
    const char *str = "[lyte.Music]";
    lua_pushstring(L, str);
    return 1;
}
static int Music_metatable_gc(lua_State *L) {
    lyte_Music *val = luaL_checkudata(L, 1, "lyte.Music");
    _destroy_lyte_Music(val);
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
// record Music done

// record Sound
enum Sound_keys_index {
    IDX_Sound_pan,
    IDX_Sound_pitch,
    IDX_Sound_volume,
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
    // lyte_Sound *val = luaL_checkudata(L, 1, "lyte.Sound");
    const char *str = "[lyte.Sound]";
    lua_pushstring(L, str);
    return 1;
}
static int Sound_metatable_gc(lua_State *L) {
    lyte_Sound *val = luaL_checkudata(L, 1, "lyte.Sound");
    _destroy_lyte_Sound(val);
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
// record Sound done

// record SoundData
enum SoundData_keys_index {
    IDX_SoundData_pan,
    IDX_SoundData_pitch,
    IDX_SoundData_volume,
    IDX_COUNT_SoundData,
};
static const char *SoundData_keys[] = {
    "pan",
    "pitch",
    "volume",
    NULL,  // required sentinel
};
static int SoundData_metatable_index(lua_State *L) {
    int key_id = luaL_checkoption(L, -1, NULL, SoundData_keys);
    lua_pop(L, 1); // remove the string key from the stack
    switch (key_id) {
        case IDX_SoundData_pan: { api_get_sounddata_pan(L); } break;
        case IDX_SoundData_pitch: { api_get_sounddata_pitch(L); } break;
        case IDX_SoundData_volume: { api_get_sounddata_volume(L); } break;
    }
    return 1;
}
static int SoundData_metatable_newindex(lua_State *L) {
    int key_id = luaL_checkoption(L, 2, NULL, SoundData_keys);
    lua_remove(L, 2); // remove the string key from the stack
    switch (key_id) {
        case IDX_SoundData_pan: { api_set_sounddata_pan(L); } break;
        case IDX_SoundData_pitch: { api_set_sounddata_pitch(L); } break;
        case IDX_SoundData_volume: { api_set_sounddata_volume(L); } break;
        default: { luaL_error(L, "Field is not settable."); } break;
    }
    lua_settop(L, 0);
    return 1;
}
static int SoundData_metatable_tostring(lua_State *L) {
    // lyte_SoundData *val = luaL_checkudata(L, 1, "lyte.SoundData");
    const char *str = "[lyte.SoundData]";
    lua_pushstring(L, str);
    return 1;
}
static int SoundData_metatable_gc(lua_State *L) {
    lyte_SoundData *val = luaL_checkudata(L, 1, "lyte.SoundData");
    _destroy_lyte_SoundData(val);
    return 1;
}
static const struct luaL_Reg SoundData_metatable[] = {
    {"__index", SoundData_metatable_index },
    {"__newindex", SoundData_metatable_newindex },
    {"__tostring", SoundData_metatable_tostring },
    {"__gc", SoundData_metatable_gc },
    {NULL, NULL} // sentinel ;
};
static int luaopen_SoundData_metatable(lua_State *L) {
    luaL_newmetatable(L, "lyte.SoundData");
    lua_pushvalue(L, -1); // duplicates the metatable
    lua_setfield(L, -2, "__index");
    luaL_register(L, NULL, SoundData_metatable);
    lua_settop(L, 0);
    return 0;
}
// record SoundData done








// Done: lyte
static const struct luaL_Reg lyte_api_functions[] = {
    {"cls", api_cls},
    {"draw_circle", api_draw_circle},
    {"draw_circle_line", api_draw_circle_line},
    {"draw_image", api_draw_image},
    {"draw_image_rect", api_draw_image_rect},
    {"draw_line", api_draw_line},
    {"draw_point", api_draw_point},
    {"draw_rect", api_draw_rect},
    {"draw_rect_line", api_draw_rect_line},
    {"draw_text", api_draw_text},
    {"get_gamepad_axis", api_get_gamepad_axis},
    {"get_gamepad_count", api_get_gamepad_count},
    {"get_gamepad_name", api_get_gamepad_name},
    {"get_mastervolume", api_get_mastervolume},
    {"get_mouse_x", api_get_mouse_x},
    {"get_mouse_y", api_get_mouse_y},
    {"get_music_length", api_get_music_length},
    {"get_music_length_played", api_get_music_length_played},
    {"get_music_pan", api_get_music_pan},
    {"get_music_pitch", api_get_music_pitch},
    {"get_music_volume", api_get_music_volume},
    {"get_sound_pan", api_get_sound_pan},
    {"get_sound_pitch", api_get_sound_pitch},
    {"get_sound_volume", api_get_sound_volume},
    {"get_sounddata_pan", api_get_sounddata_pan},
    {"get_sounddata_pitch", api_get_sounddata_pitch},
    {"get_sounddata_volume", api_get_sounddata_volume},
    {"get_text_width", api_get_text_width},
    {"get_text_height", api_get_text_height},
    {"get_window_width", api_get_window_width},
    {"get_window_height", api_get_window_height},
    {"get_image_width", api_get_image_width},
    {"get_image_height", api_get_image_height},
    {"is_fullscreen", api_is_fullscreen},
    {"is_gamepad_down", api_is_gamepad_down},
    {"is_gamepad_pressed", api_is_gamepad_pressed},
    {"is_gamepad_released", api_is_gamepad_released},
    {"is_key_down", api_is_key_down},
    {"is_key_pressed", api_is_key_pressed},
    {"is_key_released", api_is_key_released},
    {"is_key_repeat", api_is_key_repeat},
    {"is_mouse_down", api_is_mouse_down},
    {"is_mouse_pressed", api_is_mouse_pressed},
    {"is_mouse_released", api_is_mouse_released},
    {"is_music_playing", api_is_music_playing},
    {"is_sound_playing", api_is_sound_playing},
    {"is_window_vsync", api_is_window_vsync},
    {"is_image_canvas", api_is_image_canvas},
    {"load_file", api_load_file},
    {"load_font", api_load_font},
    {"load_image", api_load_image},
    {"load_music", api_load_music},
    {"load_sounddata", api_load_sounddata},
    {"new_canvas", api_new_canvas},
    {"new_sound", api_new_sound},
    {"pause_music", api_pause_music},
    {"pause_sound", api_pause_sound},
    {"play_music", api_play_music},
    {"play_sound", api_play_sound},
    {"pop_matrix", api_pop_matrix},
    {"push_matrix", api_push_matrix},
    {"quit", api_quit},
    {"reset_blendmode", api_reset_blendmode},
    {"reset_canvas", api_reset_canvas},
    {"reset_color", api_reset_color},
    {"reset_filtermode", api_reset_filtermode},
    {"reset_font", api_reset_font},
    {"reset_matrix", api_reset_matrix},
    {"reset_shader", api_reset_shader},
    {"resume_music", api_resume_music},
    {"resume_sound", api_resume_sound},
    {"rotate", api_rotate},
    {"rotate_at", api_rotate_at},
    {"save_file_append", api_save_file_append},
    {"save_file_write", api_save_file_write},
    {"scale", api_scale},
    {"scale_at", api_scale_at},
    {"seek_music", api_seek_music},
    {"set_blendmode", api_set_blendmode},
    {"set_canvas", api_set_canvas},
    {"set_color", api_set_color},
    {"set_default_blendmode", api_set_default_blendmode},
    {"set_default_filtermode", api_set_default_filtermode},
    {"set_filtermode", api_set_filtermode},
    {"set_font", api_set_font},
    {"set_fullscreen", api_set_fullscreen},
    {"set_mastervolume", api_set_mastervolume},
    {"set_music_pan", api_set_music_pan},
    {"set_music_pitch", api_set_music_pitch},
    {"set_music_volume", api_set_music_volume},
    {"set_shader", api_set_shader},
    {"set_sound_pan", api_set_sound_pan},
    {"set_sound_pitch", api_set_sound_pitch},
    {"set_sound_volume", api_set_sound_volume},
    {"set_sounddata_pan", api_set_sounddata_pan},
    {"set_sounddata_pitch", api_set_sounddata_pitch},
    {"set_sounddata_volume", api_set_sounddata_volume},
    {"set_window_icon", api_set_window_icon},
    {"set_window_margins", api_set_window_margins},
    {"set_window_minsize", api_set_window_minsize},
    {"set_window_paddings", api_set_window_paddings},
    {"set_window_size", api_set_window_size},
    {"set_window_title", api_set_window_title},
    {"set_window_vsync", api_set_window_vsync},
    {"stop_music", api_stop_music},
    {"stop_sound", api_stop_sound},
    {"translate", api_translate},
    {"new_shaderbuilder", api_new_shaderbuilder},
    {"shaderbuilder_uniform", api_shaderbuilder_uniform},
    {"shaderbuilder_vertex", api_shaderbuilder_vertex},
    {"shaderbuilder_fragment", api_shaderbuilder_fragment},
    {"shaderbuilder_build", api_shaderbuilder_build},
    {"send_shader_uniform", api_send_shader_uniform},
    {NULL, NULL}, // sentinel
};
static int luaopen_lyte_api_functions(lua_State *L) {
    luaL_register(L, "lyte", lyte_api_functions);
    lua_settop(L, 0);
    return 0;
}
// PUBLIC API
int register_lyte(lua_State *L) {
    luaopen_ShaderBuilder_metatable(L); // register ShaderBuilder's metatable
    luaopen_Shader_metatable(L); // register Shader's metatable
    luaopen_Image_metatable(L); // register Image's metatable
    luaopen_Font_metatable(L); // register Font's metatable
    luaopen_Music_metatable(L); // register Music's metatable
    luaopen_Sound_metatable(L); // register Sound's metatable
    luaopen_SoundData_metatable(L); // register SoundData's metatable
    luaopen_lyte_api_functions(L); // register all lyte api functions
    return 0;
}
