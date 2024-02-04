//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lyte_core.h"
#include "utf8encode.h"

#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>

#define LYTE_MAX_JOYSTICKS 16
#define LYTE_MAX_KEYBOARD_KEYS (LYTE_KEYBOARDKEY_MENU+1)
#define LYTE_MAX_MOUSEBUTTONS LYTE_MOUSEBUTTON_COUNT
#define LYTE_MAX_KEYLIST 16
#define LYTE_MAX_CHARINPUT_CODEPOINTS 16    // per frame
#define LYTE_TEXTINPUT_BUF_SIZE  (LYTE_MAX_CHARINPUT_CODEPOINTS * 4 + 1)

typedef struct lyte_InputState {
    uint8_t keys_rep[LYTE_MAX_KEYBOARD_KEYS];
    uint8_t keys_cur[LYTE_MAX_KEYBOARD_KEYS];
    uint8_t keys_prev[LYTE_MAX_KEYBOARD_KEYS];
    uint8_t mousebuttons_cur[LYTE_MAX_MOUSEBUTTONS];
    uint8_t mousebuttons_prev[LYTE_MAX_MOUSEBUTTONS];
    uint32_t textinput_data[LYTE_MAX_CHARINPUT_CODEPOINTS];
    int textinput_idx;
    float mouse_x, mouse_y;


    // these two are handled by joystick connet/disconnect events
    uint8_t joystick_connected[LYTE_MAX_JOYSTICKS];
    struct {
        int joystick_id;
        bool is_gamepad;
        const char *name;
    } gamepad_info[LYTE_MAX_JOYSTICKS];
    GLFWgamepadstate gamepad_states_prev[LYTE_MAX_JOYSTICKS];
    GLFWgamepadstate gamepad_states_cur[LYTE_MAX_JOYSTICKS];

} lyte_InputState;


static lyte_InputState inputstate = {0};


static void cursor_position_callback(GLFWwindow* window, double xpos, double ypos) {
    inputstate.mouse_x = xpos;
    inputstate.mouse_y = ypos;
}

static void mouse_button_callback(GLFWwindow* window, int button, int action, int mods) {
    if (action == GLFW_PRESS) {
        inputstate.mousebuttons_cur[button] = true;
    } else if (action == GLFW_RELEASE) {
        inputstate.mousebuttons_cur[button] = false;
    } else {
        // ASSERT(false);
    }
}

static void mouse_scroll_callback(GLFWwindow* window, double xoffset, double yoffset) {
    if (yoffset > 0) {
        inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLUP] = true;
    } else if (yoffset < 0) {
        inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLDOWN] = true;
    }
}

static void mouse_scroll_reset(void) {
    // mouse scroll is handled like any other button from an API point of view. is_down won't work but pressed/released will
    // however glfw does not send "release" events for scroll, so approaching it a bit differently here
    inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLUP] = false;
    inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLDOWN] = false;
}

static void joystick_callback(int jid, int event) {
    if (event == GLFW_CONNECTED) {
        inputstate.joystick_connected[jid] = true;
        inputstate.gamepad_info[jid].joystick_id = jid;
#if !defined(__EMSCRIPTEN__)
        inputstate.gamepad_info[jid].is_gamepad = glfwJoystickIsGamepad(jid);
        inputstate.gamepad_info[jid].name = inputstate.gamepad_info[jid].is_gamepad  ? glfwGetGamepadName(jid) : glfwGetJoystickName(jid);
#else
        inputstate.gamepad_info[jid].is_gamepad = true; // TODO: check if everything in webasm is gamepad or other joysticks are used too...
        inputstate.gamepad_info[jid].name =  glfwGetJoystickName(jid);
#endif
    } else if (event == GLFW_DISCONNECTED) {
        inputstate.joystick_connected[jid] = false;
#if !defined(__EMSCRIPTEN__)
        inputstate.gamepad_info[jid].is_gamepad = false;
#endif
        inputstate.gamepad_info[jid].name = "";
    }
}

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods) {
    // if (key == GLFW_KEY_ENTER && action == GLFW_PRESS && mods&GLFW_MOD_ALT) {
    //     M_app_setfullscreen(!_lib->fullscreen);
    // } else if (key == GLFW_KEY_BACKSPACE && action == GLFW_PRESS && mods&GLFW_MOD_ALT) {
    //     M_app_quit();
    // } else {
        if (action == GLFW_PRESS) {
            inputstate.keys_cur[key] = true;
        } else if (action == GLFW_RELEASE) {
            inputstate.keys_cur[key] = false;
            inputstate.keys_rep[key] = false;
        } else if (action == GLFW_REPEAT) {
            inputstate.keys_rep[key] = true;
        } else {
            // ASSERT(false);
        }
    // }
}

