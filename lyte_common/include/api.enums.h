// GENERATED
// (c) 2023 MG

#ifndef API_ENUMS_H_INCLUDED
#define API_ENUMS_H_INCLUDED

// lyte enums (do not add new values or change the names. changing values per implementation/platform is OK.)

typedef enum lyte_UniformType {
    // MG: values map to: SOKOL GP
    LYTE_UNIFORMTYPE__INVALID = 0,// order: 0, str: '_invalid'
    LYTE_UNIFORMTYPE_FLOAT = 1,// order: 1, str: 'float'
    LYTE_UNIFORMTYPE_VEC2 = 2,// order: 2, str: 'vec2'
    LYTE_UNIFORMTYPE_VEC3 = 3,// order: 3, str: 'vec3'
    LYTE_UNIFORMTYPE_VEC4 = 4,// order: 4, str: 'vec4'
    LYTE_UNIFORMTYPE_INT = 5,// order: 5, str: 'int'
    LYTE_UNIFORMTYPE_IVEC2 = 6,// order: 6, str: 'ivec2'
    LYTE_UNIFORMTYPE_IVEC3 = 7,// order: 7, str: 'ivec3'
    LYTE_UNIFORMTYPE_IVEC4 = 8,// order: 8, str: 'ivec4'
    LYTE_UNIFORMTYPE_MAT4 = 9,// order: 9, str: 'mat4'
    LYTE_UNIFORMTYPE_SAMPLER2D = 10,// order: 10, str: 'sampler2D'
    LYTE_UNIFORMTYPE_COUNT = 11,
    LYTE_UNIFORMTYPE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_UniformType;

typedef enum lyte_BlendMode {
    // MG: values map to: SOKOL GP
    LYTE_BLENDMODE_NONE = 0,// order: 0, str: 'none'
    LYTE_BLENDMODE_BLEND = 1,// order: 1, str: 'blend'
    LYTE_BLENDMODE_ADD = 2,// order: 2, str: 'add'
    LYTE_BLENDMODE_MOD = 3,// order: 3, str: 'mod'
    LYTE_BLENDMODE_MUL = 4,// order: 4, str: 'mul'
    LYTE_BLENDMODE_COUNT = 5,
    LYTE_BLENDMODE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_BlendMode;

typedef enum lyte_FilterMode {
    // MG: values map to: SOKOL GP
    LYTE_FILTERMODE__INVALID = 0,// order: 0, str: '_invalid'
    LYTE_FILTERMODE_NEAREST = 1,// order: 1, str: 'nearest'
    LYTE_FILTERMODE_LINEAR = 2,// order: 2, str: 'linear'
    LYTE_FILTERMODE_COUNT = 3,
    LYTE_FILTERMODE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_FilterMode;

typedef enum lyte_GamepadAxis {
    // MG: values map to: GLFW
    LYTE_GAMEPADAXIS_LEFT_X = 0,// order: 0, str: 'left_x'
    LYTE_GAMEPADAXIS_LEFT_Y = 1,// order: 1, str: 'left_y'
    LYTE_GAMEPADAXIS_RIGHT_X = 2,// order: 2, str: 'right_x'
    LYTE_GAMEPADAXIS_RIGHT_Y = 3,// order: 3, str: 'right_y'
    LYTE_GAMEPADAXIS_LEFT_TRIGGER = 4,// order: 4, str: 'left_trigger'
    LYTE_GAMEPADAXIS_RIGHT_TRIGGER = 5,// order: 5, str: 'right_trigger'
    LYTE_GAMEPADAXIS_COUNT = 6,
    LYTE_GAMEPADAXIS_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_GamepadAxis;

typedef enum lyte_GamepadButton {
#if defined(__EMSCRIPTEN__)
    // MG: values map to: GLFW (Windows/Linux)
    LYTE_GAMEPADBUTTON_PAD_A = 0,// order: 0, str: 'pad_a'
    LYTE_GAMEPADBUTTON_PAD_B = 1,// order: 1, str: 'pad_b'
    LYTE_GAMEPADBUTTON_PAD_X = 2,// order: 2, str: 'pad_x'
    LYTE_GAMEPADBUTTON_PAD_Y = 3,// order: 3, str: 'pad_y'
    LYTE_GAMEPADBUTTON_LEFT_BUMPER = 4,// order: 4, str: 'left_bumper'
    LYTE_GAMEPADBUTTON_RIGHT_BUMPER = 5,// order: 5, str: 'right_bumper'
    LYTE_GAMEPADBUTTON_BACK = 8,// order: 6, str: 'back'
    LYTE_GAMEPADBUTTON_START = 9,// order: 7, str: 'start'
    LYTE_GAMEPADBUTTON_GUIDE = 16,// order: 8, str: 'guide'
    LYTE_GAMEPADBUTTON_LEFT_THUMB = 10,// order: 9, str: 'left_thumb'
    LYTE_GAMEPADBUTTON_RIGHT_THUMB = 11,// order: 10, str: 'right_thumb'
    LYTE_GAMEPADBUTTON_DPAD_UP = 12,// order: 11, str: 'dpad_up'
    LYTE_GAMEPADBUTTON_DPAD_RIGHT = 15,// order: 12, str: 'dpad_right'
    LYTE_GAMEPADBUTTON_DPAD_DOWN = 13,// order: 13, str: 'dpad_down'
    LYTE_GAMEPADBUTTON_DPAD_LEFT = 14,// order: 14, str: 'dpad_left'
    // MG: value 6 corresponds to LEFT_TRIGGER as a button on WASM
    // MG: value 7 corresponds to RIGHT_TRIGGER as a button on WASM
    LYTE_GAMEPADBUTTON_COUNT = 15,
    LYTE_GAMEPADBUTTON_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
#else
    // MG: values map to: GLFW (Empscripten/WASM)
    LYTE_GAMEPADBUTTON_PAD_A = 0,// order: 0, str: 'pad_a'
    LYTE_GAMEPADBUTTON_PAD_B = 1,// order: 1, str: 'pad_b'
    LYTE_GAMEPADBUTTON_PAD_X = 2,// order: 2, str: 'pad_x'
    LYTE_GAMEPADBUTTON_PAD_Y = 3,// order: 3, str: 'pad_y'
    LYTE_GAMEPADBUTTON_LEFT_BUMPER = 4,// order: 4, str: 'left_bumper'
    LYTE_GAMEPADBUTTON_RIGHT_BUMPER = 5,// order: 5, str: 'right_bumper'
    LYTE_GAMEPADBUTTON_BACK = 6,// order: 6, str: 'back'
    LYTE_GAMEPADBUTTON_START = 7,// order: 7, str: 'start'
    LYTE_GAMEPADBUTTON_GUIDE = 8,// order: 8, str: 'guide'
    LYTE_GAMEPADBUTTON_LEFT_THUMB = 9,// order: 9, str: 'left_thumb'
    LYTE_GAMEPADBUTTON_RIGHT_THUMB = 10,// order: 10, str: 'right_thumb'
    LYTE_GAMEPADBUTTON_DPAD_UP = 11,// order: 11, str: 'dpad_up'
    LYTE_GAMEPADBUTTON_DPAD_RIGHT = 12,// order: 12, str: 'dpad_right'
    LYTE_GAMEPADBUTTON_DPAD_DOWN = 13,// order: 13, str: 'dpad_down'
    LYTE_GAMEPADBUTTON_DPAD_LEFT = 14,// order: 14, str: 'dpad_left'
    LYTE_GAMEPADBUTTON_COUNT = 15,
    LYTE_GAMEPADBUTTON_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
#endif
} lyte_GamepadButton;

typedef enum lyte_MouseButton {
    // MG: values map to: GLFW
    LYTE_MOUSEBUTTON_MB1 = 0,// order: 0, str: 'mb1'
    LYTE_MOUSEBUTTON_MB2 = 1,// order: 1, str: 'mb2'
    LYTE_MOUSEBUTTON_MB3 = 2,// order: 2, str: 'mb3'
    LYTE_MOUSEBUTTON_MB4 = 3,// order: 3, str: 'mb4'
    LYTE_MOUSEBUTTON_MB5 = 4,// order: 4, str: 'mb5'
    LYTE_MOUSEBUTTON_MB6 = 5,// order: 5, str: 'mb6'
    LYTE_MOUSEBUTTON_MB7 = 6,// order: 6, str: 'mb7'
    LYTE_MOUSEBUTTON_MB8 = 7,// order: 7, str: 'mb8'
    LYTE_MOUSEBUTTON_COUNT = 8,
    LYTE_MOUSEBUTTON_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_MouseButton;

typedef enum lyte_KeyboardKey {
    // MG: values map to: GLFW
    LYTE_KEYBOARDKEY_SPACE = 32,// order: 0, str: 'space'
    LYTE_KEYBOARDKEY_TICK = 39,// order: 1, str: '''
    LYTE_KEYBOARDKEY_COMMA = 44,// order: 2, str: ','
    LYTE_KEYBOARDKEY_DASH = 45,// order: 3, str: '-'
    LYTE_KEYBOARDKEY_PERIOD = 46,// order: 4, str: '.'
    LYTE_KEYBOARDKEY_SLASH = 47,// order: 5, str: '/'
    LYTE_KEYBOARDKEY_0 = 48,// order: 6, str: '0'
    LYTE_KEYBOARDKEY_1 = 49,// order: 7, str: '1'
    LYTE_KEYBOARDKEY_2 = 50,// order: 8, str: '2'
    LYTE_KEYBOARDKEY_3 = 51,// order: 9, str: '3'
    LYTE_KEYBOARDKEY_4 = 52,// order: 10, str: '4'
    LYTE_KEYBOARDKEY_5 = 53,// order: 11, str: '5'
    LYTE_KEYBOARDKEY_6 = 54,// order: 12, str: '6'
    LYTE_KEYBOARDKEY_7 = 55,// order: 13, str: '7'
    LYTE_KEYBOARDKEY_8 = 56,// order: 14, str: '8'
    LYTE_KEYBOARDKEY_9 = 57,// order: 15, str: '9'
    LYTE_KEYBOARDKEY_SEMICOLON = 59,// order: 16, str: ';'
    LYTE_KEYBOARDKEY_EQUAL = 61,// order: 17, str: '='
    LYTE_KEYBOARDKEY_A = 65,// order: 18, str: 'a'
    LYTE_KEYBOARDKEY_B = 66,// order: 19, str: 'b'
    LYTE_KEYBOARDKEY_C = 67,// order: 20, str: 'c'
    LYTE_KEYBOARDKEY_D = 68,// order: 21, str: 'd'
    LYTE_KEYBOARDKEY_E = 69,// order: 22, str: 'e'
    LYTE_KEYBOARDKEY_F = 70,// order: 23, str: 'f'
    LYTE_KEYBOARDKEY_G = 71,// order: 24, str: 'g'
    LYTE_KEYBOARDKEY_H = 72,// order: 25, str: 'h'
    LYTE_KEYBOARDKEY_I = 73,// order: 26, str: 'i'
    LYTE_KEYBOARDKEY_J = 74,// order: 27, str: 'j'
    LYTE_KEYBOARDKEY_K = 75,// order: 28, str: 'k'
    LYTE_KEYBOARDKEY_L = 76,// order: 29, str: 'l'
    LYTE_KEYBOARDKEY_M = 77,// order: 30, str: 'm'
    LYTE_KEYBOARDKEY_N = 78,// order: 31, str: 'n'
    LYTE_KEYBOARDKEY_O = 79,// order: 32, str: 'o'
    LYTE_KEYBOARDKEY_P = 80,// order: 33, str: 'p'
    LYTE_KEYBOARDKEY_Q = 81,// order: 34, str: 'q'
    LYTE_KEYBOARDKEY_R = 82,// order: 35, str: 'r'
    LYTE_KEYBOARDKEY_S = 83,// order: 36, str: 's'
    LYTE_KEYBOARDKEY_T = 84,// order: 37, str: 't'
    LYTE_KEYBOARDKEY_U = 85,// order: 38, str: 'u'
    LYTE_KEYBOARDKEY_V = 86,// order: 39, str: 'v'
    LYTE_KEYBOARDKEY_W = 87,// order: 40, str: 'w'
    LYTE_KEYBOARDKEY_X = 88,// order: 41, str: 'x'
    LYTE_KEYBOARDKEY_Y = 89,// order: 42, str: 'y'
    LYTE_KEYBOARDKEY_Z = 90,// order: 43, str: 'z'
    LYTE_KEYBOARDKEY_OPEN_BRACKET = 91,// order: 44, str: '['
    LYTE_KEYBOARDKEY_BACKSLASH = 92,// order: 45, str: '\'
    LYTE_KEYBOARDKEY_CLOSE_BRACKET = 93,// order: 46, str: ']'
    LYTE_KEYBOARDKEY_BACKTICK = 96,// order: 47, str: '`'
    LYTE_KEYBOARDKEY_WORLD_1 = 161,// order: 48, str: 'world_1'
    LYTE_KEYBOARDKEY_WORLD_2 = 162,// order: 49, str: 'world_2'
    LYTE_KEYBOARDKEY_ESCAPE = 256,// order: 50, str: 'escape'
    LYTE_KEYBOARDKEY_ENTER = 257,// order: 51, str: 'enter'
    LYTE_KEYBOARDKEY_TAB = 258,// order: 52, str: 'tab'
    LYTE_KEYBOARDKEY_BACKSPACE = 259,// order: 53, str: 'backspace'
    LYTE_KEYBOARDKEY_INSERT = 260,// order: 54, str: 'insert'
    LYTE_KEYBOARDKEY_DELETE = 261,// order: 55, str: 'delete'
    LYTE_KEYBOARDKEY_RIGHT = 262,// order: 56, str: 'right'
    LYTE_KEYBOARDKEY_LEFT = 263,// order: 57, str: 'left'
    LYTE_KEYBOARDKEY_DOWN = 264,// order: 58, str: 'down'
    LYTE_KEYBOARDKEY_UP = 265,// order: 59, str: 'up'
    LYTE_KEYBOARDKEY_PAGE_UP = 266,// order: 60, str: 'page_up'
    LYTE_KEYBOARDKEY_PAGE_DOWN = 267,// order: 61, str: 'page_down'
    LYTE_KEYBOARDKEY_HOME = 268,// order: 62, str: 'home'
    LYTE_KEYBOARDKEY_END = 269,// order: 63, str: 'end'
    LYTE_KEYBOARDKEY_CAPS_LOCK = 280,// order: 64, str: 'caps_lock'
    LYTE_KEYBOARDKEY_SCROLL_LOCK = 281,// order: 65, str: 'scroll_lock'
    LYTE_KEYBOARDKEY_NUM_LOCK = 282,// order: 66, str: 'num_lock'
    LYTE_KEYBOARDKEY_PRINT_SCREEN = 283,// order: 67, str: 'print_screen'
    LYTE_KEYBOARDKEY_PAUSE = 284,// order: 68, str: 'pause'
    LYTE_KEYBOARDKEY_F1 = 290,// order: 69, str: 'f1'
    LYTE_KEYBOARDKEY_F2 = 291,// order: 70, str: 'f2'
    LYTE_KEYBOARDKEY_F3 = 292,// order: 71, str: 'f3'
    LYTE_KEYBOARDKEY_F4 = 293,// order: 72, str: 'f4'
    LYTE_KEYBOARDKEY_F5 = 294,// order: 73, str: 'f5'
    LYTE_KEYBOARDKEY_F6 = 295,// order: 74, str: 'f6'
    LYTE_KEYBOARDKEY_F7 = 296,// order: 75, str: 'f7'
    LYTE_KEYBOARDKEY_F8 = 297,// order: 76, str: 'f8'
    LYTE_KEYBOARDKEY_F9 = 298,// order: 77, str: 'f9'
    LYTE_KEYBOARDKEY_F10 = 299,// order: 78, str: 'f10'
    LYTE_KEYBOARDKEY_F11 = 300,// order: 79, str: 'f11'
    LYTE_KEYBOARDKEY_F12 = 301,// order: 80, str: 'f12'
    LYTE_KEYBOARDKEY_F13 = 302,// order: 81, str: 'f13'
    LYTE_KEYBOARDKEY_F14 = 303,// order: 82, str: 'f14'
    LYTE_KEYBOARDKEY_F15 = 304,// order: 83, str: 'f15'
    LYTE_KEYBOARDKEY_F16 = 305,// order: 84, str: 'f16'
    LYTE_KEYBOARDKEY_F17 = 306,// order: 85, str: 'f17'
    LYTE_KEYBOARDKEY_F18 = 307,// order: 86, str: 'f18'
    LYTE_KEYBOARDKEY_F19 = 308,// order: 87, str: 'f19'
    LYTE_KEYBOARDKEY_F20 = 309,// order: 88, str: 'f20'
    LYTE_KEYBOARDKEY_F21 = 310,// order: 89, str: 'f21'
    LYTE_KEYBOARDKEY_F22 = 311,// order: 90, str: 'f22'
    LYTE_KEYBOARDKEY_F23 = 312,// order: 91, str: 'f23'
    LYTE_KEYBOARDKEY_F24 = 313,// order: 92, str: 'f24'
    LYTE_KEYBOARDKEY_F25 = 314,// order: 93, str: 'f25'
    LYTE_KEYBOARDKEY_KP_0 = 320,// order: 94, str: 'kp_0'
    LYTE_KEYBOARDKEY_KP_1 = 321,// order: 95, str: 'kp_1'
    LYTE_KEYBOARDKEY_KP_2 = 322,// order: 96, str: 'kp_2'
    LYTE_KEYBOARDKEY_KP_3 = 323,// order: 97, str: 'kp_3'
    LYTE_KEYBOARDKEY_KP_4 = 324,// order: 98, str: 'kp_4'
    LYTE_KEYBOARDKEY_KP_5 = 335,// order: 99, str: 'kp_5'
    LYTE_KEYBOARDKEY_KP_6 = 326,// order: 100, str: 'kp_6'
    LYTE_KEYBOARDKEY_KP_7 = 327,// order: 101, str: 'kp_7'
    LYTE_KEYBOARDKEY_KP_8 = 328,// order: 102, str: 'kp_8'
    LYTE_KEYBOARDKEY_KP_9 = 329,// order: 103, str: 'kp_9'
    LYTE_KEYBOARDKEY_KP_DECIMAL = 330,// order: 104, str: 'kp_decimal'
    LYTE_KEYBOARDKEY_KP_DIVIDE = 331,// order: 105, str: 'kp_divide'
    LYTE_KEYBOARDKEY_KP_MULTIPLY = 332,// order: 106, str: 'kp_multiply'
    LYTE_KEYBOARDKEY_KP_SUBTRACT = 333,// order: 107, str: 'kp_subtract'
    LYTE_KEYBOARDKEY_KP_ADD = 334,// order: 108, str: 'kp_add'
    LYTE_KEYBOARDKEY_KP_ENTER = 335,// order: 109, str: 'kp_enter'
    LYTE_KEYBOARDKEY_KP_EQUAL = 336,// order: 110, str: 'kp_equal'
    LYTE_KEYBOARDKEY_LEFT_SHIFT = 340,// order: 111, str: 'left_shift'
    LYTE_KEYBOARDKEY_LEFT_CONTROL = 341,// order: 112, str: 'left_control'
    LYTE_KEYBOARDKEY_LEFT_ALT = 342,// order: 113, str: 'left_alt'
    LYTE_KEYBOARDKEY_LEFT_SUPER = 343,// order: 114, str: 'left_super'
    LYTE_KEYBOARDKEY_RIGHT_SHIFT = 344,// order: 115, str: 'right_shift'
    LYTE_KEYBOARDKEY_RIGHT_CONTROL = 345,// order: 116, str: 'right_control'
    LYTE_KEYBOARDKEY_RIGHT_ALT = 346,// order: 117, str: 'right_alt'
    LYTE_KEYBOARDKEY_RIGHT_SUPER = 347,// order: 118, str: 'right_super'
    LYTE_KEYBOARDKEY_MENU = 348,// order: 119, str: 'menu'
    LYTE_KEYBOARDKEY_COUNT = 120,
    LYTE_KEYBOARDKEY_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_KeyboardKey;

#endif  // API_ENUMS_H_INCLUDED
