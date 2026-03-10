//

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "_internal.h"
#include "utf8encode.h"
#include "sokol_app.h"

#define MG_IMPLEMENTATION
#include "minigamepad.h"

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
    mg_gamepads gamepads;
    uint8_t joystick_connected[LYTE_MAX_JOYSTICKS];
    struct {
        int joystick_id;
        bool is_gamepad;
        const char *name;
    } gamepad_info[LYTE_MAX_JOYSTICKS];
    //GLFWgamepadstate gamepad_states_prev[LYTE_MAX_JOYSTICKS];
    //GLFWgamepadstate gamepad_states_cur[LYTE_MAX_JOYSTICKS];

} lyte_InputState;


static lyte_InputState inputstate = {0};

void lyte_core_input_poll(void) {
    mg_gamepads_poll(&inputstate.gamepads);
}

void lyte_core_input_event(const sapp_event * event) {
    switch (event->type) {
    case SAPP_EVENTTYPE_KEY_DOWN:
        inputstate.keys_cur[event->key_code] = true;
        if (event->key_repeat) {
            inputstate.keys_rep[event->key_code] = true;
        }
        break;
    case SAPP_EVENTTYPE_KEY_UP:
        if (event->key_repeat) {
            inputstate.keys_rep[event->key_code] = false;
        } else {
            inputstate.keys_cur[event->key_code] = false;
        }
        break;
    case SAPP_EVENTTYPE_CHAR:
        if (inputstate.textinput_idx <= LYTE_MAX_CHARINPUT_CODEPOINTS) {
            inputstate.textinput_data[inputstate.textinput_idx] = event->char_code;
            inputstate.textinput_idx++;
        } else {
            fprintf(stderr, "Warning: Too many char inputs in one frame. Only few expected per frame.");
        }
        break;
    case SAPP_EVENTTYPE_MOUSE_DOWN:
        if (event->mouse_button < LYTE_MAX_MOUSEBUTTONS) {
            inputstate.mousebuttons_cur[event->mouse_button] = true;
        }
        break;
    case SAPP_EVENTTYPE_MOUSE_UP:
        if (event->mouse_button < LYTE_MAX_MOUSEBUTTONS) {
            inputstate.mousebuttons_cur[event->mouse_button] = false;
        }
        break;
    case SAPP_EVENTTYPE_MOUSE_SCROLL:
        if (event->scroll_y > 0) {
            inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLUP] = true;
        } else if (event->scroll_y < 0) {
            inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLDOWN] = true;
        }
        break;
    case SAPP_EVENTTYPE_MOUSE_MOVE:
        inputstate.mouse_x = event->mouse_x;
        inputstate.mouse_y = event->mouse_y;
        break;
    case SAPP_EVENTTYPE_MOUSE_ENTER:
        break;
    case SAPP_EVENTTYPE_MOUSE_LEAVE:
        break;
    case SAPP_EVENTTYPE_FOCUSED:
        break;
    case SAPP_EVENTTYPE_UNFOCUSED:
        break;
    }
}


#if 0
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
#endif

static void textinput_reset(void) {
    memset(inputstate.textinput_data, 0, sizeof(inputstate.textinput_data));
    inputstate.textinput_idx = 0;
}

static void mouse_scroll_reset(void) {
    // mouse scroll is handled like any other button from an API point of view. is_down won't work but pressed/released will
    // however glfw does not send "release" events for scroll, so approaching it a bit differently here
    inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLUP] = false;
    inputstate.mousebuttons_cur[LYTE_MOUSEBUTTON_SCROLLDOWN] = false;
}


int lyte_core_input_init(void) {
    textinput_reset(); // zero out first frame's text input
    mg_gamepads_init(&inputstate.gamepads);
    if (inputstate.gamepads.list.head == NULL) {
        fprintf(stderr, "Not connected\n");
    } else {
        fprintf(stderr, "Gamepad found\n");
    }
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
#if 0
    memcpy(inputstate.gamepad_states_prev, inputstate.gamepad_states_cur, sizeof(GLFWgamepadstate) * LYTE_MAX_JOYSTICKS);
    for (int i=0; i<LYTE_MAX_JOYSTICKS; i++) {
        if (glfwGetGamepadState(i, &inputstate.gamepad_states_cur[i])) { /* TODO: we could count num  gamepads here for convenience */
        }
    }
#endif
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
    *val = inputstate.mouse_x;
    return 0;
}

