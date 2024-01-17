return {
    dicts = { {
            doc = "",
            key_type = "string",
            name = "UniformNamesToTypes",
            namespace = "lyte",
            value_type = "UniformType"
        } },
    doc = "\nlyte namespace.",
    enums = { <1>{
            doc = "Acceptable uniformtype values.",
            name = "UniformType",
            namespace = "lyte_core",
            values = { "_invalid", "float", "vec2", "vec3", "vec4", "int", "ivec2", "ivec3", "ivec4", "mat4", "sampler2D" }
        }, <2>{
            doc = "Acceptable blendmode values.",
            name = "BlendMode",
            namespace = "lyte_core",
            values = { "none", "blend", "add", "mod", "mul" }
        }, <3>{
            doc = "Acceptable filtermode values.",
            name = "FilterMode",
            namespace = "lyte_core",
            values = { "_invalid", "nearest", "linear" }
        }, <4>{
            doc = "Acceptable gamepadaxis values.",
            name = "GamepadAxis",
            namespace = "lyte_core",
            values = { "left_x", "left_y", "right_x", "right_y", "left_trigger", "right_trigger" }
        }, <5>{
            doc = "Acceptable gamepadbutton values.",
            name = "GamepadButton",
            namespace = "lyte_core",
            values = { "pad_a", "pad_b", "pad_x", "pad_y", "left_bumper", "right_bumper", "back", "start", "guide", "left_thumb", "right_thumb", "dpad_up", "dpad_right", "dpad_down", "dpad_left" }
        }, <6>{
            doc = "Acceptable mousebutton values.",
            name = "MouseButton",
            namespace = "lyte_core",
            values = { "mb1", "mb2", "mb3", "mb4", "mb5", "mb6", "mb7", "mb8", "scrollup", "scrolldown" }
        }, <7>{
            doc = "Acceptable keyboardkey values.",
            name = "KeyboardKey",
            namespace = "lyte_core",
            values = { "space", "'", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ";", "=", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "[", "\\", "]", "`", "world_1", "world_2", "escape", "enter", "tab", "backspace", "insert", "delete", "right", "left", "down", "up", "page_up", "page_down", "home", "end", "caps_lock", "scroll_lock", "num_lock", "print_screen", "pause", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23", "f24", "f25", "kp_0", "kp_1", "kp_2", "kp_3", "kp_4", "kp_5", "kp_6", "kp_7", "kp_8", "kp_9", "kp_decimal", "kp_divide", "kp_multiply", "kp_subtract", "kp_add", "kp_enter", "kp_equal", "left_shift", "left_control", "left_alt", "left_super", "right_shift", "right_control", "right_alt", "right_super", "menu" }
        } },
    functions = { {
            args = { {
                    name = "delta_time",
                    type = "double"
                }, {
                    name = "window_width",
                    type = "int"
                }, {
                    name = "window_height",
                    type = "int"
                }, {
                    name = "window_resized",
                    type = "bool"
                }, {
                    name = "is_fullscreen",
                    type = "bool"
                } },
            doc = "Tick function. Should be created by the user. ",
            impl = "user",
            name = "tick",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Quit the application by closing the window. ",
            impl = "native",
            mapto = <8>{
                args = {},
                doc = "Quit the application by closing the window. ",
                impl = "native",
                name = "quit",
                namespace = "lyte_core",
                rets = {}
            },
            name = "quit",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Clear the screen or current canvas if one is used. ",
            impl = "native",
            mapto = <9>{
                args = { {
                        name = "r",
                        type = "double"
                    }, {
                        name = "g",
                        type = "double"
                    }, {
                        name = "b",
                        type = "double"
                    }, {
                        name = "a",
                        type = "double"
                    } },
                doc = "Clear the screen or current canvas if one is used. ",
                impl = "native",
                name = "cls",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cls",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the foreground color to be used in the drawing operations. ",
            impl = "native",
            mapto = <10>{
                args = { {
                        name = "r",
                        type = "double"
                    }, {
                        name = "g",
                        type = "double"
                    }, {
                        name = "b",
                        type = "double"
                    }, {
                        name = "a",
                        type = "double"
                    } },
                doc = "Set the foreground color to be used in the drawing operations. ",
                impl = "native",
                name = "set_color",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_color",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the foreground color to its default value. ",
            impl = "native",
            mapto = <11>{
                args = {},
                doc = "Reset the foreground color to its default value. ",
                impl = "native",
                name = "reset_color",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_color",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a point. ",
            impl = "native",
            mapto = <12>{
                args = { {
                        name = "x",
                        type = "double"
                    }, {
                        name = "y",
                        type = "double"
                    } },
                doc = "Draw a point. ",
                impl = "native",
                name = "draw_point",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_point",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a line ",
            impl = "native",
            mapto = <13>{
                args = { {
                        name = "x1",
                        type = "double"
                    }, {
                        name = "y1",
                        type = "double"
                    }, {
                        name = "x2",
                        type = "double"
                    }, {
                        name = "y2",
                        type = "double"
                    } },
                doc = "Draw a line ",
                impl = "native",
                name = "draw_line",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_line",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a filled triangle ",
            impl = "native",
            mapto = <14>{
                args = { {
                        name = "ax",
                        type = "double"
                    }, {
                        name = "ay",
                        type = "double"
                    }, {
                        name = "bx",
                        type = "double"
                    }, {
                        name = "by",
                        type = "double"
                    }, {
                        name = "cx",
                        type = "double"
                    }, {
                        name = "cy",
                        type = "double"
                    } },
                doc = "Draw a filled triangle ",
                impl = "native",
                name = "draw_triangle",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_triangle",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a triangle border ",
            impl = "native",
            mapto = <15>{
                args = { {
                        name = "ax",
                        type = "double"
                    }, {
                        name = "ay",
                        type = "double"
                    }, {
                        name = "bx",
                        type = "double"
                    }, {
                        name = "by",
                        type = "double"
                    }, {
                        name = "cx",
                        type = "double"
                    }, {
                        name = "cy",
                        type = "double"
                    } },
                doc = "Draw a triangle border ",
                impl = "native",
                name = "draw_triangle_line",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_triangle_line",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a filled rectangle. ",
            impl = "native",
            mapto = <16>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "rect_width",
                        type = "double"
                    }, {
                        name = "rect_height",
                        type = "double"
                    } },
                doc = "Draw a filled rectangle. ",
                impl = "native",
                name = "draw_rect",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_rect",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a rectangle border. ",
            impl = "native",
            mapto = <17>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "rect_width",
                        type = "double"
                    }, {
                        name = "rect_height",
                        type = "double"
                    } },
                doc = "Draw a rectangle border. ",
                impl = "native",
                name = "draw_rect_line",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_rect_line",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a filled circle. ",
            impl = "native",
            mapto = <18>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "radius",
                        type = "double"
                    } },
                doc = "Draw a filled circle. ",
                impl = "native",
                name = "draw_circle",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_circle",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a circle border. ",
            impl = "native",
            mapto = <19>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "radius",
                        type = "double"
                    } },
                doc = "Draw a circle border. ",
                impl = "native",
                name = "draw_circle_line",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_circle_line",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a filled ellipse. ",
            impl = "native",
            mapto = <20>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "radius_x",
                        type = "double"
                    }, {
                        name = "radius_y",
                        type = "double"
                    } },
                doc = "Draw a filled ellipse. ",
                impl = "native",
                name = "draw_ellipse",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_ellipse",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw an ellipse border. ",
            impl = "native",
            mapto = <21>{
                args = { {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "radius_x",
                        type = "double"
                    }, {
                        name = "radius_y",
                        type = "double"
                    } },
                doc = "Draw an ellipse border. ",
                impl = "native",
                name = "draw_ellipse_line",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_ellipse_line",
            namespace = "lyte",
            rets = {}
        }, <22>{
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                } },
            doc = "Free Image resources ",
            impl = "lua",
            mapwrapto = <23>{
                args = { {
                        name = "image",
                        type = "pointer"
                    } },
                doc = "Free Image resources ",
                impl = "lua",
                name = "image_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_image",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "image_path",
                    type = "string"
                } },
            doc = "Load the image specified in the path. ",
            impl = "lua",
            mapwrapto = <24>{
                args = { {
                        name = "image_path",
                        type = "string"
                    } },
                doc = "Load the image specified in the path. ",
                impl = "lua",
                name = "image_load",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "load_image",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Image",
                    wrapped = true
                } }
        }, {
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                }, {
                    name = "dest_x",
                    type = "double"
                }, {
                    name = "dest_y",
                    type = "double"
                } },
            doc = "Draw an image. ",
            impl = "lua",
            mapwrapto = <25>{
                args = { {
                        name = "image",
                        type = "pointer"
                    }, {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    } },
                doc = "Draw an image. ",
                impl = "lua",
                name = "image_draw",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_image",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                }, {
                    name = "dest_x",
                    type = "double"
                }, {
                    name = "dest_y",
                    type = "double"
                }, {
                    name = "src_x",
                    type = "double"
                }, {
                    name = "src_y",
                    type = "double"
                }, {
                    name = "rect_width",
                    type = "double"
                }, {
                    name = "rect_height",
                    type = "double"
                } },
            doc = "Draw a rectangular area from the image. ",
            impl = "lua",
            mapwrapto = <26>{
                args = { {
                        name = "image",
                        type = "pointer"
                    }, {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "src_x",
                        type = "double"
                    }, {
                        name = "src_y",
                        type = "double"
                    }, {
                        name = "rect_width",
                        type = "double"
                    }, {
                        name = "rect_height",
                        type = "double"
                    } },
                doc = "Draw a rectangular area from the image. ",
                impl = "lua",
                name = "image_draw_rect",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_image_rect",
            namespace = "lyte",
            rets = {}
        }, <27>{
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                } },
            doc = "Get the width of the image. ",
            impl = "lua",
            mapwrapto = <28>{
                args = { {
                        name = "image",
                        type = "pointer"
                    } },
                doc = "Get the width of the image. ",
                impl = "lua",
                name = "image_get_width",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_image_width",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "int"
                } }
        }, <29>{
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                } },
            doc = "Get the height of the image. ",
            impl = "lua",
            mapwrapto = <30>{
                args = { {
                        name = "image",
                        type = "pointer"
                    } },
                doc = "Get the height of the image. ",
                impl = "lua",
                name = "image_get_height",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_image_height",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "int"
                } }
        }, {
            args = { {
                    name = "width",
                    type = "int"
                }, {
                    name = "height",
                    type = "int"
                } },
            doc = "Create a canvas image with given width and height. ",
            impl = "lua",
            mapwrapto = <31>{
                args = { {
                        name = "width",
                        type = "int"
                    }, {
                        name = "height",
                        type = "int"
                    } },
                doc = "Create a canvas image with given width and height. ",
                impl = "lua",
                name = "image_new_canvas",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "new_canvas",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Image",
                    wrapped = true
                } }
        }, {
            args = { {
                    name = "canvas_image",
                    type = "Image",
                    wrapped = true
                } },
            code = "function(canvas_image_wrapped)\n    local canvas_image = canvas_image_wrapped.id\n    lyte_core.image_set_canvas(canvas_image)\n    lyte._current_canvas_save = canvas_image_wrapped\nend\n",
            doc = "Set the effective canvas image. All draw operations will go to this canvas until it's reset. ",
            impl = "lua",
            name = "set_canvas",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the drawing target, back to screen. ",
            impl = "native",
            mapto = <32>{
                args = {},
                doc = "Reset the drawing target, back to screen. ",
                impl = "native",
                name = "reset_canvas",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_canvas",
            namespace = "lyte",
            rets = {}
        }, <33>{
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                } },
            doc = "Check if the image was created as a canvas. ",
            impl = "lua",
            mapwrapto = <34>{
                args = { {
                        name = "image",
                        type = "pointer"
                    } },
                doc = "Check if the image was created as a canvas. ",
                impl = "lua",
                name = "image_is_canvas",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_image_canvas",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "bool"
                } }
        }, <35>{
            args = { {
                    name = "imagebatch",
                    type = "ImageBatch",
                    wrapped = true
                } },
            doc = "Free ImageBatch resources ",
            impl = "lua",
            mapwrapto = <36>{
                args = { {
                        name = "imagebatch",
                        type = "pointer"
                    } },
                doc = "Free ImageBatch resources ",
                impl = "lua",
                name = "imagebatch_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_imagebatch",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "image",
                    type = "Image",
                    wrapped = true
                } },
            doc = "Create an image batch ",
            impl = "lua",
            mapwrapto = <37>{
                args = { {
                        name = "image",
                        type = "pointer"
                    } },
                doc = "Create an image batch ",
                impl = "lua",
                name = "imagebatch_new",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "new_imagebatch",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "ImageBatch",
                    wrapped = true
                } }
        }, <38>{
            args = { {
                    name = "imagebatch",
                    type = "ImageBatch",
                    wrapped = true
                } },
            doc = "Reset the image batch, remove all added rects. ",
            impl = "lua",
            mapwrapto = <39>{
                args = { {
                        name = "imagebatch",
                        type = "pointer"
                    } },
                doc = "Reset the image batch, remove all added rects. ",
                impl = "lua",
                name = "imagebatch_reset",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_imagebatch",
            namespace = "lyte",
            rets = {}
        }, <40>{
            args = { {
                    name = "imagebatch",
                    type = "ImageBatch",
                    wrapped = true
                }, {
                    name = "dest_x",
                    type = "double"
                }, {
                    name = "dest_y",
                    type = "double"
                }, {
                    name = "dest_width",
                    type = "double"
                }, {
                    name = "dest_height",
                    type = "double"
                }, {
                    name = "src_x",
                    type = "double"
                }, {
                    name = "src_y",
                    type = "double"
                }, {
                    name = "src_width",
                    type = "double"
                }, {
                    name = "src_height",
                    type = "double"
                } },
            doc = "Add a recta to the image batch (from it's initial image). ",
            impl = "lua",
            mapwrapto = <41>{
                args = { {
                        name = "imagebatch",
                        type = "pointer"
                    }, {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    }, {
                        name = "dest_width",
                        type = "double"
                    }, {
                        name = "dest_height",
                        type = "double"
                    }, {
                        name = "src_x",
                        type = "double"
                    }, {
                        name = "src_y",
                        type = "double"
                    }, {
                        name = "src_width",
                        type = "double"
                    }, {
                        name = "src_height",
                        type = "double"
                    } },
                doc = "Add a recta to the image batch (from it's initial image). ",
                impl = "lua",
                name = "imagebatch_add_rect",
                namespace = "lyte_core",
                rets = {}
            },
            name = "add_imagebatch_rect",
            namespace = "lyte",
            rets = {}
        }, <42>{
            args = { {
                    name = "imagebatch",
                    type = "ImageBatch",
                    wrapped = true
                } },
            doc = "Get the number of rects in the image batch. ",
            impl = "lua",
            mapwrapto = <43>{
                args = { {
                        name = "imagebatch",
                        type = "pointer"
                    } },
                doc = "Get the number of rects in the image batch. ",
                impl = "lua",
                name = "imagebatch_get_rect_count",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_imagebatch_rect_count",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "int"
                } }
        }, <44>{
            args = { {
                    name = "imagebatch",
                    type = "ImageBatch",
                    wrapped = true
                } },
            doc = "Draw the image batch. ",
            impl = "lua",
            mapwrapto = <45>{
                args = { {
                        name = "imagebatch",
                        type = "pointer"
                    } },
                doc = "Draw the image batch. ",
                impl = "lua",
                name = "imagebatch_draw",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_imagebatch",
            namespace = "lyte",
            rets = {}
        }, <46>{
            args = { {
                    name = "font",
                    type = "Font",
                    wrapped = true
                } },
            doc = "Free Font resources ",
            impl = "lua",
            mapwrapto = <47>{
                args = { {
                        name = "font",
                        type = "pointer"
                    } },
                doc = "Free Font resources ",
                impl = "lua",
                name = "font_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_font",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "font_path",
                    type = "string"
                }, {
                    name = "size",
                    type = "double"
                } },
            doc = "Load the font specified in the path, and set the initial size. ",
            impl = "lua",
            mapwrapto = <48>{
                args = { {
                        name = "font_path",
                        type = "string"
                    }, {
                        name = "size",
                        type = "double"
                    } },
                doc = "Load the font specified in the path, and set the initial size. ",
                impl = "lua",
                name = "font_load",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "load_font",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Font",
                    wrapped = true
                } }
        }, {
            args = { {
                    name = "font",
                    type = "Font",
                    wrapped = true
                } },
            code = "function(font_wrapped)\n    local font = font_wrapped.id\n    lyte_core.font_set(font)\n    lyte._current_font_save = font_wrapped\nend\n",
            doc = "Set the effective font to be used in the drawing operations. ",
            impl = "lua",
            name = "set_font",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            code = "function()\n    lyte.set_font(lyte._default_font) -- lyte._default_font set in lyte_boot\nend\n",
            doc = "Reset the font to its default value. ",
            impl = "lua",
            name = "reset_font",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Draw a text line. ",
            impl = "native",
            mapto = <49>{
                args = { {
                        name = "text",
                        type = "string"
                    }, {
                        name = "dest_x",
                        type = "double"
                    }, {
                        name = "dest_y",
                        type = "double"
                    } },
                doc = "Draw a text line. ",
                impl = "native",
                name = "draw_text",
                namespace = "lyte_core",
                rets = {}
            },
            name = "draw_text",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the width of the given text line. ",
            impl = "native",
            mapto = <50>{
                args = { {
                        name = "text",
                        type = "string"
                    } },
                doc = "Get the width of the given text line. ",
                impl = "native",
                name = "get_text_width",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_text_width",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the height of the given text line. ",
            impl = "native",
            mapto = <51>{
                args = { {
                        name = "text",
                        type = "string"
                    } },
                doc = "Get the height of the given text line. ",
                impl = "native",
                name = "get_text_height",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_text_height",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the number of currently connected monitors. ",
            impl = "native",
            mapto = <52>{
                args = {},
                doc = "Get the number of currently connected monitors. ",
                impl = "native",
                name = "get_monitor_count",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_monitor_count",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the name of the monitor at the index ",
            impl = "native",
            mapto = <53>{
                args = { {
                        name = "index",
                        type = "int"
                    } },
                doc = "Get the name of the monitor at the index ",
                impl = "native",
                name = "get_monitor_name",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "string"
                    } }
            },
            name = "get_monitor_name",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the width of the monitor at the index ",
            impl = "native",
            mapto = <54>{
                args = { {
                        name = "index",
                        type = "int"
                    } },
                doc = "Get the width of the monitor at the index ",
                impl = "native",
                name = "get_monitor_width",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_monitor_width",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the height of the monitor at the index ",
            impl = "native",
            mapto = <55>{
                args = { {
                        name = "index",
                        type = "int"
                    } },
                doc = "Get the height of the monitor at the index ",
                impl = "native",
                name = "get_monitor_height",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_monitor_height",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = " Set the window's initial monitor to the indexed value. Must be set before the window is opened. ",
            impl = "native",
            mapto = <56>{
                args = { {
                        name = "index",
                        type = "int"
                    } },
                doc = " Set the window's initial monitor to the indexed value. Must be set before the window is opened. ",
                impl = "native",
                name = "set_window_monitor",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_monitor",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = " Set the window resizable flag to the given value. Must be set before the window is opened. ",
            impl = "native",
            mapto = <57>{
                args = { {
                        name = "resizable",
                        type = "bool"
                    } },
                doc = " Set the window resizable flag to the given value. Must be set before the window is opened. ",
                impl = "native",
                name = "set_window_resizable",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_resizable",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window's minimum possible size. ",
            impl = "native",
            mapto = <58>{
                args = { {
                        name = "width",
                        type = "int"
                    }, {
                        name = "height",
                        type = "int"
                    } },
                doc = "Set the window's minimum possible size. ",
                impl = "native",
                name = "set_window_minsize",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_minsize",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window's size. ",
            impl = "native",
            mapto = <59>{
                args = { {
                        name = "width",
                        type = "int"
                    }, {
                        name = "height",
                        type = "int"
                    } },
                doc = "Set the window's size. ",
                impl = "native",
                name = "set_window_size",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_size",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the width of the window. ",
            impl = "native",
            mapto = <60>{
                args = {},
                doc = "Get the width of the window. ",
                impl = "native",
                name = "get_window_width",
                namespace = "lyte_core",
                rets = { {
                        doc = "Width of the window in pixels",
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_window_width",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the height of the window. ",
            impl = "native",
            mapto = <61>{
                args = {},
                doc = "Get the height of the window. ",
                impl = "native",
                name = "get_window_height",
                namespace = "lyte_core",
                rets = { {
                        doc = "Height of the window in pixels",
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_window_height",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window's position. ",
            impl = "native",
            mapto = <62>{
                args = { {
                        name = "x",
                        type = "int"
                    }, {
                        name = "y",
                        type = "int"
                    } },
                doc = "Set the window's position. ",
                impl = "native",
                name = "set_window_position",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_position",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window to fullscreen, or windowed mode. ",
            impl = "native",
            mapto = <63>{
                args = { {
                        name = "fullscreen",
                        type = "bool"
                    } },
                doc = "Set the window to fullscreen, or windowed mode. ",
                impl = "native",
                name = "set_fullscreen",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_fullscreen",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the window is set to fullscreen. ",
            impl = "native",
            mapto = <64>{
                args = {},
                doc = "Check if the window is set to fullscreen. ",
                impl = "native",
                name = "is_fullscreen",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_fullscreen",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window's title. ",
            impl = "native",
            mapto = <65>{
                args = { {
                        name = "title",
                        type = "string"
                    } },
                doc = "Set the window's title. ",
                impl = "native",
                name = "set_window_title",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_title",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window vsync flag to the given value. ",
            impl = "native",
            mapto = <66>{
                args = { {
                        name = "vsync",
                        type = "bool"
                    } },
                doc = "Set the window vsync flag to the given value. ",
                impl = "native",
                name = "set_window_vsync",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_vsync",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the window vsync flag is set. ",
            impl = "native",
            mapto = <67>{
                args = {},
                doc = "Check if the window vsync flag is set. ",
                impl = "native",
                name = "is_window_vsync",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_window_vsync",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window icon. ",
            impl = "native",
            mapto = <68>{
                args = { {
                        name = "icon_path",
                        type = "string"
                    } },
                doc = "Set the window icon. ",
                impl = "native",
                name = "set_window_icon_file",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_icon_file",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window margins. Margins are ignored and no drawing can be made there.. ",
            impl = "native",
            mapto = <69>{
                args = { {
                        name = "left",
                        type = "int"
                    }, {
                        name = "right",
                        type = "int"
                    }, {
                        name = "top",
                        type = "int"
                    }, {
                        name = "bottom",
                        type = "int"
                    } },
                doc = "Set the window margins. Margins are ignored and no drawing can be made there.. ",
                impl = "native",
                name = "set_window_margins",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_margins",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the window paddings. Paddings are can be drawn on. ",
            impl = "native",
            mapto = <70>{
                args = { {
                        name = "left",
                        type = "int"
                    }, {
                        name = "right",
                        type = "int"
                    }, {
                        name = "top",
                        type = "int"
                    }, {
                        name = "bottom",
                        type = "int"
                    } },
                doc = "Set the window paddings. Paddings are can be drawn on. ",
                impl = "native",
                name = "set_window_paddings",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_window_paddings",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given key is down. ",
            impl = "native",
            mapto = <71>{
                args = { {
                        name = "key",
                        type = "KeyboardKey"
                    } },
                doc = "Check if the given key is down. ",
                impl = "native",
                name = "is_key_down",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_key_down",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given key is pressed. ",
            impl = "native",
            mapto = <72>{
                args = { {
                        name = "key",
                        type = "KeyboardKey"
                    } },
                doc = "Check if the given key is pressed. ",
                impl = "native",
                name = "is_key_pressed",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_key_pressed",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given key is released. ",
            impl = "native",
            mapto = <73>{
                args = { {
                        name = "key",
                        type = "KeyboardKey"
                    } },
                doc = "Check if the given key is released. ",
                impl = "native",
                name = "is_key_released",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_key_released",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given key is repeated. ",
            impl = "native",
            mapto = <74>{
                args = { {
                        name = "key",
                        type = "KeyboardKey"
                    } },
                doc = "Check if the given key is repeated. ",
                impl = "native",
                name = "is_key_repeat",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_key_repeat",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given mouse button is down. ",
            impl = "native",
            mapto = <75>{
                args = { {
                        name = "mouse_button",
                        type = "MouseButton"
                    } },
                doc = "Check if the given mouse button is down. ",
                impl = "native",
                name = "is_mouse_down",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_mouse_down",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given mouse button is pressed. ",
            impl = "native",
            mapto = <76>{
                args = { {
                        name = "mouse_button",
                        type = "MouseButton"
                    } },
                doc = "Check if the given mouse button is pressed. ",
                impl = "native",
                name = "is_mouse_pressed",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_mouse_pressed",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given mouse button is released. ",
            impl = "native",
            mapto = <77>{
                args = { {
                        name = "mouse_button",
                        type = "MouseButton"
                    } },
                doc = "Check if the given mouse button is released. ",
                impl = "native",
                name = "is_mouse_released",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_mouse_released",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the mouse x position. ",
            impl = "native",
            mapto = <78>{
                args = {},
                doc = "Get the mouse x position. ",
                impl = "native",
                name = "get_mouse_x",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_mouse_x",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the mouse y position. ",
            impl = "native",
            mapto = <79>{
                args = {},
                doc = "Get the mouse y position. ",
                impl = "native",
                name = "get_mouse_y",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_mouse_y",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the number of gamepads. ",
            impl = "native",
            mapto = <80>{
                args = {},
                doc = "Get the number of gamepads. ",
                impl = "native",
                name = "get_gamepad_count",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "int"
                    } }
            },
            name = "get_gamepad_count",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the name of the gamepad at the given index. ",
            impl = "native",
            mapto = <81>{
                args = { {
                        name = "index",
                        type = "int"
                    } },
                doc = "Get the name of the gamepad at the given index. ",
                impl = "native",
                name = "get_gamepad_name",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "string"
                    } }
            },
            name = "get_gamepad_name",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given button of the gamepad at the given index is down. ",
            impl = "native",
            mapto = <82>{
                args = { {
                        name = "index",
                        type = "int"
                    }, {
                        name = "gamepad_button",
                        type = "GamepadButton"
                    } },
                doc = "Check if the given button of the gamepad at the given index is down. ",
                impl = "native",
                name = "is_gamepad_down",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_gamepad_down",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given button of the gamepad at the given index is pressed. ",
            impl = "native",
            mapto = <83>{
                args = { {
                        name = "index",
                        type = "int"
                    }, {
                        name = "gamepad_button",
                        type = "GamepadButton"
                    } },
                doc = "Check if the given button of the gamepad at the given index is pressed. ",
                impl = "native",
                name = "is_gamepad_pressed",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_gamepad_pressed",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Check if the given button of the gamepad at the given index is released. ",
            impl = "native",
            mapto = <84>{
                args = { {
                        name = "index",
                        type = "int"
                    }, {
                        name = "gamepad_button",
                        type = "GamepadButton"
                    } },
                doc = "Check if the given button of the gamepad at the given index is released. ",
                impl = "native",
                name = "is_gamepad_released",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_gamepad_released",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the given axis of the gamepad at the given index. ",
            impl = "native",
            mapto = <85>{
                args = { {
                        name = "index",
                        type = "int"
                    }, {
                        name = "gamepad_axis",
                        type = "GamepadAxis"
                    } },
                doc = "Get the given axis of the gamepad at the given index. ",
                impl = "native",
                name = "get_gamepad_axis",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_gamepad_axis",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the master volume. ",
            impl = "native",
            mapto = <86>{
                args = { {
                        name = "mastervolume",
                        type = "double"
                    } },
                doc = "Set the master volume. ",
                impl = "native",
                name = "set_mastervolume",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_mastervolume",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Get the master volume. ",
            impl = "native",
            mapto = <87>{
                args = {},
                doc = "Get the master volume. ",
                impl = "native",
                name = "get_mastervolume",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_mastervolume",
            namespace = "lyte",
            rets = {}
        }, <88>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Free Music resources ",
            impl = "lua",
            mapwrapto = <89>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Free Music resources ",
                impl = "lua",
                name = "music_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_music",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "music_path",
                    type = "string"
                } },
            doc = "Load the music specified in the path. ",
            impl = "lua",
            mapwrapto = <90>{
                args = { {
                        name = "music_path",
                        type = "string"
                    } },
                doc = "Load the music specified in the path. ",
                impl = "lua",
                name = "music_load",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "load_music",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Music",
                    wrapped = true
                } }
        }, <91>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            code = "function(music_wrapped)\n    local music = music_wrapped.id\n    lyte_core.music_play(music)\n    lyte._current_music_save = music_wrapped\nend\n",
            doc = "Play the music. ",
            impl = "lua",
            name = "play_music",
            namespace = "lyte",
            rets = {}
        }, <92>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Pause the music. ",
            impl = "lua",
            mapwrapto = <93>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Pause the music. ",
                impl = "lua",
                name = "music_pause",
                namespace = "lyte_core",
                rets = {}
            },
            name = "pause_music",
            namespace = "lyte",
            rets = {}
        }, <94>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Resume the music. ",
            impl = "lua",
            mapwrapto = <95>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Resume the music. ",
                impl = "lua",
                name = "music_resume",
                namespace = "lyte_core",
                rets = {}
            },
            name = "resume_music",
            namespace = "lyte",
            rets = {}
        }, <96>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Stop the music. ",
            impl = "lua",
            mapwrapto = <table 95>,
            name = "stop_music",
            namespace = "lyte",
            rets = {}
        }, <97>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Check if the given music is playing. ",
            impl = "lua",
            mapwrapto = <98>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Check if the given music is playing. ",
                impl = "lua",
                name = "music_is_playing",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_music_playing",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "bool"
                } }
        }, <99>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Get the length of the given music object in seconds. ",
            impl = "lua",
            mapwrapto = <100>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Get the length of the given music object in seconds. ",
                impl = "lua",
                name = "music_get_length",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_music_length",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <101>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Get the already played length of the given music object in seconds. ",
            impl = "lua",
            mapwrapto = <102>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Get the already played length of the given music object in seconds. ",
                impl = "lua",
                name = "music_get_length_played",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_music_length_played",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <103>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                }, {
                    name = "secs",
                    type = "double"
                } },
            doc = "Move the music time played to the given value. ",
            impl = "lua",
            mapwrapto = <104>{
                args = { {
                        name = "music",
                        type = "pointer"
                    }, {
                        name = "secs",
                        type = "double"
                    } },
                doc = "Move the music time played to the given value. ",
                impl = "lua",
                name = "music_seek",
                namespace = "lyte_core",
                rets = {}
            },
            name = "seek_music",
            namespace = "lyte",
            rets = {}
        }, <105>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                }, {
                    name = "volume",
                    type = "double"
                } },
            doc = "Set the volume of the given music object. ",
            impl = "lua",
            mapwrapto = <106>{
                args = { {
                        name = "music",
                        type = "pointer"
                    }, {
                        name = "volume",
                        type = "double"
                    } },
                doc = "Set the volume of the given music object. ",
                impl = "lua",
                name = "music_set_volume",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_music_volume",
            namespace = "lyte",
            rets = {}
        }, <107>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                }, {
                    name = "pan",
                    type = "double"
                } },
            doc = "Set the pan of the given music object. ",
            impl = "lua",
            mapwrapto = <108>{
                args = { {
                        name = "music",
                        type = "pointer"
                    }, {
                        name = "pan",
                        type = "double"
                    } },
                doc = "Set the pan of the given music object. ",
                impl = "lua",
                name = "music_set_pan",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_music_pan",
            namespace = "lyte",
            rets = {}
        }, <109>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                }, {
                    name = "pitch",
                    type = "double"
                } },
            doc = "Set the pitch of the given music object. ",
            impl = "lua",
            mapwrapto = <110>{
                args = { {
                        name = "music",
                        type = "pointer"
                    }, {
                        name = "pitch",
                        type = "double"
                    } },
                doc = "Set the pitch of the given music object. ",
                impl = "lua",
                name = "music_set_pitch",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_music_pitch",
            namespace = "lyte",
            rets = {}
        }, <111>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Get the volume of the given music object. ",
            impl = "lua",
            mapwrapto = <112>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Get the volume of the given music object. ",
                impl = "lua",
                name = "music_get_volume",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_music_volume",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <113>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Get the pan of the given music object. ",
            impl = "lua",
            mapwrapto = <114>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Get the pan of the given music object. ",
                impl = "lua",
                name = "music_get_pan",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_music_pan",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <115>{
            args = { {
                    name = "music",
                    type = "Music",
                    wrapped = true
                } },
            doc = "Get the pitch of the given music object. ",
            impl = "lua",
            mapwrapto = <116>{
                args = { {
                        name = "music",
                        type = "pointer"
                    } },
                doc = "Get the pitch of the given music object. ",
                impl = "lua",
                name = "music_get_pitch",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_music_pitch",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <117>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Free Sound resources ",
            impl = "lua",
            mapwrapto = <118>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Free Sound resources ",
                impl = "lua",
                name = "sound_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_sound",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "sound_path",
                    type = "string"
                } },
            doc = "Load the sound specified in the path. ",
            impl = "lua",
            mapwrapto = <119>{
                args = { {
                        name = "sound_path",
                        type = "string"
                    } },
                doc = "Load the sound specified in the path. ",
                impl = "lua",
                name = "sound_load",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "load_sound",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Sound",
                    wrapped = true
                } }
        }, <120>{
            args = { {
                    name = "orig",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Clone the sound specified in the path. ",
            impl = "lua",
            mapwrapto = <121>{
                args = { {
                        name = "orig",
                        type = "pointer"
                    } },
                doc = "Clone the sound specified in the path. ",
                impl = "lua",
                name = "sound_clone",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "clone_sound",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Sound",
                    wrapped = true
                } }
        }, <122>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Play the sound. ",
            impl = "lua",
            mapwrapto = <123>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Play the sound. ",
                impl = "lua",
                name = "sound_play",
                namespace = "lyte_core",
                rets = {}
            },
            name = "play_sound",
            namespace = "lyte",
            rets = {}
        }, <124>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Pause the sound. ",
            impl = "lua",
            mapwrapto = <125>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Pause the sound. ",
                impl = "lua",
                name = "sound_pause",
                namespace = "lyte_core",
                rets = {}
            },
            name = "pause_sound",
            namespace = "lyte",
            rets = {}
        }, <126>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Resume the sound. ",
            impl = "lua",
            mapwrapto = <127>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Resume the sound. ",
                impl = "lua",
                name = "sound_resume",
                namespace = "lyte_core",
                rets = {}
            },
            name = "resume_sound",
            namespace = "lyte",
            rets = {}
        }, <128>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Stop the sound. ",
            impl = "lua",
            mapwrapto = <129>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Stop the sound. ",
                impl = "lua",
                name = "sound_stop",
                namespace = "lyte_core",
                rets = {}
            },
            name = "stop_sound",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Check if the given sound is playing. ",
            impl = "lua",
            mapwrapto = <130>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Check if the given sound is playing. ",
                impl = "lua",
                name = "sound_is_playing",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "bool"
                    } }
            },
            name = "is_sound_playing",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "bool"
                } }
        }, <131>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                }, {
                    name = "volume",
                    type = "double"
                } },
            doc = "Set the volume of the given sound object. ",
            impl = "lua",
            mapwrapto = <132>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    }, {
                        name = "volume",
                        type = "double"
                    } },
                doc = "Set the volume of the given sound object. ",
                impl = "lua",
                name = "sound_set_volume",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_sound_volume",
            namespace = "lyte",
            rets = {}
        }, <133>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                }, {
                    name = "pan",
                    type = "double"
                } },
            doc = "Set the pan of the given sound object. ",
            impl = "lua",
            mapwrapto = <134>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    }, {
                        name = "pan",
                        type = "double"
                    } },
                doc = "Set the pan of the given sound object. ",
                impl = "lua",
                name = "sound_set_pan",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_sound_pan",
            namespace = "lyte",
            rets = {}
        }, <135>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                }, {
                    name = "pitch",
                    type = "double"
                } },
            doc = "Set the pitch of the given sound object. ",
            impl = "lua",
            mapwrapto = <136>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    }, {
                        name = "pitch",
                        type = "double"
                    } },
                doc = "Set the pitch of the given sound object. ",
                impl = "lua",
                name = "sound_set_pitch",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_sound_pitch",
            namespace = "lyte",
            rets = {}
        }, <137>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Get the volume of the given sound object. ",
            impl = "lua",
            mapwrapto = <138>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Get the volume of the given sound object. ",
                impl = "native",
                name = "sound_get_volume",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_sound_volume",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <139>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Get the pan of the given sound object. ",
            impl = "lua",
            mapwrapto = <140>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Get the pan of the given sound object. ",
                impl = "lua",
                name = "sound_get_pan",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_sound_pan",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, <141>{
            args = { {
                    name = "sound",
                    type = "Sound",
                    wrapped = true
                } },
            doc = "Get the pitch of the given sound object. ",
            impl = "lua",
            mapwrapto = <142>{
                args = { {
                        name = "sound",
                        type = "pointer"
                    } },
                doc = "Get the pitch of the given sound object. ",
                impl = "lua",
                name = "sound_get_pitch",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "double"
                    } }
            },
            name = "get_sound_pitch",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "double"
                } }
        }, {
            args = {},
            doc = "Load the file in the path. ",
            impl = "native",
            mapto = <143>{
                args = { {
                        name = "file_path",
                        type = "string"
                    } },
                doc = "Load the file in the path. ",
                impl = "native",
                name = "load_textfile",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "string"
                    } }
            },
            name = "load_textfile",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. ",
            impl = "native",
            mapto = <144>{
                args = { {
                        name = "file_path",
                        type = "string"
                    }, {
                        name = "data",
                        type = "string"
                    } },
                doc = "Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. ",
                impl = "native",
                name = "save_textfile",
                namespace = "lyte_core",
                rets = {}
            },
            name = "save_textfile",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. ",
            impl = "native",
            mapto = <145>{
                args = { {
                        name = "file_path",
                        type = "string"
                    }, {
                        name = "data",
                        type = "string"
                    } },
                doc = "Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. ",
                impl = "native",
                name = "save_textfile_append",
                namespace = "lyte_core",
                rets = {}
            },
            name = "save_textfile_append",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Push the transform matrix. ",
            impl = "native",
            mapto = <146>{
                args = {},
                doc = "Push the transform matrix. ",
                impl = "native",
                name = "push_matrix",
                namespace = "lyte_core",
                rets = {}
            },
            name = "push_matrix",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Pop the transform matrix. ",
            impl = "native",
            mapto = <147>{
                args = {},
                doc = "Pop the transform matrix. ",
                impl = "native",
                name = "pop_matrix",
                namespace = "lyte_core",
                rets = {}
            },
            name = "pop_matrix",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the transformation matrix (load identity matrix.) ",
            impl = "native",
            mapto = <148>{
                args = {},
                doc = "Reset the transformation matrix (load identity matrix.) ",
                impl = "native",
                name = "reset_matrix",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_matrix",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Apply translation (changes transform matrix.) ",
            impl = "native",
            mapto = <149>{
                args = { {
                        name = "delta_x",
                        type = "double"
                    }, {
                        name = "delta_y",
                        type = "double"
                    } },
                doc = "Apply translation (changes transform matrix.) ",
                impl = "native",
                name = "translate",
                namespace = "lyte_core",
                rets = {}
            },
            name = "translate",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Apply rotation (changes transform matrix.) ",
            impl = "native",
            mapto = <150>{
                args = { {
                        name = "angle",
                        type = "double"
                    } },
                doc = "Apply rotation (changes transform matrix.) ",
                impl = "native",
                name = "rotate",
                namespace = "lyte_core",
                rets = {}
            },
            name = "rotate",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Apply rotation at the given location (changes transform matrix.) ",
            impl = "native",
            mapto = <151>{
                args = { {
                        name = "angle",
                        type = "double"
                    }, {
                        name = "x",
                        type = "double"
                    }, {
                        name = "y",
                        type = "double"
                    } },
                doc = "Apply rotation at the given location (changes transform matrix.) ",
                impl = "native",
                name = "rotate_at",
                namespace = "lyte_core",
                rets = {}
            },
            name = "rotate_at",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Apply scaling (changes transform matrix.) ",
            impl = "native",
            mapto = <152>{
                args = { {
                        name = "scale_x",
                        type = "double"
                    }, {
                        name = "scale_y",
                        type = "double"
                    } },
                doc = "Apply scaling (changes transform matrix.) ",
                impl = "native",
                name = "scale",
                namespace = "lyte_core",
                rets = {}
            },
            name = "scale",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Apply scaling at the given location (changes transform matrix.) ",
            impl = "native",
            mapto = <153>{
                args = { {
                        name = "scale_x",
                        type = "double"
                    }, {
                        name = "scale_y",
                        type = "double"
                    }, {
                        name = "x",
                        type = "double"
                    }, {
                        name = "y",
                        type = "double"
                    } },
                doc = "Apply scaling at the given location (changes transform matrix.) ",
                impl = "native",
                name = "scale_at",
                namespace = "lyte_core",
                rets = {}
            },
            name = "scale_at",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the default blendmode. ",
            impl = "native",
            mapto = <154>{
                args = { {
                        name = "blendmode",
                        type = "BlendMode"
                    } },
                doc = "Set the default blendmode. ",
                impl = "native",
                name = "set_default_blendmode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_default_blendmode",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the effective blendmode. ",
            impl = "native",
            mapto = <155>{
                args = { {
                        name = "blendmode",
                        type = "BlendMode"
                    } },
                doc = "Set the effective blendmode. ",
                impl = "native",
                name = "set_blendmode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_blendmode",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the blendmode value to its default value. ",
            impl = "native",
            mapto = <156>{
                args = {},
                doc = "Reset the blendmode value to its default value. ",
                impl = "native",
                name = "reset_blendmode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_blendmode",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the default filtermode. ",
            impl = "native",
            mapto = <157>{
                args = { {
                        name = "filtermode",
                        type = "FilterMode"
                    } },
                doc = "Set the default filtermode. ",
                impl = "native",
                name = "set_default_filtermode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_default_filtermode",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Set the effective filtermode. ",
            impl = "native",
            mapto = <158>{
                args = { {
                        name = "filtermode",
                        type = "FilterMode"
                    } },
                doc = "Set the effective filtermode. ",
                impl = "native",
                name = "set_filtermode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "set_filtermode",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the filtermode value to its default value. ",
            impl = "native",
            mapto = <159>{
                args = {},
                doc = "Reset the filtermode value to its default value. ",
                impl = "native",
                name = "reset_filtermode",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_filtermode",
            namespace = "lyte",
            rets = {}
        }, <160>{
            args = { {
                    name = "shaderbuilder",
                    type = "ShaderBuilder",
                    wrapped = true
                } },
            doc = "Free ShaderBuilder resources ",
            impl = "lua",
            mapwrapto = <161>{
                args = { {
                        name = "shaderbuilder",
                        type = "pointer"
                    } },
                doc = "Free ShaderBuilder resources ",
                impl = "lua",
                name = "shaderbuilder_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_shaderbuilder",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Create a ShaderBuilder object. ",
            impl = "lua",
            mapwrapto = <162>{
                args = {},
                doc = "Create a ShaderBuilder object. ",
                impl = "lua",
                name = "shaderbuilder_new",
                namespace = "lyte_core",
                rets = { {
                        name = "val",
                        type = "pointer"
                    } }
            },
            name = "new_shaderbuilder",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "ShaderBuilder",
                    wrapped = true
                } }
        }, <163>{
            args = { {
                    name = "shaderbuilder",
                    type = "ShaderBuilder",
                    wrapped = true
                }, {
                    name = "uniform_name",
                    type = "string"
                }, {
                    name = "uniform_type",
                    type = "UniformType"
                } },
            doc = "Add uniform definition to the shaderbuilder ",
            impl = "lua",
            mapwrapto = <164>{
                args = { {
                        name = "shaderbuilder",
                        type = "pointer"
                    }, {
                        name = "uniform_name",
                        type = "string"
                    }, {
                        name = "uniform_type",
                        type = "UniformType"
                    } },
                doc = "Add uniform definition to the shaderbuilder ",
                impl = "lua",
                name = "shaderbuilder_uniform",
                namespace = "lyte_core",
                rets = {}
            },
            name = "shaderbuilder_uniform",
            namespace = "lyte",
            rets = {}
        }, <165>{
            args = { {
                    name = "shaderbuilder",
                    type = "ShaderBuilder",
                    wrapped = true
                }, {
                    name = "vertex_code",
                    type = "string"
                } },
            doc = "Add vertex code to the shaderbuilder ",
            impl = "lua",
            mapwrapto = <166>{
                args = { {
                        name = "shaderbuilder",
                        type = "pointer"
                    }, {
                        name = "vertex_code",
                        type = "string"
                    } },
                doc = "Add vertex code to the shaderbuilder ",
                impl = "lua",
                name = "shaderbuilder_vertex",
                namespace = "lyte_core",
                rets = {}
            },
            name = "shaderbuilder_vertex",
            namespace = "lyte",
            rets = {}
        }, <167>{
            args = { {
                    name = "shaderbuilder",
                    type = "ShaderBuilder",
                    wrapped = true
                }, {
                    name = "fragment_code",
                    type = "string"
                } },
            doc = "Add fragment to the shaderbuilder ",
            impl = "lua",
            mapwrapto = <168>{
                args = { {
                        name = "shaderbuilder",
                        type = "pointer"
                    }, {
                        name = "fragment_code",
                        type = "string"
                    } },
                doc = "Add fragment to the shaderbuilder ",
                impl = "lua",
                name = "shaderbuilder_fragment",
                namespace = "lyte_core",
                rets = {}
            },
            name = "shaderbuilder_fragment",
            namespace = "lyte",
            rets = {}
        }, <169>{
            args = { {
                    name = "shaderbuilder",
                    type = "ShaderBuilder",
                    wrapped = true
                } },
            doc = "Add fragment to the shaderbuilder ",
            impl = "lua",
            mapwrapto = <170>{
                args = { {
                        name = "shaderbuilder",
                        type = "pointer"
                    } },
                doc = "Add fragment to the shaderbuilder ",
                impl = "lua",
                name = "shaderbuilder_build",
                namespace = "lyte_core",
                rets = { {
                        name = "shader",
                        type = "pointer"
                    } }
            },
            name = "shaderbuilder_build",
            namespace = "lyte",
            rets = { {
                    name = "shader",
                    type = "Shader",
                    wrapped = true
                } }
        }, <171>{
            args = { {
                    name = "shader",
                    type = "Shader",
                    wrapped = true
                } },
            doc = "Free Shader resources ",
            impl = "lua",
            mapwrapto = <172>{
                args = { {
                        name = "shader",
                        type = "pointer"
                    } },
                doc = "Free Shader resources ",
                impl = "lua",
                name = "shader_cleanup",
                namespace = "lyte_core",
                rets = {}
            },
            name = "cleanup_shader",
            namespace = "lyte",
            rets = {}
        }, {
            args = { {
                    name = "shaderdef",
                    type = "ShaderDef",
                    wrapped = true
                } },
            code = "function(def)\n    assert(def.uniforms)\n    assert(def.vert)\n    assert(def.frag)\n    local sb = lyte.new_shaderbuilder()\n    for k,v in pairs(def.uniforms) do\n        sb:uniform(k, v)\n    end\n    sb:vertex(def.vert)\n    sb:fragment(def.frag)\n    local shader = sb:build()\n    return shader;\nend\n",
            doc = "Create a shader with given specification. ",
            impl = "lua",
            name = "new_shader",
            namespace = "lyte",
            rets = { {
                    name = "val",
                    type = "Shader",
                    wrapped = true
                } }
        }, {
            args = { {
                    name = "shader",
                    type = "Shader",
                    wrapped = true
                } },
            code = "function(shader_wrapped)\n    local shader = shader_wrapped.id\n    lyte_core.shader_set(shader)\n    lyte._current_shader_save = shader_wrapped\nend\n",
            doc = "Set the custom shader and use it for consequent calls. ",
            impl = "lua",
            name = "set_shader",
            namespace = "lyte",
            rets = {}
        }, {
            args = {},
            doc = "Reset the shader, back to framework defaults. ",
            impl = "native",
            mapto = <173>{
                args = {},
                doc = "Reset the shader, back to framework defaults. ",
                impl = "native",
                name = "reset_shader",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_shader",
            namespace = "lyte",
            rets = {}
        }, <174>{
            args = { {
                    name = "shader",
                    type = "Shader",
                    wrapped = true
                }, {
                    name = "uniform_name",
                    type = "string"
                }, {
                    name = "uniform_value",
                    type = "ShaderUniformValue"
                } },
            code = 'function (shader, uniform_name, uniform_value)\n    -- check the value type for one of the following, and call the "right" func\n      -- shader_set_uniform_float\n      -- shader_set_uniform_floatvec4\n      -- shader_set_uniform_image\n    local vt = type(uniform_value)\n    if vt == "number" then\n        -- send float\n        lyte_core.shader_set_uniform_float(shader.id, uniform_name, uniform_value)\n    elseif vt == "table" then\n        -- number table? or "data" table? check metatable for "Image" and also check count "#"\n        if #uniform_value > 0 then\n            lyte_core.shader_set_uniform_floatvec4(shader.id, uniform_name, uniform_value)\n        elseif getmetatable(uniform_value) == lyte.Image then\n            local img_id = uniform_value.id\n            lyte_core.shader_set_uniform_image(shader.id, uniform_name, img_id)\n        else\n            error("Unknown type for uniform_value in set_shader_uniform. Expected: float, float list or lyte.Image")\n        end\n    else\n        error("Unknown value type for uniform_value in set_shader_uniform")\n    end\nend\n',
            doc = "Set the specified uniform. ",
            impl = "lua",
            name = "set_shader_uniform",
            namespace = "lyte",
            rets = {}
        }, <175>{
            args = { {
                    name = "shader",
                    type = "Shader",
                    wrapped = true
                }, {
                    name = "uniform_name",
                    type = "string"
                } },
            doc = "Reset the specified uniform. ",
            impl = "lua",
            mapwrapto = <176>{
                args = { {
                        name = "shader",
                        type = "pointer"
                    }, {
                        name = "uniform_name",
                        type = "string"
                    } },
                doc = "Reset the specified uniform. ",
                impl = "lua",
                name = "shader_reset_uniform",
                namespace = "lyte_core",
                rets = {}
            },
            name = "reset_shader_uniform",
            namespace = "lyte",
            rets = {}
        } },
    lists = { {
            doc = "Float values",
            item_type = "float",
            max_count = 4,
            name = "FloatVec4",
            namespace = "lyte"
        } },
    name = "lyte",
    namespaces = {},
    records = { {
            doc = "Shader definition: uniforms declaration, vertex and fragment shader code. ",
            fields = { {
                    name = "frag",
                    type = "string"
                }, {
                    name = "vert",
                    type = "string"
                }, {
                    name = "uniforms",
                    type = "UniformNamesToTypes"
                } },
            methods = {},
            name = "ShaderDef",
            namespace = "lyte"
        }, {
            doc = "Image type ",
            fields = { {
                    mapread = <table 27>,
                    name = "width",
                    type = "int"
                }, {
                    mapread = <table 29>,
                    name = "height",
                    type = "int"
                }, {
                    mapread = <table 33>,
                    name = "is_canvas",
                    type = "bool"
                } },
            methods = { {
                    mapto = <table 22>,
                    name = "__gc"
                } },
            name = "Image",
            namespace = "lyte"
        }, {
            doc = "ImageBatch type. ",
            fields = { {
                    mapread = <table 42>,
                    name = "rect_count",
                    type = "int"
                } },
            methods = { {
                    mapto = <table 40>,
                    name = "add_rect"
                }, {
                    mapto = <table 44>,
                    name = "draw"
                }, {
                    mapto = <table 38>,
                    name = "reset"
                }, {
                    mapto = <table 35>,
                    name = "__gc"
                } },
            name = "ImageBatch",
            namespace = "lyte"
        }, {
            doc = "Font type. ",
            fields = {},
            methods = { {
                    mapto = <table 46>,
                    name = "__gc"
                } },
            name = "Font",
            namespace = "lyte"
        }, {
            doc = "Music type. ",
            fields = { {
                    mapread = <table 97>,
                    name = "playing",
                    type = "bool"
                }, {
                    mapread = <table 99>,
                    name = "length",
                    type = "double"
                }, {
                    mapread = <table 101>,
                    name = "length_played",
                    type = "double"
                }, {
                    mapread = <table 113>,
                    mapwrite = <table 107>,
                    name = "pan",
                    type = "double"
                }, {
                    mapread = <table 115>,
                    mapwrite = <table 109>,
                    name = "pitch",
                    type = "double"
                }, {
                    mapread = <table 111>,
                    mapwrite = <table 105>,
                    name = "volume",
                    type = "double"
                } },
            methods = { {
                    mapto = <table 91>,
                    name = "play"
                }, {
                    mapto = <table 92>,
                    name = "pause"
                }, {
                    mapto = <table 94>,
                    name = "resume"
                }, {
                    mapto = <table 96>,
                    name = "stop"
                }, {
                    mapto = <table 103>,
                    name = "seek"
                }, {
                    mapto = <table 88>,
                    name = "__gc"
                } },
            name = "Music",
            namespace = "lyte"
        }, {
            doc = "Sound type. ",
            fields = { {
                    mapread = <table 139>,
                    mapwrite = <table 133>,
                    name = "pan",
                    type = "double"
                }, {
                    mapread = <table 141>,
                    mapwrite = <table 135>,
                    name = "pitch",
                    type = "double"
                }, {
                    mapread = <table 137>,
                    mapwrite = <table 131>,
                    name = "volume",
                    type = "double"
                } },
            methods = { {
                    mapto = <table 120>,
                    name = "clone"
                }, {
                    mapto = <table 124>,
                    name = "pause"
                }, {
                    mapto = <table 122>,
                    name = "play"
                }, {
                    mapto = <table 126>,
                    name = "resume"
                }, {
                    mapto = <table 128>,
                    name = "stop"
                }, {
                    mapto = <table 117>,
                    name = "__gc"
                } },
            name = "Sound",
            namespace = "lyte"
        }, {
            doc = "Shader type ",
            fields = {},
            methods = { {
                    mapto = <table 174>,
                    name = "set"
                }, {
                    mapto = <table 175>,
                    name = "reset"
                }, {
                    mapto = <table 171>,
                    name = "__gc"
                } },
            name = "Shader",
            namespace = "lyte"
        }, {
            doc = "ShaderBuilder type ",
            fields = {},
            methods = { {
                    mapto = <table 163>,
                    name = "uniform"
                }, {
                    mapto = <table 165>,
                    name = "vertex"
                }, {
                    mapto = <table 167>,
                    name = "fragment"
                }, {
                    mapto = <table 169>,
                    name = "build"
                }, {
                    mapto = <table 160>,
                    name = "__gc"
                } },
            name = "ShaderBuilder",
            namespace = "lyte"
        } },
    requires = { {
            dicts = {},
            doc = "\nlyte_core namespace. Direct API mappings to C library.",
            enums = { <table 1>, <table 2>, <table 3>, <table 4>, <table 5>, <table 6>, <table 7> },
            functions = { <table 8>, <table 9>, <table 10>, <table 11>, <table 12>, <table 13>, <table 14>, <table 15>, <table 16>, <table 17>, <table 18>, <table 19>, <table 20>, <table 21>, <table 23>, <table 24>, <table 25>, <table 26>, <table 28>, <table 30>, <table 31>, {
                    args = { {
                            name = "canvas_image",
                            type = "pointer"
                        } },
                    doc = "Set the effective canvas image. All draw operations will go to this canvas until it's reset. ",
                    impl = "lua",
                    name = "image_set_canvas",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 32>, <table 34>, <table 36>, <table 37>, <table 39>, <table 41>, <table 43>, <table 45>, <table 47>, <table 48>, {
                    args = { {
                            name = "font",
                            type = "pointer"
                        } },
                    doc = "Set the effective font to be used in the drawing operations. ",
                    impl = "lua",
                    name = "font_set",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 49>, <table 50>, <table 51>, <table 52>, <table 53>, <table 54>, <table 55>, <table 56>, <table 57>, <table 58>, <table 59>, <table 60>, <table 61>, <table 62>, <table 63>, <table 64>, <table 65>, <table 66>, <table 67>, <table 68>, <table 69>, <table 70>, <table 71>, <table 72>, <table 73>, <table 74>, <table 75>, <table 76>, <table 77>, <table 78>, <table 79>, <table 80>, <table 81>, <table 82>, <table 83>, <table 84>, <table 85>, <table 86>, <table 87>, <table 89>, <table 90>, {
                    args = { {
                            name = "music",
                            type = "pointer"
                        } },
                    doc = "Play the music. ",
                    impl = "lua",
                    name = "music_play",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 93>, <table 95>, {
                    args = { {
                            name = "music",
                            type = "pointer"
                        } },
                    doc = "Stop the music. ",
                    impl = "lua",
                    name = "music_stop",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 98>, <table 100>, <table 102>, <table 104>, <table 106>, <table 108>, <table 110>, <table 112>, <table 114>, <table 116>, <table 118>, <table 119>, <table 121>, <table 123>, <table 125>, <table 127>, <table 129>, <table 130>, <table 132>, <table 134>, <table 136>, <table 138>, <table 140>, <table 142>, <table 143>, <table 144>, <table 145>, <table 146>, <table 147>, <table 148>, <table 149>, <table 150>, <table 151>, <table 152>, <table 153>, <table 154>, <table 155>, <table 156>, <table 157>, <table 158>, <table 159>, <table 161>, <table 162>, <table 164>, <table 166>, <table 168>, <table 170>, <table 172>, {
                    args = { {
                            name = "shader",
                            type = "pointer"
                        } },
                    doc = "Set the custom shader and use it for consequent calls. ",
                    impl = "lua",
                    name = "shader_set",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 173>, {
                    args = { {
                            name = "shader",
                            type = "pointer"
                        }, {
                            name = "uniform_name",
                            type = "string"
                        }, {
                            name = "uniform_value",
                            type = "float"
                        } },
                    doc = "Set the specified uniform. ",
                    impl = "lua",
                    name = "shader_set_uniform_float",
                    namespace = "lyte_core",
                    rets = {}
                }, {
                    args = { {
                            name = "shader",
                            type = "pointer"
                        }, {
                            name = "uniform_name",
                            type = "string"
                        }, {
                            name = "uniform_value",
                            type = "FloatVec4"
                        } },
                    doc = "Set the specified uniform. ",
                    impl = "lua",
                    name = "shader_set_uniform_floatvec4",
                    namespace = "lyte_core",
                    rets = {}
                }, {
                    args = { {
                            name = "shader",
                            type = "pointer"
                        }, {
                            name = "uniform_name",
                            type = "string"
                        }, {
                            name = "uniform_value",
                            type = "pointer"
                        } },
                    doc = "Set the specified uniform. ",
                    impl = "lua",
                    name = "shader_set_uniform_image",
                    namespace = "lyte_core",
                    rets = {}
                }, <table 176> },
            lists = { {
                    doc = "Float values",
                    item_type = "float",
                    max_count = 4,
                    name = "FloatVec4",
                    namespace = "lyte_core"
                } },
            name = "lyte_core",
            namespaces = {},
            records = {},
            requires = {},
            variants = {}
        } },
    variants = { {
            doc = "Shader uniform value ",
            name = "ShaderUniformValue",
            namespace = "lyte",
            options = { {
                    doc = "Note: Used for single numbers, int or float",
                    name = "float_val",
                    type = "float"
                }, {
                    name = "vec_val",
                    type = "FloatVec4"
                }, {
                    name = "sampler2D_val",
                    type = "Image"
                } }
        } }
}

