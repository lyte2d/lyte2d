/* (c) mg */

#ifndef _KEYCODE_STR_ENUM_MAP_INL_INCLUDED
#define _KEYCODE_STR_ENUM_MAP_INL_INCLUDED

#include <mb_keyboardkeys.h>

// mimicking love2d key names

struct _KeyEntry {
	const char  *key;
	int val;
};

struct _KeyEntry  _keymappings[] =
{
     	{"space",             M_KEY_SPACE},
     	{"'",             M_KEY_APOSTROPHE}, /* ' */
     	{",",             M_KEY_COMMA}, /* , */
     	{"-",             M_KEY_MINUS}, /* - */
     	{".",             M_KEY_PERIOD}, /* . */
     	{"/",             M_KEY_SLASH}, /* / */
     	{"0",             M_KEY_0},
     	{"1",             M_KEY_1},
     	{"2",             M_KEY_2},
     	{"3",             M_KEY_3},
     	{"4",             M_KEY_4},
     	{"5",             M_KEY_5},
     	{"6",             M_KEY_6},
     	{"7",             M_KEY_7},
     	{"8",             M_KEY_8},
     	{"9",             M_KEY_9},
     	{";",             M_KEY_SEMICOLON}, /* ; */
     	{"=",             M_KEY_EQUAL}, /* = */
     	{"a",             M_KEY_A},
     	{"b",             M_KEY_B},
     	{"c",             M_KEY_C},
     	{"d",             M_KEY_D},
     	{"e",             M_KEY_E},
     	{"f",             M_KEY_F},
     	{"g",             M_KEY_G},
     	{"h",             M_KEY_H},
     	{"i",             M_KEY_I},
     	{"j",             M_KEY_J},
     	{"k",             M_KEY_K},
     	{"l",             M_KEY_L},
     	{"m",             M_KEY_M},
     	{"n",             M_KEY_N},
     	{"o",             M_KEY_O},
     	{"p",             M_KEY_P},
     	{"q",             M_KEY_Q},
     	{"r",             M_KEY_R},
     	{"s",             M_KEY_S},
     	{"t",             M_KEY_T},
     	{"u",             M_KEY_U},
     	{"v",             M_KEY_V},
     	{"w",             M_KEY_W},
     	{"x",             M_KEY_X},
     	{"y",             M_KEY_Y},
     	{"z",             M_KEY_Z},
     	{"[",             M_KEY_LEFT_BRACKET}, /* [ */
     	{"\\",             M_KEY_BACKSLASH}, /* \ */
     	{"]",             M_KEY_RIGHT_BRACKET}, /* ] */
     	{"`",             M_KEY_GRAVE_ACCENT}, /* ` */
     	{"world_1",             M_KEY_WORLD_1}, /* non-US #1 */
     	{"world_2",             M_KEY_WORLD_2}, /* non-US #2 */
     	{"escape",             M_KEY_ESCAPE},
     	{"enter",             M_KEY_ENTER},
     	{"tab",             M_KEY_TAB},
     	{"backspace",             M_KEY_BACKSPACE},
     	{"insert",             M_KEY_INSERT},
     	{"delete",             M_KEY_DELETE},
     	{"right",             M_KEY_RIGHT},
     	{"left",             M_KEY_LEFT},
     	{"down",             M_KEY_DOWN},
     	{"up",             M_KEY_UP},
     	{"page_up",             M_KEY_PAGE_UP},
     	{"page_down",             M_KEY_PAGE_DOWN},
     	{"home",             M_KEY_HOME},
     	{"end",             M_KEY_END},
     	{"caps_lock",             M_KEY_CAPS_LOCK},
     	{"scroll_lock",             M_KEY_SCROLL_LOCK},
     	{"num_lock",             M_KEY_NUM_LOCK},
     	{"print_screen",             M_KEY_PRINT_SCREEN},
     	{"pause",             M_KEY_PAUSE},
     	{"f1",             M_KEY_F1},
     	{"f2",             M_KEY_F2},
     	{"f3",             M_KEY_F3},
     	{"f4",             M_KEY_F4},
     	{"f5",             M_KEY_F5},
     	{"f6",             M_KEY_F6},
     	{"f7",             M_KEY_F7},
     	{"f8",             M_KEY_F8},
     	{"f9",             M_KEY_F9},
     	{"f10",             M_KEY_F10},
     	{"f11",             M_KEY_F11},
     	{"f12",             M_KEY_F12},
     	{"f13",             M_KEY_F13},
     	{"f14",             M_KEY_F14},
     	{"f15",             M_KEY_F15},
     	{"f16",             M_KEY_F16},
     	{"f17",             M_KEY_F17},
     	{"f18",             M_KEY_F18},
     	{"f19",             M_KEY_F19},
     	{"f20",             M_KEY_F20},
     	{"f21",             M_KEY_F21},
     	{"f22",             M_KEY_F22},
     	{"f23",             M_KEY_F23},
     	{"f24",             M_KEY_F24},
     	{"f25",             M_KEY_F25},
     	{"kp_0",             M_KEY_KP_0},
     	{"kp_1",             M_KEY_KP_1},
     	{"kp_2",             M_KEY_KP_2},
     	{"kp_3",             M_KEY_KP_3},
     	{"kp_4",             M_KEY_KP_4},
     	{"kp_5",             M_KEY_KP_5},
     	{"kp_6",             M_KEY_KP_6},
     	{"kp_7",             M_KEY_KP_7},
     	{"kp_8",             M_KEY_KP_8},
     	{"kp_9",             M_KEY_KP_9},
     	{"kp_decimal",             M_KEY_KP_DECIMAL},
     	{"kp_divide",             M_KEY_KP_DIVIDE},
     	{"kp_multiply",             M_KEY_KP_MULTIPLY},
     	{"kp_subtract",             M_KEY_KP_SUBTRACT},
     	{"kp_add",             M_KEY_KP_ADD},
     	{"kp_enter",             M_KEY_KP_ENTER},
     	{"kp_equal",             M_KEY_KP_EQUAL},
     	{"left_shift",             M_KEY_LEFT_SHIFT},
     	{"left_control",             M_KEY_LEFT_CONTROL},
     	{"left_alt",             M_KEY_LEFT_ALT},
     	{"left_super",             M_KEY_LEFT_SUPER},
     	{"right_shift",             M_KEY_RIGHT_SHIFT},
     	{"right_control",             M_KEY_RIGHT_CONTROL},
     	{"right_alt",             M_KEY_RIGHT_ALT},
     	{"right_super",             M_KEY_RIGHT_SUPER},
     	{"menu",             M_KEY_MENU},
};



int _num_keymappings = sizeof(_keymappings)/sizeof(struct _KeyEntry);


#endif  /* _KEYCODE_STR_ENUM_MAP_INL_INCLUDED */