static void character_callback(GLFWwindow* window, unsigned codepoint) {
    if (inputstate.textinput_idx <= LYTE_MAX_CHARINPUT_CODEPOINTS) {
        inputstate.textinput_data[inputstate.textinput_idx] = codepoint;
        inputstate.textinput_idx++;
    } else {
        fprintf(stderr, "Warning: Too many char inputs in one frame. Only few expected per frame.");
    }
}

static void textinput_reset(void) {
    memset(inputstate.textinput_data, 0, sizeof(inputstate.textinput_data));
    inputstate.textinput_idx = 0;
}

int lyte_core_input_init(void) {
    glfwSetCursorPosCallback(lytecore_state.window, cursor_position_callback);
    glfwSetMouseButtonCallback(lytecore_state.window, mouse_button_callback);
    glfwSetScrollCallback(lytecore_state.window, mouse_scroll_callback);
    glfwSetKeyCallback(lytecore_state.window, key_callback);
    glfwSetJoystickCallback(joystick_callback);
    glfwSetCharCallback(lytecore_state.window, character_callback);
    textinput_reset(); // zero out first frame's text input
    return 0;
}

int lyte_core_input_cleanup(void) {

    return 9;
}

int lyte_core_input_update_state(void) {
    // keyboard keys
    memcpy(inputstate.keys_prev, inputstate.keys_cur, LYTE_MAX_KEYBOARD_KEYS);
    memset(inputstate.keys_rep, 0, LYTE_MAX_KEYBOARD_KEYS);
    // mouse buttons
    memcpy(inputstate.mousebuttons_prev, inputstate.mousebuttons_cur, LYTE_MAX_MOUSEBUTTONS);
    // gamepad/joystick states
    memcpy(inputstate.gamepad_states_prev, inputstate.gamepad_states_cur, sizeof(GLFWgamepadstate) * LYTE_MAX_JOYSTICKS);
    for (int i=0; i<LYTE_MAX_JOYSTICKS; i++) {
#if !defined(__EMSCRIPTEN__)
        if (glfwGetGamepadState(i, &inputstate.gamepad_states_cur[i])) { /* TODO: we could count num  gamepads here for convenience */
        }
#else
        // emscripten... doesn't have gamepad API for glfw. just joystics.
        int count;
        const float* axes = glfwGetJoystickAxes(i, &count);
        // printf("Num gamepad axes: Count: %d", count);
        // ASSERT_(count <= M_NUM_GAMEPADAXISES, "Too many gamepad axes. Possibly internal error.");
        for (int a=0; a<count; a++) {
            inputstate.gamepad_states_cur[i].axes[a] = axes[a];
        }
        const unsigned char* buttons = glfwGetJoystickButtons(i, &count);
        // printf("Num gamepad buttons: Count: %d", count);
        // ASSERT_(count <= M_NUM_GAMEPADBUTTONS*2, "Too many gamepad buttons. Possibly internal error");
        for (int a=0; a<count; a++) {
            inputstate.gamepad_states_cur[i].buttons[a] = buttons[a];
        }
        // MG NOTE:
        // wasm case: trigger axises in webstandards is that they are buttons.
        // so map the buttons to axises here. if pressed 1.0 if not 0.0.
        // good enough for web demos, unless your game heavily depends on trigger sensitivity
        if (inputstate.gamepad_states_cur[i].buttons[LYTE_GAMEPADBUTTON_INTERNAL_LEFT_TRIGGER]) {
            inputstate.gamepad_states_cur[i].axes[LYTE_GAMEPADAXIS_LEFT_TRIGGER] = 1.0;
        } else {
            inputstate.gamepad_states_cur[i].axes[LYTE_GAMEPADAXIS_LEFT_TRIGGER] = 0.0;
        }
        if (inputstate.gamepad_states_cur[i].buttons[LYTE_GAMEPADBUTTON_INTERNAL_RIGHT_TRIGGER]) {
            inputstate.gamepad_states_cur[i].axes[LYTE_GAMEPADAXIS_RIGHT_TRIGGER] = 1.0;
        } else {
            inputstate.gamepad_states_cur[i].axes[LYTE_GAMEPADAXIS_RIGHT_TRIGGER] = 0.0;
        }

#endif
    }
    // reset mouse scroll values
    mouse_scroll_reset();
    // reset  text input values
    textinput_reset();
    return 0;
}


