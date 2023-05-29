// GENERATED
// (c) 2023 MG

#ifndef API_ENUMS_H_INCLUDED
#define API_ENUMS_H_INCLUDED

// lyte enums (do not add new values or change the names. changing values per implementation/platform is OK.)

typedef enum lyte_PhysicsEngineState {
    LYTE_PHYSICSENGINESTATE_OFF,// order: 0, str: 'off'
    LYTE_PHYSICSENGINESTATE_2D,// order: 1, str: '2D'
    LYTE_PHYSICSENGINESTATE_3D,// order: 2, str: '3D'
    LYTE_PHYSICSENGINESTATE_COUNT = 3,
    LYTE_PHYSICSENGINESTATE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_PhysicsEngineState;
typedef enum lyte_UniformType {
    LYTE_UNIFORMTYPE__INVALID,// order: 0, str: '_invalid'
    LYTE_UNIFORMTYPE_FLOAT,// order: 1, str: 'float'
    LYTE_UNIFORMTYPE_VEC2,// order: 2, str: 'vec2'
    LYTE_UNIFORMTYPE_VEC3,// order: 3, str: 'vec3'
    LYTE_UNIFORMTYPE_VEC4,// order: 4, str: 'vec4'
    LYTE_UNIFORMTYPE_INT,// order: 5, str: 'int'
    LYTE_UNIFORMTYPE_IVEC2,// order: 6, str: 'ivec2'
    LYTE_UNIFORMTYPE_IVEC3,// order: 7, str: 'ivec3'
    LYTE_UNIFORMTYPE_IVEC4,// order: 8, str: 'ivec4'
    LYTE_UNIFORMTYPE_MAT4,// order: 9, str: 'mat4'
    LYTE_UNIFORMTYPE_SAMPLER2D,// order: 10, str: 'sampler2D'
    LYTE_UNIFORMTYPE_COUNT = 11,
    LYTE_UNIFORMTYPE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_UniformType;
typedef enum lyte_BlendMode {
    LYTE_BLENDMODE_NONE,// order: 0, str: 'none'
    LYTE_BLENDMODE_BLEND,// order: 1, str: 'blend'
    LYTE_BLENDMODE_ADD,// order: 2, str: 'add'
    LYTE_BLENDMODE_MOD,// order: 3, str: 'mod'
    LYTE_BLENDMODE_MUL,// order: 4, str: 'mul'
    LYTE_BLENDMODE_COUNT = 5,
    LYTE_BLENDMODE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_BlendMode;
typedef enum lyte_FilterMode {
    LYTE_FILTERMODE__INVALID,// order: 0, str: '_invalid'
    LYTE_FILTERMODE_NEAREST,// order: 1, str: 'nearest'
    LYTE_FILTERMODE_LINEAR,// order: 2, str: 'linear'
    LYTE_FILTERMODE_COUNT = 3,
    LYTE_FILTERMODE_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_FilterMode;
typedef enum lyte_GamepadAxis {
    LYTE_GAMEPADAXIS_LEFT_X,// order: 0, str: 'left_x'
    LYTE_GAMEPADAXIS_LEFT_Y,// order: 1, str: 'left_y'
    LYTE_GAMEPADAXIS_RIGHT_X,// order: 2, str: 'right_x'
    LYTE_GAMEPADAXIS_RIGHT_Y,// order: 3, str: 'right_y'
    LYTE_GAMEPADAXIS_LEFT_TRIGGER,// order: 4, str: 'left_trigger'
    LYTE_GAMEPADAXIS_RIGHT_TRIGGER,// order: 5, str: 'right_trigger'
    LYTE_GAMEPADAXIS_COUNT = 6,
    LYTE_GAMEPADAXIS_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_GamepadAxis;
typedef enum lyte_GamepadButton {
    LYTE_GAMEPADBUTTON_PAD_A,// order: 0, str: 'pad_a'
    LYTE_GAMEPADBUTTON_PAD_B,// order: 1, str: 'pad_b'
    LYTE_GAMEPADBUTTON_PAD_X,// order: 2, str: 'pad_x'
    LYTE_GAMEPADBUTTON_PAD_Y,// order: 3, str: 'pad_y'
    LYTE_GAMEPADBUTTON_LEFT_BUMPER,// order: 4, str: 'left_bumper'
    LYTE_GAMEPADBUTTON_RIGHT_BUMPER,// order: 5, str: 'right_bumper'
    LYTE_GAMEPADBUTTON_BACK,// order: 6, str: 'back'
    LYTE_GAMEPADBUTTON_START,// order: 7, str: 'start'
    LYTE_GAMEPADBUTTON_GUIDE,// order: 8, str: 'guide'
    LYTE_GAMEPADBUTTON_LEFT_THUMB,// order: 9, str: 'left_thumb'
    LYTE_GAMEPADBUTTON_RIGHT_THUMB,// order: 10, str: 'right_thumb'
    LYTE_GAMEPADBUTTON_DPAD_UP,// order: 11, str: 'dpad_up'
    LYTE_GAMEPADBUTTON_DPAD_RIGHT,// order: 12, str: 'dpad_right'
    LYTE_GAMEPADBUTTON_DPAD_DOWN,// order: 13, str: 'dpad_down'
    LYTE_GAMEPADBUTTON_DPAD_LEFT,// order: 14, str: 'dpad_left'
    LYTE_GAMEPADBUTTON_COUNT = 15,
    LYTE_GAMEPADBUTTON_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_GamepadButton;
typedef enum lyte_MouseButton {
    LYTE_MOUSEBUTTON_MB1,// order: 0, str: 'mb1'
    LYTE_MOUSEBUTTON_MB2,// order: 1, str: 'mb2'
    LYTE_MOUSEBUTTON_MB3,// order: 2, str: 'mb3'
    LYTE_MOUSEBUTTON_MB4,// order: 3, str: 'mb4'
    LYTE_MOUSEBUTTON_MB5,// order: 4, str: 'mb5'
    LYTE_MOUSEBUTTON_MB6,// order: 5, str: 'mb6'
    LYTE_MOUSEBUTTON_MB7,// order: 6, str: 'mb7'
    LYTE_MOUSEBUTTON_MB8,// order: 7, str: 'mb8'
    LYTE_MOUSEBUTTON_COUNT = 8,
    LYTE_MOUSEBUTTON_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_MouseButton;
typedef enum lyte_KeyboardKey {
    LYTE_KEYBOARDKEY_SPACE,// order: 0, str: 'space'
    LYTE_KEYBOARDKEY_TICK,// order: 1, str: '''
    LYTE_KEYBOARDKEY_COMMA,// order: 2, str: ','
    LYTE_KEYBOARDKEY_DASH,// order: 3, str: '-'
    LYTE_KEYBOARDKEY_PERIOD,// order: 4, str: '.'
    LYTE_KEYBOARDKEY_SLASH,// order: 5, str: '/'
    LYTE_KEYBOARDKEY_0,// order: 6, str: '0'
    LYTE_KEYBOARDKEY_1,// order: 7, str: '1'
    LYTE_KEYBOARDKEY_2,// order: 8, str: '2'
    LYTE_KEYBOARDKEY_3,// order: 9, str: '3'
    LYTE_KEYBOARDKEY_4,// order: 10, str: '4'
    LYTE_KEYBOARDKEY_5,// order: 11, str: '5'
    LYTE_KEYBOARDKEY_6,// order: 12, str: '6'
    LYTE_KEYBOARDKEY_7,// order: 13, str: '7'
    LYTE_KEYBOARDKEY_8,// order: 14, str: '8'
    LYTE_KEYBOARDKEY_9,// order: 15, str: '9'
    LYTE_KEYBOARDKEY_SEMICOLON,// order: 16, str: ';'
    LYTE_KEYBOARDKEY_EQUAL,// order: 17, str: '='
    LYTE_KEYBOARDKEY_A,// order: 18, str: 'a'
    LYTE_KEYBOARDKEY_B,// order: 19, str: 'b'
    LYTE_KEYBOARDKEY_C,// order: 20, str: 'c'
    LYTE_KEYBOARDKEY_D,// order: 21, str: 'd'
    LYTE_KEYBOARDKEY_E,// order: 22, str: 'e'
    LYTE_KEYBOARDKEY_F,// order: 23, str: 'f'
    LYTE_KEYBOARDKEY_G,// order: 24, str: 'g'
    LYTE_KEYBOARDKEY_H,// order: 25, str: 'h'
    LYTE_KEYBOARDKEY_I,// order: 26, str: 'i'
    LYTE_KEYBOARDKEY_J,// order: 27, str: 'j'
    LYTE_KEYBOARDKEY_K,// order: 28, str: 'k'
    LYTE_KEYBOARDKEY_L,// order: 29, str: 'l'
    LYTE_KEYBOARDKEY_M,// order: 30, str: 'm'
    LYTE_KEYBOARDKEY_N,// order: 31, str: 'n'
    LYTE_KEYBOARDKEY_O,// order: 32, str: 'o'
    LYTE_KEYBOARDKEY_P,// order: 33, str: 'p'
    LYTE_KEYBOARDKEY_Q,// order: 34, str: 'q'
    LYTE_KEYBOARDKEY_R,// order: 35, str: 'r'
    LYTE_KEYBOARDKEY_S,// order: 36, str: 's'
    LYTE_KEYBOARDKEY_T,// order: 37, str: 't'
    LYTE_KEYBOARDKEY_U,// order: 38, str: 'u'
    LYTE_KEYBOARDKEY_V,// order: 39, str: 'v'
    LYTE_KEYBOARDKEY_W,// order: 40, str: 'w'
    LYTE_KEYBOARDKEY_X,// order: 41, str: 'x'
    LYTE_KEYBOARDKEY_Y,// order: 42, str: 'y'
    LYTE_KEYBOARDKEY_Z,// order: 43, str: 'z'
    LYTE_KEYBOARDKEY_OPEN_BRACKET,// order: 44, str: '['
    LYTE_KEYBOARDKEY_BACKSLASH,// order: 45, str: '\'
    LYTE_KEYBOARDKEY_CLOSE_BRACKET,// order: 46, str: ']'
    LYTE_KEYBOARDKEY_BACKTICK,// order: 47, str: '`'
    LYTE_KEYBOARDKEY_WORLD_1,// order: 48, str: 'world_1'
    LYTE_KEYBOARDKEY_WORLD_2,// order: 49, str: 'world_2'
    LYTE_KEYBOARDKEY_ESCAPE,// order: 50, str: 'escape'
    LYTE_KEYBOARDKEY_ENTER,// order: 51, str: 'enter'
    LYTE_KEYBOARDKEY_TAB,// order: 52, str: 'tab'
    LYTE_KEYBOARDKEY_BACKSPACE,// order: 53, str: 'backspace'
    LYTE_KEYBOARDKEY_INSERT,// order: 54, str: 'insert'
    LYTE_KEYBOARDKEY_DELETE,// order: 55, str: 'delete'
    LYTE_KEYBOARDKEY_RIGHT,// order: 56, str: 'right'
    LYTE_KEYBOARDKEY_LEFT,// order: 57, str: 'left'
    LYTE_KEYBOARDKEY_DOWN,// order: 58, str: 'down'
    LYTE_KEYBOARDKEY_UP,// order: 59, str: 'up'
    LYTE_KEYBOARDKEY_PAGE_UP,// order: 60, str: 'page_up'
    LYTE_KEYBOARDKEY_PAGE_DOWN,// order: 61, str: 'page_down'
    LYTE_KEYBOARDKEY_HOME,// order: 62, str: 'home'
    LYTE_KEYBOARDKEY_END,// order: 63, str: 'end'
    LYTE_KEYBOARDKEY_CAPS_LOCK,// order: 64, str: 'caps_lock'
    LYTE_KEYBOARDKEY_SCROLL_LOCK,// order: 65, str: 'scroll_lock'
    LYTE_KEYBOARDKEY_NUM_LOCK,// order: 66, str: 'num_lock'
    LYTE_KEYBOARDKEY_PRINT_SCREEN,// order: 67, str: 'print_screen'
    LYTE_KEYBOARDKEY_PAUSE,// order: 68, str: 'pause'
    LYTE_KEYBOARDKEY_F1,// order: 69, str: 'f1'
    LYTE_KEYBOARDKEY_F2,// order: 70, str: 'f2'
    LYTE_KEYBOARDKEY_F3,// order: 71, str: 'f3'
    LYTE_KEYBOARDKEY_F4,// order: 72, str: 'f4'
    LYTE_KEYBOARDKEY_F5,// order: 73, str: 'f5'
    LYTE_KEYBOARDKEY_F6,// order: 74, str: 'f6'
    LYTE_KEYBOARDKEY_F7,// order: 75, str: 'f7'
    LYTE_KEYBOARDKEY_F8,// order: 76, str: 'f8'
    LYTE_KEYBOARDKEY_F9,// order: 77, str: 'f9'
    LYTE_KEYBOARDKEY_F10,// order: 78, str: 'f10'
    LYTE_KEYBOARDKEY_F11,// order: 79, str: 'f11'
    LYTE_KEYBOARDKEY_F12,// order: 80, str: 'f12'
    LYTE_KEYBOARDKEY_F13,// order: 81, str: 'f13'
    LYTE_KEYBOARDKEY_F14,// order: 82, str: 'f14'
    LYTE_KEYBOARDKEY_F15,// order: 83, str: 'f15'
    LYTE_KEYBOARDKEY_F16,// order: 84, str: 'f16'
    LYTE_KEYBOARDKEY_F17,// order: 85, str: 'f17'
    LYTE_KEYBOARDKEY_F18,// order: 86, str: 'f18'
    LYTE_KEYBOARDKEY_F19,// order: 87, str: 'f19'
    LYTE_KEYBOARDKEY_F20,// order: 88, str: 'f20'
    LYTE_KEYBOARDKEY_F21,// order: 89, str: 'f21'
    LYTE_KEYBOARDKEY_F22,// order: 90, str: 'f22'
    LYTE_KEYBOARDKEY_F23,// order: 91, str: 'f23'
    LYTE_KEYBOARDKEY_F24,// order: 92, str: 'f24'
    LYTE_KEYBOARDKEY_F25,// order: 93, str: 'f25'
    LYTE_KEYBOARDKEY_KP_0,// order: 94, str: 'kp_0'
    LYTE_KEYBOARDKEY_KP_1,// order: 95, str: 'kp_1'
    LYTE_KEYBOARDKEY_KP_2,// order: 96, str: 'kp_2'
    LYTE_KEYBOARDKEY_KP_3,// order: 97, str: 'kp_3'
    LYTE_KEYBOARDKEY_KP_4,// order: 98, str: 'kp_4'
    LYTE_KEYBOARDKEY_KP_5,// order: 99, str: 'kp_5'
    LYTE_KEYBOARDKEY_KP_6,// order: 100, str: 'kp_6'
    LYTE_KEYBOARDKEY_KP_7,// order: 101, str: 'kp_7'
    LYTE_KEYBOARDKEY_KP_8,// order: 102, str: 'kp_8'
    LYTE_KEYBOARDKEY_KP_9,// order: 103, str: 'kp_9'
    LYTE_KEYBOARDKEY_KP_DECIMAL,// order: 104, str: 'kp_decimal'
    LYTE_KEYBOARDKEY_KP_DIVIDE,// order: 105, str: 'kp_divide'
    LYTE_KEYBOARDKEY_KP_MULTIPLY,// order: 106, str: 'kp_multiply'
    LYTE_KEYBOARDKEY_KP_SUBTRACT,// order: 107, str: 'kp_subtract'
    LYTE_KEYBOARDKEY_KP_ADD,// order: 108, str: 'kp_add'
    LYTE_KEYBOARDKEY_KP_ENTER,// order: 109, str: 'kp_enter'
    LYTE_KEYBOARDKEY_KP_EQUAL,// order: 110, str: 'kp_equal'
    LYTE_KEYBOARDKEY_LEFT_SHIFT,// order: 111, str: 'left_shift'
    LYTE_KEYBOARDKEY_LEFT_CONTROL,// order: 112, str: 'left_control'
    LYTE_KEYBOARDKEY_LEFT_ALT,// order: 113, str: 'left_alt'
    LYTE_KEYBOARDKEY_LEFT_SUPER,// order: 114, str: 'left_super'
    LYTE_KEYBOARDKEY_RIGHT_SHIFT,// order: 115, str: 'right_shift'
    LYTE_KEYBOARDKEY_RIGHT_CONTROL,// order: 116, str: 'right_control'
    LYTE_KEYBOARDKEY_RIGHT_ALT,// order: 117, str: 'right_alt'
    LYTE_KEYBOARDKEY_RIGHT_SUPER,// order: 118, str: 'right_super'
    LYTE_KEYBOARDKEY_MENU,// order: 119, str: 'menu'
    LYTE_KEYBOARDKEY_COUNT = 120,
    LYTE_KEYBOARDKEY_FORCE_UINT32 = 0x7FFFFFFF, // inspired by sokol_gfx enums
} lyte_KeyboardKey;

#endif  // API_ENUMS_H_INCLUDED