int lyte_get_mouse_y(int *val) {
    *val = inputstate.mouse_y;
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
    *val = false;
    if (inputstate.gamepads.list.head == NULL) {
        return 0;
    }
    mg_gamepad * gamepad = inputstate.gamepads.list.head;
    while (1) {
        if (!gamepad->connected) {
            return 0;
        }
        switch (gamepad_button) {
            case LYTE_GAMEPADBUTTON_PAD_A:
                if (gamepad->buttons[MG_BUTTON_SOUTH].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_B:
                if (gamepad->buttons[MG_BUTTON_EAST].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_X:
                if (gamepad->buttons[MG_BUTTON_WEST].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_Y:
                if (gamepad->buttons[MG_BUTTON_NORTH].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_LEFT_BUMPER:
                if (gamepad->buttons[MG_BUTTON_LEFT_SHOULDER].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_RIGHT_BUMPER:
                if (gamepad->buttons[MG_BUTTON_RIGHT_SHOULDER].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_BACK:
                if (gamepad->buttons[MG_BUTTON_BACK].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_START:
                if (gamepad->buttons[MG_BUTTON_START].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_GUIDE:
                if (gamepad->buttons[MG_BUTTON_GUIDE].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_LEFT_THUMB:
                if (gamepad->buttons[MG_BUTTON_LEFT_STICK].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_RIGHT_THUMB:
                if (gamepad->buttons[MG_BUTTON_RIGHT_STICK].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_UP:
                if (gamepad->buttons[MG_BUTTON_DPAD_UP].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_RIGHT:
                if (gamepad->buttons[MG_BUTTON_DPAD_RIGHT].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_DOWN:
                if (gamepad->buttons[MG_BUTTON_DPAD_DOWN].current)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_LEFT:
                if (gamepad->buttons[MG_BUTTON_DPAD_LEFT].current)
                    *val = true;
                break;
        }
        break;
    }
    return 0;
}

int lyte_is_gamepad_pressed(int index, lyte_GamepadButton gamepad_button, bool *val) {
    *val = false;
    if (inputstate.gamepads.list.head == NULL) {
        return 0;
    }
    mg_gamepad * gamepad = inputstate.gamepads.list.head;
    while (1) {
        if (!gamepad->connected) {
            return 0;
        }
        switch (gamepad_button) {
            case LYTE_GAMEPADBUTTON_PAD_A:
                if (gamepad->buttons[MG_BUTTON_SOUTH].current && !gamepad->buttons[MG_BUTTON_SOUTH].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_B:
                if (gamepad->buttons[MG_BUTTON_EAST].current && !gamepad->buttons[MG_BUTTON_EAST].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_X:
                if (gamepad->buttons[MG_BUTTON_WEST].current && !gamepad->buttons[MG_BUTTON_WEST].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_PAD_Y:
                if (gamepad->buttons[MG_BUTTON_NORTH].current && !gamepad->buttons[MG_BUTTON_NORTH].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_LEFT_BUMPER:
                if (gamepad->buttons[MG_BUTTON_LEFT_SHOULDER].current && !gamepad->buttons[MG_BUTTON_LEFT_SHOULDER].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_RIGHT_BUMPER:
                if (gamepad->buttons[MG_BUTTON_RIGHT_SHOULDER].current && !gamepad->buttons[MG_BUTTON_RIGHT_SHOULDER].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_BACK:
                if (gamepad->buttons[MG_BUTTON_BACK].current && !gamepad->buttons[MG_BUTTON_BACK].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_START:
                if (gamepad->buttons[MG_BUTTON_START].current && !gamepad->buttons[MG_BUTTON_START].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_GUIDE:
                if (gamepad->buttons[MG_BUTTON_GUIDE].current && !gamepad->buttons[MG_BUTTON_GUIDE].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_LEFT_THUMB:
                if (gamepad->buttons[MG_BUTTON_LEFT_STICK].current && !gamepad->buttons[MG_BUTTON_LEFT_STICK].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_RIGHT_THUMB:
                if (gamepad->buttons[MG_BUTTON_RIGHT_STICK].current && !gamepad->buttons[MG_BUTTON_RIGHT_STICK].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_UP:
                if (gamepad->buttons[MG_BUTTON_DPAD_UP].current && !gamepad->buttons[MG_BUTTON_DPAD_UP].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_RIGHT:
                if (gamepad->buttons[MG_BUTTON_DPAD_RIGHT].current && !gamepad->buttons[MG_BUTTON_DPAD_RIGHT].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_DOWN:
                if (gamepad->buttons[MG_BUTTON_DPAD_DOWN].current && !gamepad->buttons[MG_BUTTON_DPAD_DOWN].prev)
                    *val = true;
                break;
            case LYTE_GAMEPADBUTTON_DPAD_LEFT:
                if (gamepad->buttons[MG_BUTTON_DPAD_LEFT].current && !gamepad->buttons[MG_BUTTON_DPAD_LEFT].prev)
                    *val = true;
                break;
        }
        break;
    }
    return 0;
}

int lyte_is_gamepad_released(int index, lyte_GamepadButton gamepad_button, bool *val) {
    //*val = !inputstate.gamepad_states_cur[index].buttons[gamepad_button] && inputstate.gamepad_states_prev[index].buttons[gamepad_button];
    *val = false;
    return 0;
}

int lyte_get_gamepad_axis(int index, lyte_GamepadAxis gamepad_axis, double *val) {
    //*val = inputstate.gamepad_states_cur[index].axes[gamepad_axis];
    *val = 0;
    return 0;
}