int lyte_is_key_down(lyte_KeyboardKey key, bool *val) {
    *val = inputstate.keys_cur[key];
    return 0;
}

int lyte_is_key_pressed(lyte_KeyboardKey key, bool *val) {
    *val = inputstate.keys_cur[key] && !inputstate.keys_prev[key];
    return 0;
}

int lyte_is_key_released(lyte_KeyboardKey key, bool *val) {
    *val = !inputstate.keys_cur[key] && inputstate.keys_prev[key];
    return 0;
}

int lyte_is_key_repeat(lyte_KeyboardKey key, bool *val) {
    *val = inputstate.keys_rep[key];
    return 0;
}

int lyte_get_pressed_keys(int **keys, size_t *num_keys) {
    static int pressed_keys[LYTE_MAX_KEYLIST];
    memset(pressed_keys, 0, sizeof(int)*LYTE_MAX_KEYLIST);
    int cnt = 0;
    for (int i=0; i < sizeof(inputstate.keys_cur); i++) {
        if(inputstate.keys_cur[i] && !inputstate.keys_prev[i]) {
            pressed_keys[cnt] = i;
            cnt++;
        }
        if (cnt == LYTE_MAX_KEYLIST) { break; }
    }
    *keys = pressed_keys;
    *num_keys = cnt;
    return 0;
}

int lyte_get_textinput(const char **val) {
    static char _buf[LYTE_TEXTINPUT_BUF_SIZE];
    char *buf = _buf;
    memset(buf, 0, sizeof(buf));
    int err = utf8encode_into(inputstate.textinput_data, inputstate.textinput_idx, &buf, LYTE_TEXTINPUT_BUF_SIZE);
    *val = buf;
    return 0;
}

int lyte_is_mouse_down(lyte_MouseButton mouse_button, bool *val) {
    *val =  inputstate.mousebuttons_cur[mouse_button];
    return 0;
}

int lyte_is_mouse_pressed(lyte_MouseButton mouse_button, bool *val) {
    *val = inputstate.mousebuttons_cur[mouse_button] && !inputstate.mousebuttons_prev[mouse_button];
    return 0;
}

int lyte_is_mouse_released(lyte_MouseButton mouse_button, bool *val) {
    *val = !inputstate.mousebuttons_cur[mouse_button] && inputstate.mousebuttons_prev[mouse_button];
    return 0;
}

int lyte_get_mouse_x(int *val) {
    *val = inputstate.mouse_x - lytecore_state.window_margins.left - lytecore_state.window_paddings.left;
    return 0;
}

int lyte_get_mouse_y(int *val) {
    *val = inputstate.mouse_y - lytecore_state.window_margins.top - lytecore_state.window_paddings.top;
    return 0;
}

int lyte_get_gamepad_count(int *val) {
    int cnt = 0;
    for (int i=0; i<LYTE_MAX_JOYSTICKS; i++) {
        if (inputstate.gamepad_info[i].is_gamepad) {
            cnt++;
        }
    }
    *val = cnt;
    return 0;
}

int lyte_get_gamepad_name(int index, const char * *val) {
    *val = inputstate.gamepad_info[index].name;
    return 0;
}

int lyte_is_gamepad_down(int index, lyte_GamepadButton gamepad_button, bool *val) {
    *val = inputstate.gamepad_states_cur[index].buttons[gamepad_button];
    return 0;
}

int lyte_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val) {
    *val = inputstate.gamepad_states_cur[index].buttons[gamepad_button] && !inputstate.gamepad_states_prev[index].buttons[gamepad_button];
    return 0;
}

int lyte_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val) {
    *val = !inputstate.gamepad_states_cur[index].buttons[gamepad_button] && inputstate.gamepad_states_prev[index].buttons[gamepad_button];
    return 0;
}

int lyte_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val) {
    *val = inputstate.gamepad_states_cur[index].axes[gamepad_axis];
    return 0;
}
