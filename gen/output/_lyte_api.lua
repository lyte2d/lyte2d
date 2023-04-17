{
    _kind = "namespace",
    _name = "lyte",
    items = { {
            _kind = "function",
            _name = "tick",
            _tags = {
                c_api_skip = true,
                d = "Tick function. Should be created by the user."
            },
            args = { {
                    _name = "delta_time",
                    _tags = {
                        default = 0,
                        optional = true
                    },
                    value = "number"
                }, {
                    _name = "window_width",
                    _tags = {
                        default = 0,
                        optional = true
                    },
                    value = "integer"
                }, {
                    _name = "window_height",
                    _tags = {
                        default = 0,
                        optional = true
                    },
                    value = "integer"
                }, {
                    _name = "window_resized",
                    _tags = {
                        default = false,
                        optional = true
                    },
                    value = "boolean"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "cls",
            _tags = {
                d = "Clear the screen or current canvas if one is used."
            },
            args = { {
                    _name = "r",
                    value = "number"
                }, {
                    _name = "g",
                    value = "number"
                }, {
                    _name = "b",
                    value = "number"
                }, {
                    _name = "a",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_circle",
            _tags = {
                c_api_skip = true,
                d = "Draw a filled circle."
            },
            args = { {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                }, {
                    _name = "radius",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_circle_line",
            _tags = {
                c_api_skip = true,
                d = "Draw a circle border."
            },
            args = { {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                }, {
                    _name = "radius",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_image",
            _tags = {
                d = "Draw an image."
            },
            args = { {
                    _name = "image",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Image"
                }, {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_image_rect",
            _tags = {
                d = "Draw a rectangular area from the image."
            },
            args = { {
                    _name = "image",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Image"
                }, {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                }, {
                    _name = "src_x",
                    value = "integer"
                }, {
                    _name = "src_y",
                    value = "integer"
                }, {
                    _name = "rect_width",
                    value = "integer"
                }, {
                    _name = "rect_height",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_line",
            _tags = {
                d = "Draw a line"
            },
            args = { {
                    _name = "x1",
                    value = "integer"
                }, {
                    _name = "y1",
                    value = "integer"
                }, {
                    _name = "x2",
                    value = "integer"
                }, {
                    _name = "y2",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_point",
            _tags = {
                d = "Draw a point."
            },
            args = { {
                    _name = "x",
                    value = "integer"
                }, {
                    _name = "y",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_rect",
            _tags = {
                d = "Draw a filled rectangle."
            },
            args = { {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                }, {
                    _name = "rect_width",
                    value = "integer"
                }, {
                    _name = "rect_height",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_rect_line",
            _tags = {
                d = "Draw a rectangle border."
            },
            args = { {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                }, {
                    _name = "rect_width",
                    value = "integer"
                }, {
                    _name = "rect_height",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "draw_text",
            _tags = {
                d = "Draw a text line."
            },
            args = { {
                    _name = "text",
                    value = "string"
                }, {
                    _name = "dest_x",
                    value = "integer"
                }, {
                    _name = "dest_y",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "get_gamepad_axis",
            _tags = {
                d = "Get the given axis of the gamepad at the given index."
            },
            args = { {
                    _name = "index",
                    value = "integer"
                }, {
                    _name = "gamepad_axis",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "GamepadAxis"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_gamepad_count",
            _tags = {
                d = "Get the number of gamepads."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_gamepad_name",
            _tags = {
                d = "Get the name of the gamepad at the given index."
            },
            args = { {
                    _name = "index",
                    value = "integer"
                } },
            rets = { {
                    _name = "val",
                    value = "string"
                } }
        }, {
            _kind = "function",
            _name = "get_mastervolume",
            _tags = {
                d = "Get the master volume."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_mouse_x",
            _tags = {
                d = "Get the mouse x position."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_mouse_y",
            _tags = {
                d = "Get the mouse y position."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_music_length",
            _tags = {
                d = "Get the length of the given music object in seconds."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_music_length_played",
            _tags = {
                d = "Get the already played length of the given music object in seconds."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_music_pan",
            _tags = {
                d = "Get the pan of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_music_pitch",
            _tags = {
                d = "Get the pitch of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_music_volume",
            _tags = {
                d = "Get the volume of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sound_pan",
            _tags = {
                d = "Get the pan of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sound_pitch",
            _tags = {
                d = "Get the pitch of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sound_volume",
            _tags = {
                d = "Get the volume of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sounddata_pan",
            _tags = {
                d = "Get the pan of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sounddata_pitch",
            _tags = {
                d = "Get the pitch of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_sounddata_volume",
            _tags = {
                d = "Get the volume of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                } },
            rets = { {
                    _name = "val",
                    value = "number"
                } }
        }, {
            _kind = "function",
            _name = "get_text_width",
            _tags = {
                d = "Get the width of the given text line."
            },
            args = { {
                    _name = "text",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_text_height",
            _tags = {
                d = "Get the height of the given text line."
            },
            args = { {
                    _name = "text",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_window_width",
            _tags = {
                d = "Get the width of the window."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_window_height",
            _tags = {
                d = "Get the height of the window."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_image_width",
            _tags = {
                d = "Get the width of the image."
            },
            args = { {
                    _name = "image",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Image"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_image_height",
            _tags = {
                d = "Get the height of the image."
            },
            args = { {
                    _name = "image",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Image"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_canvas_width",
            _tags = {
                d = "Get the width of the canvase"
            },
            args = { {
                    _name = "canvas",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Canvas"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_canvas_height",
            _tags = {
                d = "Get the height of the canvas."
            },
            args = { {
                    _name = "canvas",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Canvas"
                } },
            rets = { {
                    _name = "val",
                    value = "integer"
                } }
        }, {
            _kind = "function",
            _name = "get_canvas_image",
            _tags = {
                d = "Get the current attached image object of the canvas."
            },
            args = { {
                    _name = "canvas",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Canvas"
                } },
            rets = { {
                    _name = "val",
                    value = "Image"
                } }
        }, {
            _kind = "function",
            _name = "is_fullscreen",
            _tags = {
                d = "Check if the window is set to fullscreen."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_gamepad_down",
            _tags = {
                d = "Check if the given button of the gamepad at the given index is down."
            },
            args = { {
                    _name = "index",
                    value = "integer"
                }, {
                    _name = "gamepad_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "GamepadButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_gamepad_pressed",
            _tags = {
                d = "Check if the given button of the gamepad at the given index is pressed."
            },
            args = { {
                    _name = "index",
                    value = "integer"
                }, {
                    _name = "gamepad_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "GamepadButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_gamepad_released",
            _tags = {
                d = "Check if the given button of the gamepad at the given index is released."
            },
            args = { {
                    _name = "index",
                    value = "integer"
                }, {
                    _name = "gamepad_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "GamepadButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_key_down",
            _tags = {
                d = "Check if the given key is down."
            },
            args = { {
                    _name = "key",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "KeyboardKey"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_key_pressed",
            _tags = {
                d = "Check if the given key is pressed."
            },
            args = { {
                    _name = "key",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "KeyboardKey"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_key_released",
            _tags = {
                d = "Check if the given key is released."
            },
            args = { {
                    _name = "key",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "KeyboardKey"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_key_repeat",
            _tags = {
                d = "Check if the given key is repeated."
            },
            args = { {
                    _name = "key",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "KeyboardKey"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_mouse_down",
            _tags = {
                d = "Check if the given mouse button is down."
            },
            args = { {
                    _name = "mouse_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "MouseButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_mouse_pressed",
            _tags = {
                d = "Check if the given mouse button is pressed."
            },
            args = { {
                    _name = "mouse_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "MouseButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_mouse_released",
            _tags = {
                d = "Check if the given mouse button is released."
            },
            args = { {
                    _name = "mouse_button",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "MouseButton"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_music_playing",
            _tags = {
                d = "Check if the given music is playing."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_sound_playing",
            _tags = {
                d = "Check if the given sound is playing."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "is_window_vsync",
            _tags = {
                d = "Check if the window vsync flag is set."
            },
            args = {},
            rets = { {
                    _name = "val",
                    value = "boolean"
                } }
        }, {
            _kind = "function",
            _name = "load_file",
            _tags = {
                d = "Load the file in the path."
            },
            args = { {
                    _name = "file_path",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    value = "string"
                } }
        }, {
            _kind = "function",
            _name = "load_font",
            _tags = {
                ctor = true,
                d = "Load the font specified in the path, and set the initial size."
            },
            args = { {
                    _name = "font_path",
                    value = "string"
                }, {
                    _name = "size",
                    value = "number"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Font"
                } }
        }, {
            _kind = "function",
            _name = "load_image",
            _tags = {
                ctor = true,
                d = "Load the image specified in the path."
            },
            args = { {
                    _name = "image_path",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Image"
                } }
        }, {
            _kind = "function",
            _name = "load_music",
            _tags = {
                ctor = true,
                d = "Load the music specified in the path."
            },
            args = { {
                    _name = "music_path",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } }
        }, {
            _kind = "function",
            _name = "load_sounddata",
            _tags = {
                ctor = true,
                d = "Load the sounddata specified in the path."
            },
            args = { {
                    _name = "sounddata_path",
                    value = "string"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                } }
        }, {
            _kind = "function",
            _name = "new_canvas",
            _tags = {
                ctor = true,
                d = "Create a canvas with given width and height."
            },
            args = { {
                    _name = "width",
                    value = "integer"
                }, {
                    _name = "height",
                    value = "integer"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Canvas"
                } }
        }, {
            _kind = "function",
            _name = "new_shader",
            _tags = {
                ctor = true,
                d = "Create a shader with given specification."
            },
            args = { {
                    _name = "shaderdef",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "ShaderDef"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Shader"
                } }
        }, {
            _kind = "function",
            _name = "new_sound",
            _tags = {
                ctor = true,
                d = "Create a sound from given sounddata."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                } },
            rets = { {
                    _name = "val",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } }
        }, {
            _kind = "function",
            _name = "pause_music",
            _tags = {
                d = "Pause the music."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "pause_sound",
            _tags = {
                d = "Pause the sound."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "play_music",
            _tags = {
                d = "Play the music."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "play_sound",
            _tags = {
                d = "Play the sound."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "pop_matrix",
            _tags = {
                d = "Pop the transform matrix."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "push_matrix",
            _tags = {
                d = "Push the transform matrix."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "quit",
            _tags = {
                d = "Quit the application by closing the window."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_blendmode",
            _tags = {
                d = "Reset the blendmode value to its default value."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_canvas",
            _tags = {
                d = "Reset the drawing target, back to screen."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_color",
            _tags = {
                d = "Reset the color to its default value."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_filtermode",
            _tags = {
                d = "Reset the filtermode value to its default value."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_font",
            _tags = {
                d = "Reset the font to its default value."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_matrix",
            _tags = {
                d = "Reset the transformation matrix (load identity matrix.)"
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "reset_shader",
            _tags = {
                d = "Reset the shader, back to framework defaults."
            },
            args = {},
            rets = {}
        }, {
            _kind = "function",
            _name = "resume_music",
            _tags = {
                d = "Resume the music."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "resume_sound",
            _tags = {
                d = "Resume the sound."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "rotate",
            _tags = {
                d = "Apply rotation (changes transform matrix.)"
            },
            args = { {
                    _name = "angle",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "rotate_at",
            _tags = {
                d = "Apply rotation at the given location (changes transform matrix.)"
            },
            args = { {
                    _name = "angle",
                    value = "number"
                }, {
                    _name = "x",
                    value = "integer"
                }, {
                    _name = "y",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "save_file_append",
            _tags = {
                d = "Append the data to the file in the path. Append at the end if the file exists. Create if it doesn't exist."
            },
            args = { {
                    _name = "file_path",
                    value = "string"
                }, {
                    _name = "data",
                    value = "string"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "save_file_write",
            _tags = {
                d = "Append the data to the file in the path. Override if the file exists. Create if it doesn't exist."
            },
            args = { {
                    _name = "file_path",
                    value = "string"
                }, {
                    _name = "data",
                    value = "string"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "scale",
            _tags = {
                d = "Apply scaling (changes transform matrix.)"
            },
            args = { {
                    _name = "scale_x",
                    value = "number"
                }, {
                    _name = "scale_y",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "scale_at",
            _tags = {
                d = "Apply scaling at the given location (changes transform matrix.)"
            },
            args = { {
                    _name = "scale_x",
                    value = "integer"
                }, {
                    _name = "scale_y",
                    value = "integer"
                }, {
                    _name = "x",
                    value = "number"
                }, {
                    _name = "y",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "seek_music",
            _tags = {
                d = "Move the music time played to the given value."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                }, {
                    _name = "secs",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "send_shader_uniforms",
            _tags = {
                d = "Send the shader specified uniforms. Set value to '0' to delete the specified uniform. Unspecified uniforms are not changed."
            },
            args = { {
                    _name = "shader",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Shader"
                }, {
                    _name = "uniforms",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "ShaderUniforms"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_blendmode",
            _tags = {
                d = "Set the effective blendmode."
            },
            args = { {
                    _name = "blendmode",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "BlendMode"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_canvas",
            _tags = {
                d = "Set the effective canvas. All draw operations will go to this canvas until it's reset."
            },
            args = { {
                    _name = "canvas",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Canvas"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_color",
            _tags = {
                d = "Set the foreground color to be used in the drawing operations."
            },
            args = { {
                    _name = "r",
                    value = "number"
                }, {
                    _name = "g",
                    value = "number"
                }, {
                    _name = "b",
                    value = "number"
                }, {
                    _name = "a",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_default_blendmode",
            _tags = {
                d = "Set the default blendmode."
            },
            args = { {
                    _name = "blendmode",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "BlendMode"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_default_filtermode",
            _tags = {
                d = "Set the default filtermode."
            },
            args = { {
                    _name = "filtermode",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "FilterMode"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_filtermode",
            _tags = {
                d = "Set the effective filtermode."
            },
            args = { {
                    _name = "filtermode",
                    _tags = {
                        nativetype = "enumstring"
                    },
                    value = "FilterMode"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_font",
            _tags = {
                d = "Set the effective font to be used in the drawing operations."
            },
            args = { {
                    _name = "font",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Font"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_fullscreen",
            _tags = {
                d = "Set the window to fullscreen, or windowed mode."
            },
            args = { {
                    _name = "fullscreen",
                    value = "boolean"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_mastervolume",
            _tags = {
                d = "Set the master volume."
            },
            args = { {
                    _name = "mastervolume",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_music_pan",
            _tags = {
                d = "Set the pan of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                }, {
                    _name = "pan",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_music_pitch",
            _tags = {
                d = "Set the pitch of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                }, {
                    _name = "pitch",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_music_volume",
            _tags = {
                d = "Set the volume of the given music object."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                }, {
                    _name = "volume",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_shader",
            _tags = {
                d = "Set the custom shader and use it for consequent calls."
            },
            args = { {
                    _name = "shader",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Shader"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sound_pan",
            _tags = {
                d = "Set the pan of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                }, {
                    _name = "pan",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sound_pitch",
            _tags = {
                d = "Set the pitch of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                }, {
                    _name = "pitch",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sound_volume",
            _tags = {
                d = "Set the volume of the given sound object."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                }, {
                    _name = "volume",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sounddata_pan",
            _tags = {
                d = "Set the pan of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                }, {
                    _name = "pan",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sounddata_pitch",
            _tags = {
                d = "Set the pitch of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                }, {
                    _name = "pitch",
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_sounddata_volume",
            _tags = {
                d = "Set the volume of the given sounddata object."
            },
            args = { {
                    _name = "sounddata",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "SoundData"
                }, {
                    _name = "volume",
                    _tags = {
                        range = { 0, 1 }
                    },
                    value = "number"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_icon",
            _tags = {
                d = "Set the window icon."
            },
            args = { {
                    _name = "icon_path",
                    value = "string"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_margins",
            _tags = {
                d = "Set the window margins. Margins are ignored and no drawing can be made there.."
            },
            args = { {
                    _name = "left",
                    value = "integer"
                }, {
                    _name = "right",
                    value = "integer"
                }, {
                    _name = "top",
                    value = "integer"
                }, {
                    _name = "bottom",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_minsize",
            _tags = {
                d = "Set the window's minimum possible size."
            },
            args = { {
                    _name = "width",
                    value = "integer"
                }, {
                    _name = "height",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_paddings",
            _tags = {
                d = "Set the window paddings. Paddings are can be drawn on."
            },
            args = { {
                    _name = "left",
                    value = "integer"
                }, {
                    _name = "right",
                    value = "integer"
                }, {
                    _name = "top",
                    value = "integer"
                }, {
                    _name = "bottom",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_size",
            _tags = {
                d = "Set the window's size."
            },
            args = { {
                    _name = "width",
                    value = "integer"
                }, {
                    _name = "height",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_title",
            _tags = {
                d = "Set the window's title."
            },
            args = { {
                    _name = "title",
                    value = "string"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "set_window_vsync",
            _tags = {
                d = "Set the window vsync flag to the given value."
            },
            args = { {
                    _name = "vsync",
                    value = "boolean"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "stop_music",
            _tags = {
                d = "Stop the music."
            },
            args = { {
                    _name = "music",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Music"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "stop_sound",
            _tags = {
                d = "Stop the sound."
            },
            args = { {
                    _name = "sound",
                    _tags = {
                        nativetype = "udata"
                    },
                    value = "Sound"
                } },
            rets = {}
        }, {
            _kind = "function",
            _name = "translate",
            _tags = {
                d = "Apply translation (changes transform matrix.)"
            },
            args = { {
                    _name = "delta_x",
                    value = "integer"
                }, {
                    _name = "delta_y",
                    value = "integer"
                } },
            rets = {}
        }, {
            _kind = "alias",
            _name = "ShaderUniforms",
            alias_value = {
                _kind = "dict",
                _tags = {
                    d = "ShaderUniforms record. Table of names mapped to uniform values."
                },
                dict_key = "string",
                dict_value = {
                    _kind = "oneof",
                    options = { {
                            value = "integer"
                        }, {
                            value = "number"
                        }, {
                            value = {
                                _kind = "list",
                                list_value = "integer"
                            }
                        }, {
                            value = {
                                _kind = "list",
                                list_value = "number"
                            }
                        }, {
                            _tags = {
                                nativetype = "udata"
                            },
                            value = "Image"
                        } }
                }
            }
        }, {
            _kind = "record",
            _name = "ShaderDef",
            _tags = {
                d = "Shader definition: uniforms declaration, vertex and fragment shader code."
            },
            items = { {
                    _kind = "prop",
                    _name = "frag",
                    value = "string"
                }, {
                    _kind = "prop",
                    _name = "vert",
                    value = "string"
                }, {
                    _kind = "prop",
                    _name = "uniforms",
                    value = {
                        _kind = "dict",
                        _tags = {
                            value_nativetype = "enumstring"
                        },
                        dict_key = "string",
                        dict_value = "UniformType"
                    }
                } }
        }, {
            _kind = "record",
            _name = "Shader",
            _tags = {
                d = "Shader type"
            },
            items = { {
                    _kind = "method",
                    _name = "send",
                    args = { {
                            _name = "uniforms",
                            _tags = {
                                nativetype = "udata"
                            },
                            value = "ShaderUniforms"
                        } },
                    rets = {}
                } }
        }, {
            _kind = "record",
            _name = "Canvas",
            _tags = {
                d = "Canvas type. Can be used for offscreen drawing to create images."
            },
            items = { {
                    _kind = "prop",
                    _name = "image",
                    _tags = {
                        map_read = "get_canvas_image",
                        nativetype = "udata"
                    },
                    value = "Image"
                }, {
                    _kind = "prop",
                    _name = "width",
                    _tags = {
                        map_read = "get_canvas_width"
                    },
                    value = "integer"
                }, {
                    _kind = "prop",
                    _name = "height",
                    _tags = {
                        map_read = "get_canvas_height"
                    },
                    value = "integer"
                } }
        }, {
            _kind = "record",
            _name = "Font",
            _tags = {
                d = "Font type."
            },
            items = {}
        }, {
            _kind = "record",
            _name = "Image",
            _tags = {
                d = "Image type."
            },
            items = { {
                    _kind = "prop",
                    _name = "width",
                    _tags = {
                        map_read = "get_image_width"
                    },
                    value = "integer"
                }, {
                    _kind = "prop",
                    _name = "height",
                    _tags = {
                        map_read = "get_image_height"
                    },
                    value = "integer"
                } }
        }, {
            _kind = "record",
            _name = "Music",
            _tags = {
                d = "Music type."
            },
            items = { {
                    _kind = "prop",
                    _name = "playing",
                    _tags = {
                        map_read = "is_music_playing"
                    },
                    value = "boolean"
                }, {
                    _kind = "prop",
                    _name = "length",
                    _tags = {
                        map_read = "get_music_length"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "length_played",
                    _tags = {
                        map_read = "get_music_length_played"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "pan",
                    _tags = {
                        map_read = "get_music_pan",
                        map_write = "set_music_pan"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "pitch",
                    _tags = {
                        map_read = "get_music_pitch",
                        map_write = "set_music_pitch"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "volume",
                    _tags = {
                        map_read = "get_music_volume",
                        map_write = "set_music_volume"
                    },
                    value = "number"
                }, {
                    _kind = "method",
                    _name = "play",
                    _tags = {
                        map_to = "play_music"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "pause",
                    _tags = {
                        map_to = "pause_music"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "resume",
                    _tags = {
                        map_to = "resume _music"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "stop",
                    _tags = {
                        map_to = "stop_music"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "seek",
                    _tags = {
                        map_to = "seek_music"
                    },
                    args = { {
                            _name = "secs",
                            value = "number"
                        } },
                    rets = {}
                } }
        }, {
            _kind = "record",
            _name = "Sound",
            _tags = {
                d = "Sound type."
            },
            items = { {
                    _kind = "prop",
                    _name = "pan",
                    _tags = {
                        map_read = "get_sound_pan",
                        map_write = "set_sound_pan"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "pitch",
                    _tags = {
                        map_read = "get_sound_pitch",
                        map_write = "set_sound_pitch"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "volume",
                    _tags = {
                        map_read = "get_sound_volume",
                        map_write = "set_sound_volume"
                    },
                    value = "number"
                }, {
                    _kind = "method",
                    _name = "pause",
                    _tags = {
                        map_to = "pause_sound"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "play",
                    _tags = {
                        map_to = "play_sound"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "resume",
                    _tags = {
                        map_to = "resume_sound"
                    },
                    args = {},
                    rets = {}
                }, {
                    _kind = "method",
                    _name = "stop",
                    _tags = {
                        map_to = "stop_sound"
                    },
                    args = {},
                    rets = {}
                } }
        }, {
            _kind = "record",
            _name = "SoundData",
            _tags = {
                d = "SoundData type."
            },
            items = { {
                    _kind = "prop",
                    _name = "pan",
                    _tags = {
                        map_read = "get_sounddata_pan",
                        map_write = "set_sounddata_pan"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "pitch",
                    _tags = {
                        map_read = "get_sounddata_pitch",
                        map_write = "set_sounddata_pitch"
                    },
                    value = "number"
                }, {
                    _kind = "prop",
                    _name = "volume",
                    _tags = {
                        map_read = "get_sounddata_volume",
                        map_write = "set_sounddata_volume"
                    },
                    value = "number"
                } }
        }, {
            _kind = "enum",
            _name = "UniformType",
            _tags = {
                d = "Acceptable uniformtype values."
            },
            choices = { "_invalid", "float", "vec2", "vec3", "vec4", "int", "ivec2", "ivec3", "ivec4", "mat4", "sampler2D" }
        }, {
            _kind = "enum",
            _name = "BlendMode",
            _tags = {
                d = "Acceptable blendmode values."
            },
            choices = { "none", "blend", "add", "mod", "mul" }
        }, {
            _kind = "enum",
            _name = "FilterMode",
            _tags = {
                d = "Acceptable filtermode values."
            },
            choices = { "_invalid", "nearest", "linear" }
        }, {
            _kind = "enum",
            _name = "GamepadAxis",
            _tags = {
                d = "Acceptable gamepadaxis values."
            },
            choices = { "left_x", "left_y", "right_x", "right_y", "left_trigger", "right_trigger" }
        }, {
            _kind = "enum",
            _name = "GamepadButton",
            _tags = {
                d = "Acceptable gamepadbutton values."
            },
            choices = { "pad_a", "pad_b", "pad_x", "pad_y", "left_bumper", "right_bumper", "back", "start", "guide", "left_thumb", "right_thumb", "dpad_up", "dpad_right", "dpad_down", "dpad_left" }
        }, {
            _kind = "enum",
            _name = "MouseButton",
            _tags = {
                d = "Acceptable mousebutton values."
            },
            choices = { "mb1", "mb2", "mb3", "mb4", "mb5", "mb6", "mb7", "mb8" }
        }, {
            _kind = "enum",
            _name = "KeyboardKey",
            _tags = {
                d = "Acceptable keyboardkey values."
            },
            choices = { "space", "'", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ";", "=", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "[", "\\", "]", "`", "world_1", "world_2", "escape", "enter", "tab", "backspace", "insert", "delete", "right", "left", "down", "up", "page_up", "page_down", "home", "end", "caps_lock", "scroll_lock", "num_lock", "print_screen", "pause", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23", "f24", "f25", "kp_0", "kp_1", "kp_2", "kp_3", "kp_4", "kp_5", "kp_6", "kp_7", "kp_8", "kp_9", "kp_decimal", "kp_divide", "kp_multiply", "kp_subtract", "kp_add", "kp_enter", "kp_equal", "left_shift", "left_control", "left_alt", "left_super", "right_shift", "right_control", "right_alt", "right_super", "menu" }
        } }
}
