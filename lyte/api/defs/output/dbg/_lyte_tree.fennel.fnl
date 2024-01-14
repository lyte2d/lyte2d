{:dicts [{:doc ""
          :key_type "string"
          :name "UniformNamesToTypes"
          :namespace "lyte"
          :value_type "UniformType"}]
 :doc "
lyte namespace."
 :enums [{:doc "Acceptable uniformtype values."
          :name "UniformType"
          :namespace "lyte_core"
          :values ["_invalid"
                   "float"
                   "vec2"
                   "vec3"
                   "vec4"
                   "int"
                   "ivec2"
                   "ivec3"
                   "ivec4"
                   "mat4"
                   "sampler2D"]}
         {:doc "Acceptable blendmode values."
          :name "BlendMode"
          :namespace "lyte_core"
          :values ["none" "blend" "add" "mod" "mul"]}
         {:doc "Acceptable filtermode values."
          :name "FilterMode"
          :namespace "lyte_core"
          :values ["_invalid" "nearest" "linear"]}
         {:doc "Acceptable gamepadaxis values."
          :name "GamepadAxis"
          :namespace "lyte_core"
          :values ["left_x"
                   "left_y"
                   "right_x"
                   "right_y"
                   "left_trigger"
                   "right_trigger"]}
         {:doc "Acceptable gamepadbutton values."
          :name "GamepadButton"
          :namespace "lyte_core"
          :values ["pad_a"
                   "pad_b"
                   "pad_x"
                   "pad_y"
                   "left_bumper"
                   "right_bumper"
                   "back"
                   "start"
                   "guide"
                   "left_thumb"
                   "right_thumb"
                   "dpad_up"
                   "dpad_right"
                   "dpad_down"
                   "dpad_left"]}
         {:doc "Acceptable mousebutton values."
          :name "MouseButton"
          :namespace "lyte_core"
          :values ["mb1" "mb2" "mb3" "mb4" "mb5" "mb6" "mb7" "mb8"]}
         {:doc "Acceptable keyboardkey values."
          :name "KeyboardKey"
          :namespace "lyte_core"
          :values ["space"
                   "'"
                   ","
                   "-"
                   "."
                   "/"
                   "0"
                   "1"
                   "2"
                   "3"
                   "4"
                   "5"
                   "6"
                   "7"
                   "8"
                   "9"
                   ";"
                   "="
                   "a"
                   "b"
                   "c"
                   "d"
                   "e"
                   "f"
                   "g"
                   "h"
                   "i"
                   "j"
                   "k"
                   "l"
                   "m"
                   "n"
                   "o"
                   "p"
                   "q"
                   "r"
                   "s"
                   "t"
                   "u"
                   "v"
                   "w"
                   "x"
                   "y"
                   "z"
                   "["
                   "\\"
                   "]"
                   "`"
                   "world_1"
                   "world_2"
                   "escape"
                   "enter"
                   "tab"
                   "backspace"
                   "insert"
                   "delete"
                   "right"
                   "left"
                   "down"
                   "up"
                   "page_up"
                   "page_down"
                   "home"
                   "end"
                   "caps_lock"
                   "scroll_lock"
                   "num_lock"
                   "print_screen"
                   "pause"
                   "f1"
                   "f2"
                   "f3"
                   "f4"
                   "f5"
                   "f6"
                   "f7"
                   "f8"
                   "f9"
                   "f10"
                   "f11"
                   "f12"
                   "f13"
                   "f14"
                   "f15"
                   "f16"
                   "f17"
                   "f18"
                   "f19"
                   "f20"
                   "f21"
                   "f22"
                   "f23"
                   "f24"
                   "f25"
                   "kp_0"
                   "kp_1"
                   "kp_2"
                   "kp_3"
                   "kp_4"
                   "kp_5"
                   "kp_6"
                   "kp_7"
                   "kp_8"
                   "kp_9"
                   "kp_decimal"
                   "kp_divide"
                   "kp_multiply"
                   "kp_subtract"
                   "kp_add"
                   "kp_enter"
                   "kp_equal"
                   "left_shift"
                   "left_control"
                   "left_alt"
                   "left_super"
                   "right_shift"
                   "right_control"
                   "right_alt"
                   "right_super"
                   "menu"]}]
 :functions [{:args [{:name "delta_time" :type "double"}
                     {:name "window_width" :type "int"}
                     {:name "window_height" :type "int"}
                     {:name "window_resized" :type "bool"}
                     {:name "is_fullscreen" :type "bool"}]
              :doc "Tick function. Should be created by the user. "
              :impl "user"
              :name "tick"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Quit the application by closing the window. "
              :impl "native"
              :mapto {:args {}
                      :doc "Quit the application by closing the window. "
                      :impl "native"
                      :name "quit"
                      :namespace "lyte_core"
                      :rets {}}
              :name "quit"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Clear the screen or current canvas if one is used. "
              :impl "native"
              :mapto {:args [{:name "r" :type "double"}
                             {:name "g" :type "double"}
                             {:name "b" :type "double"}
                             {:name "a" :type "double"}]
                      :doc "Clear the screen or current canvas if one is used. "
                      :impl "native"
                      :name "cls"
                      :namespace "lyte_core"
                      :rets {}}
              :name "cls"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the foreground color to be used in the drawing operations. "
              :impl "native"
              :mapto {:args [{:name "r" :type "double"}
                             {:name "g" :type "double"}
                             {:name "b" :type "double"}
                             {:name "a" :type "double"}]
                      :doc "Set the foreground color to be used in the drawing operations. "
                      :impl "native"
                      :name "set_color"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_color"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the foreground color to its default value. "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the foreground color to its default value. "
                      :impl "native"
                      :name "reset_color"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_color"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a point. "
              :impl "native"
              :mapto {:args [{:name "x" :type "double"}
                             {:name "y" :type "double"}]
                      :doc "Draw a point. "
                      :impl "native"
                      :name "draw_point"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_point"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a line "
              :impl "native"
              :mapto {:args [{:name "x1" :type "double"}
                             {:name "y1" :type "double"}
                             {:name "x2" :type "double"}
                             {:name "y2" :type "double"}]
                      :doc "Draw a line "
                      :impl "native"
                      :name "draw_line"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_line"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a filled triangle "
              :impl "native"
              :mapto {:args [{:name "ax" :type "double"}
                             {:name "ay" :type "double"}
                             {:name "bx" :type "double"}
                             {:name "by" :type "double"}
                             {:name "cx" :type "double"}
                             {:name "cy" :type "double"}]
                      :doc "Draw a filled triangle "
                      :impl "native"
                      :name "draw_triangle"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_triangle"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a triangle border "
              :impl "native"
              :mapto {:args [{:name "ax" :type "double"}
                             {:name "ay" :type "double"}
                             {:name "bx" :type "double"}
                             {:name "by" :type "double"}
                             {:name "cx" :type "double"}
                             {:name "cy" :type "double"}]
                      :doc "Draw a triangle border "
                      :impl "native"
                      :name "draw_triangle_line"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_triangle_line"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a filled rectangle. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "rect_width" :type "double"}
                             {:name "rect_height" :type "double"}]
                      :doc "Draw a filled rectangle. "
                      :impl "native"
                      :name "draw_rect"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_rect"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a rectangle border. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "rect_width" :type "double"}
                             {:name "rect_height" :type "double"}]
                      :doc "Draw a rectangle border. "
                      :impl "native"
                      :name "draw_rect_line"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_rect_line"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a filled circle. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "radius" :type "double"}]
                      :doc "Draw a filled circle. "
                      :impl "native"
                      :name "draw_circle"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_circle"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a circle border. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "radius" :type "double"}]
                      :doc "Draw a circle border. "
                      :impl "native"
                      :name "draw_circle_line"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_circle_line"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a filled ellipse. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "radius_x" :type "double"}
                             {:name "radius_y" :type "double"}]
                      :doc "Draw a filled ellipse. "
                      :impl "native"
                      :name "draw_ellipse"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_ellipse"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw an ellipse border. "
              :impl "native"
              :mapto {:args [{:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}
                             {:name "radius_x" :type "double"}
                             {:name "radius_y" :type "double"}]
                      :doc "Draw an ellipse border. "
                      :impl "native"
                      :name "draw_ellipse_line"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_ellipse_line"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image" :type "Image" :wrapped true}]
              :doc "Free Image resources "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}]
                          :doc "Free Image resources "
                          :impl "lua"
                          :name "image_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_image"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image_path" :type "string"}]
              :doc "Load the image specified in the path. "
              :impl "lua"
              :mapwrapto {:args [{:name "image_path" :type "string"}]
                          :doc "Load the image specified in the path. "
                          :impl "lua"
                          :name "image_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "load_image"
              :namespace "lyte"
              :rets [{:name "val" :type "Image" :wrapped true}]}
             {:args [{:name "image" :type "Image" :wrapped true}
                     {:name "dest_x" :type "double"}
                     {:name "dest_y" :type "double"}]
              :doc "Draw an image. "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}]
                          :doc "Draw an image. "
                          :impl "lua"
                          :name "image_draw"
                          :namespace "lyte_core"
                          :rets {}}
              :name "draw_image"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image" :type "Image" :wrapped true}
                     {:name "dest_x" :type "double"}
                     {:name "dest_y" :type "double"}
                     {:name "src_x" :type "double"}
                     {:name "src_y" :type "double"}
                     {:name "rect_width" :type "double"}
                     {:name "rect_height" :type "double"}]
              :doc "Draw a rectangular area from the image. "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "src_x" :type "double"}
                                 {:name "src_y" :type "double"}
                                 {:name "rect_width" :type "double"}
                                 {:name "rect_height" :type "double"}]
                          :doc "Draw a rectangular area from the image. "
                          :impl "lua"
                          :name "image_draw_rect"
                          :namespace "lyte_core"
                          :rets {}}
              :name "draw_image_rect"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image" :type "Image" :wrapped true}]
              :doc "Get the width of the image. "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}]
                          :doc "Get the width of the image. "
                          :impl "lua"
                          :name "image_get_width"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
              :name "get_image_width"
              :namespace "lyte"
              :rets [{:name "val" :type "int"}]}
             {:args [{:name "image" :type "Image" :wrapped true}]
              :doc "Get the height of the image. "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}]
                          :doc "Get the height of the image. "
                          :impl "lua"
                          :name "image_get_height"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
              :name "get_image_height"
              :namespace "lyte"
              :rets [{:name "val" :type "int"}]}
             {:args [{:name "width" :type "int"} {:name "height" :type "int"}]
              :doc "Create a canvas image with given width and height. "
              :impl "lua"
              :mapwrapto {:args [{:name "width" :type "int"}
                                 {:name "height" :type "int"}]
                          :doc "Create a canvas image with given width and height. "
                          :impl "lua"
                          :name "image_new_canvas"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "new_canvas"
              :namespace "lyte"
              :rets [{:name "val" :type "Image" :wrapped true}]}
             {:args [{:name "canvas_image" :type "Image" :wrapped true}]
              :doc "Set the effective canvas image. All draw operations will go to this canvas until it's reset. "
              :impl "lua"
              :mapwrapto {:args [{:name "canvas_image" :type "pointer"}]
                          :doc "Set the effective canvas image. All draw operations will go to this canvas until it's reset. "
                          :impl "lua"
                          :name "image_set_canvas"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_canvas"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the drawing target, back to screen. "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the drawing target, back to screen. "
                      :impl "native"
                      :name "reset_canvas"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_canvas"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image" :type "Image" :wrapped true}]
              :doc "Check if the image was created as a canvas. "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}]
                          :doc "Check if the image was created as a canvas. "
                          :impl "lua"
                          :name "image_is_canvas"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
              :name "is_image_canvas"
              :namespace "lyte"
              :rets [{:name "val" :type "bool"}]}
             {:args [{:name "imagebatch" :type "ImageBatch" :wrapped true}]
              :doc "Free ImageBatch resources "
              :impl "lua"
              :mapwrapto {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Free ImageBatch resources "
                          :impl "lua"
                          :name "imagebatch_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_imagebatch"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "image" :type "Image" :wrapped true}]
              :doc "Create an image batch "
              :impl "lua"
              :mapwrapto {:args [{:name "image" :type "pointer"}]
                          :doc "Create an image batch "
                          :impl "lua"
                          :name "imagebatch_new"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "new_imagebatch"
              :namespace "lyte"
              :rets [{:name "val" :type "ImageBatch" :wrapped true}]}
             {:args [{:name "imagebatch" :type "ImageBatch" :wrapped true}]
              :doc "Reset the image batch, remove all added rects. "
              :impl "lua"
              :mapwrapto {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Reset the image batch, remove all added rects. "
                          :impl "lua"
                          :name "imagebatch_reset"
                          :namespace "lyte_core"
                          :rets {}}
              :name "reset_imagebatch"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "imagebatch" :type "ImageBatch" :wrapped true}
                     {:name "dest_x" :type "double"}
                     {:name "dest_y" :type "double"}
                     {:name "dest_width" :type "double"}
                     {:name "dest_height" :type "double"}
                     {:name "src_x" :type "double"}
                     {:name "src_y" :type "double"}
                     {:name "src_width" :type "double"}
                     {:name "src_height" :type "double"}]
              :doc "Add a recta to the image batch (from it's initial image). "
              :impl "lua"
              :mapwrapto {:args [{:name "imagebatch" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "dest_width" :type "double"}
                                 {:name "dest_height" :type "double"}
                                 {:name "src_x" :type "double"}
                                 {:name "src_y" :type "double"}
                                 {:name "src_width" :type "double"}
                                 {:name "src_height" :type "double"}]
                          :doc "Add a recta to the image batch (from it's initial image). "
                          :impl "lua"
                          :name "imagebatch_add_rect"
                          :namespace "lyte_core"
                          :rets {}}
              :name "add_imagebatch_rect"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "imagebatch" :type "ImageBatch" :wrapped true}]
              :doc "Get the number of rects in the image batch. "
              :impl "lua"
              :mapwrapto {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Get the number of rects in the image batch. "
                          :impl "lua"
                          :name "imagebatch_get_rect_count"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
              :name "get_imagebatch_rect_count"
              :namespace "lyte"
              :rets [{:name "val" :type "int"}]}
             {:args [{:name "imagebatch" :type "ImageBatch" :wrapped true}]
              :doc "Draw the image batch. "
              :impl "lua"
              :mapwrapto {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Draw the image batch. "
                          :impl "lua"
                          :name "imagebatch_draw"
                          :namespace "lyte_core"
                          :rets {}}
              :name "draw_imagebatch"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "font" :type "Font" :wrapped true}]
              :doc "Free Font resources "
              :impl "lua"
              :mapwrapto {:args [{:name "font" :type "pointer"}]
                          :doc "Free Font resources "
                          :impl "lua"
                          :name "font_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_font"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "font_path" :type "string"}
                     {:name "size" :type "double"}]
              :doc "Load the font specified in the path, and set the initial size. "
              :impl "lua"
              :mapwrapto {:args [{:name "font_path" :type "string"}
                                 {:name "size" :type "double"}]
                          :doc "Load the font specified in the path, and set the initial size. "
                          :impl "lua"
                          :name "font_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "load_font"
              :namespace "lyte"
              :rets [{:name "val" :type "Font" :wrapped true}]}
             {:args [{:name "font" :type "Font" :wrapped true}]
              :doc "Set the effective font to be used in the drawing operations. "
              :impl "lua"
              :mapwrapto {:args [{:name "font" :type "pointer"}]
                          :doc "Set the effective font to be used in the drawing operations. "
                          :impl "lua"
                          :name "font_set"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_font"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :code "function()
    lyte.set_font(lyte._default_font) -- lyte._default_font set in lyte_boot
end
"
              :doc "Reset the font to its default value. "
              :impl "lua"
              :name "reset_font"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Draw a text line. "
              :impl "native"
              :mapto {:args [{:name "text" :type "string"}
                             {:name "dest_x" :type "double"}
                             {:name "dest_y" :type "double"}]
                      :doc "Draw a text line. "
                      :impl "native"
                      :name "draw_text"
                      :namespace "lyte_core"
                      :rets {}}
              :name "draw_text"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the width of the given text line. "
              :impl "native"
              :mapto {:args [{:name "text" :type "string"}]
                      :doc "Get the width of the given text line. "
                      :impl "native"
                      :name "get_text_width"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_text_width"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the height of the given text line. "
              :impl "native"
              :mapto {:args [{:name "text" :type "string"}]
                      :doc "Get the height of the given text line. "
                      :impl "native"
                      :name "get_text_height"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_text_height"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the number of currently connected monitors. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the number of currently connected monitors. "
                      :impl "native"
                      :name "get_monitor_count"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_monitor_count"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the name of the monitor at the index "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}]
                      :doc "Get the name of the monitor at the index "
                      :impl "native"
                      :name "get_monitor_name"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "string"}]}
              :name "get_monitor_name"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the width of the monitor at the index "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}]
                      :doc "Get the width of the monitor at the index "
                      :impl "native"
                      :name "get_monitor_width"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_monitor_width"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the height of the monitor at the index "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}]
                      :doc "Get the height of the monitor at the index "
                      :impl "native"
                      :name "get_monitor_height"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_monitor_height"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc " Set the window's initial monitor to the indexed value. Must be set before the window is opened. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}]
                      :doc " Set the window's initial monitor to the indexed value. Must be set before the window is opened. "
                      :impl "native"
                      :name "set_window_monitor"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_monitor"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc " Set the window resizable flag to the given value. Must be set before the window is opened. "
              :impl "native"
              :mapto {:args [{:name "resizable" :type "bool"}]
                      :doc " Set the window resizable flag to the given value. Must be set before the window is opened. "
                      :impl "native"
                      :name "set_window_resizable"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_resizable"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window's minimum possible size. "
              :impl "native"
              :mapto {:args [{:name "width" :type "int"}
                             {:name "height" :type "int"}]
                      :doc "Set the window's minimum possible size. "
                      :impl "native"
                      :name "set_window_minsize"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_minsize"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window's size. "
              :impl "native"
              :mapto {:args [{:name "width" :type "int"}
                             {:name "height" :type "int"}]
                      :doc "Set the window's size. "
                      :impl "native"
                      :name "set_window_size"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_size"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the width of the window. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the width of the window. "
                      :impl "native"
                      :name "get_window_width"
                      :namespace "lyte_core"
                      :rets [{:doc "Width of the window in pixels"
                              :name "val"
                              :type "int"}]}
              :name "get_window_width"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the height of the window. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the height of the window. "
                      :impl "native"
                      :name "get_window_height"
                      :namespace "lyte_core"
                      :rets [{:doc "Height of the window in pixels"
                              :name "val"
                              :type "int"}]}
              :name "get_window_height"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window's position. "
              :impl "native"
              :mapto {:args [{:name "x" :type "int"} {:name "y" :type "int"}]
                      :doc "Set the window's position. "
                      :impl "native"
                      :name "set_window_position"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_position"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window to fullscreen, or windowed mode. "
              :impl "native"
              :mapto {:args [{:name "fullscreen" :type "bool"}]
                      :doc "Set the window to fullscreen, or windowed mode. "
                      :impl "native"
                      :name "set_fullscreen"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_fullscreen"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the window is set to fullscreen. "
              :impl "native"
              :mapto {:args {}
                      :doc "Check if the window is set to fullscreen. "
                      :impl "native"
                      :name "is_fullscreen"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_fullscreen"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window's title. "
              :impl "native"
              :mapto {:args [{:name "title" :type "string"}]
                      :doc "Set the window's title. "
                      :impl "native"
                      :name "set_window_title"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_title"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window vsync flag to the given value. "
              :impl "native"
              :mapto {:args [{:name "vsync" :type "bool"}]
                      :doc "Set the window vsync flag to the given value. "
                      :impl "native"
                      :name "set_window_vsync"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_vsync"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the window vsync flag is set. "
              :impl "native"
              :mapto {:args {}
                      :doc "Check if the window vsync flag is set. "
                      :impl "native"
                      :name "is_window_vsync"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_window_vsync"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window icon. "
              :impl "native"
              :mapto {:args [{:name "icon_path" :type "string"}]
                      :doc "Set the window icon. "
                      :impl "native"
                      :name "set_window_icon_file"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_icon_file"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window margins. Margins are ignored and no drawing can be made there.. "
              :impl "native"
              :mapto {:args [{:name "left" :type "int"}
                             {:name "right" :type "int"}
                             {:name "top" :type "int"}
                             {:name "bottom" :type "int"}]
                      :doc "Set the window margins. Margins are ignored and no drawing can be made there.. "
                      :impl "native"
                      :name "set_window_margins"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_margins"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the window paddings. Paddings are can be drawn on. "
              :impl "native"
              :mapto {:args [{:name "left" :type "int"}
                             {:name "right" :type "int"}
                             {:name "top" :type "int"}
                             {:name "bottom" :type "int"}]
                      :doc "Set the window paddings. Paddings are can be drawn on. "
                      :impl "native"
                      :name "set_window_paddings"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_window_paddings"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given key is down. "
              :impl "native"
              :mapto {:args [{:name "key" :type "KeyboardKey"}]
                      :doc "Check if the given key is down. "
                      :impl "native"
                      :name "is_key_down"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_key_down"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given key is pressed. "
              :impl "native"
              :mapto {:args [{:name "key" :type "KeyboardKey"}]
                      :doc "Check if the given key is pressed. "
                      :impl "native"
                      :name "is_key_pressed"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_key_pressed"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given key is released. "
              :impl "native"
              :mapto {:args [{:name "key" :type "KeyboardKey"}]
                      :doc "Check if the given key is released. "
                      :impl "native"
                      :name "is_key_released"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_key_released"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given key is repeated. "
              :impl "native"
              :mapto {:args [{:name "key" :type "KeyboardKey"}]
                      :doc "Check if the given key is repeated. "
                      :impl "native"
                      :name "is_key_repeat"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_key_repeat"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given mouse button is down. "
              :impl "native"
              :mapto {:args [{:name "mouse_button" :type "MouseButton"}]
                      :doc "Check if the given mouse button is down. "
                      :impl "native"
                      :name "is_mouse_down"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_mouse_down"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given mouse button is pressed. "
              :impl "native"
              :mapto {:args [{:name "mouse_button" :type "MouseButton"}]
                      :doc "Check if the given mouse button is pressed. "
                      :impl "native"
                      :name "is_mouse_pressed"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_mouse_pressed"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given mouse button is released. "
              :impl "native"
              :mapto {:args [{:name "mouse_button" :type "MouseButton"}]
                      :doc "Check if the given mouse button is released. "
                      :impl "native"
                      :name "is_mouse_released"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_mouse_released"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the mouse x position. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the mouse x position. "
                      :impl "native"
                      :name "get_mouse_x"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_mouse_x"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the mouse y position. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the mouse y position. "
                      :impl "native"
                      :name "get_mouse_y"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_mouse_y"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the number of gamepads. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the number of gamepads. "
                      :impl "native"
                      :name "get_gamepad_count"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "int"}]}
              :name "get_gamepad_count"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the name of the gamepad at the given index. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}]
                      :doc "Get the name of the gamepad at the given index. "
                      :impl "native"
                      :name "get_gamepad_name"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "string"}]}
              :name "get_gamepad_name"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given button of the gamepad at the given index is down. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}
                             {:name "gamepad_button" :type "GamepadButton"}]
                      :doc "Check if the given button of the gamepad at the given index is down. "
                      :impl "native"
                      :name "is_gamepad_down"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_gamepad_down"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given button of the gamepad at the given index is pressed. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}
                             {:name "gamepad_button" :type "GamepadButton"}]
                      :doc "Check if the given button of the gamepad at the given index is pressed. "
                      :impl "native"
                      :name "is_gamepad_pressed"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_gamepad_pressed"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Check if the given button of the gamepad at the given index is released. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}
                             {:name "gamepad_button" :type "GamepadButton"}]
                      :doc "Check if the given button of the gamepad at the given index is released. "
                      :impl "native"
                      :name "is_gamepad_released"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "bool"}]}
              :name "is_gamepad_released"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the given axis of the gamepad at the given index. "
              :impl "native"
              :mapto {:args [{:name "index" :type "int"}
                             {:name "gamepad_axis" :type "GamepadAxis"}]
                      :doc "Get the given axis of the gamepad at the given index. "
                      :impl "native"
                      :name "get_gamepad_axis"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "double"}]}
              :name "get_gamepad_axis"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the master volume. "
              :impl "native"
              :mapto {:args [{:name "mastervolume" :type "double"}]
                      :doc "Set the master volume. "
                      :impl "native"
                      :name "set_mastervolume"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_mastervolume"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Get the master volume. "
              :impl "native"
              :mapto {:args {}
                      :doc "Get the master volume. "
                      :impl "native"
                      :name "get_mastervolume"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "double"}]}
              :name "get_mastervolume"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Free Music resources "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Free Music resources "
                          :impl "lua"
                          :name "music_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music_path" :type "string"}]
              :doc "Load the music specified in the path. "
              :impl "lua"
              :mapwrapto {:args [{:name "music_path" :type "string"}]
                          :doc "Load the music specified in the path. "
                          :impl "lua"
                          :name "music_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "load_music"
              :namespace "lyte"
              :rets [{:name "val" :type "Music" :wrapped true}]}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Play the music. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Play the music. "
                          :impl "lua"
                          :name "music_play"
                          :namespace "lyte_core"
                          :rets {}}
              :name "play_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Pause the music. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Pause the music. "
                          :impl "lua"
                          :name "music_pause"
                          :namespace "lyte_core"
                          :rets {}}
              :name "pause_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Resume the music. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Resume the music. "
                          :impl "lua"
                          :name "music_resume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "resume_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Stop the music. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Resume the music. "
                          :impl "lua"
                          :name "music_resume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "stop_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Check if the given music is playing. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Check if the given music is playing. "
                          :impl "lua"
                          :name "music_is_playing"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
              :name "is_music_playing"
              :namespace "lyte"
              :rets [{:name "val" :type "bool"}]}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Get the length of the given music object in seconds. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Get the length of the given music object in seconds. "
                          :impl "lua"
                          :name "music_get_length"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_music_length"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Get the already played length of the given music object in seconds. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Get the already played length of the given music object in seconds. "
                          :impl "lua"
                          :name "music_get_length_played"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_music_length_played"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "music" :type "Music" :wrapped true}
                     {:name "secs" :type "double"}]
              :doc "Move the music time played to the given value. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}
                                 {:name "secs" :type "double"}]
                          :doc "Move the music time played to the given value. "
                          :impl "lua"
                          :name "music_seek"
                          :namespace "lyte_core"
                          :rets {}}
              :name "seek_music"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}
                     {:name "volume" :type "double"}]
              :doc "Set the volume of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}
                                 {:name "volume" :type "double"}]
                          :doc "Set the volume of the given music object. "
                          :impl "lua"
                          :name "music_set_volume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_music_volume"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}
                     {:name "pan" :type "double"}]
              :doc "Set the pan of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}
                                 {:name "volume" :type "double"}]
                          :doc "Set the volume of the given music object. "
                          :impl "lua"
                          :name "music_set_volume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_music_pan"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}
                     {:name "pitch" :type "double"}]
              :doc "Set the pitch of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}
                                 {:name "pitch" :type "double"}]
                          :doc "Set the pitch of the given music object. "
                          :impl "lua"
                          :name "music_set_pitch"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_music_pitch"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Get the volume of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Get the volume of the given music object. "
                          :impl "lua"
                          :name "music_get_volume"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_music_volume"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Get the pan of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Get the pan of the given music object. "
                          :impl "lua"
                          :name "music_get_pan"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_music_pan"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "music" :type "Music" :wrapped true}]
              :doc "Get the pitch of the given music object. "
              :impl "lua"
              :mapwrapto {:args [{:name "music" :type "pointer"}]
                          :doc "Get the pitch of the given music object. "
                          :impl "lua"
                          :name "music_get_pitch"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_music_pitch"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Free Sound resources "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Free Sound resources "
                          :impl "lua"
                          :name "sound_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_sound"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound_path" :type "string"}]
              :doc "Load the sound specified in the path. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound_path" :type "string"}]
                          :doc "Load the sound specified in the path. "
                          :impl "lua"
                          :name "sound_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "load_sound"
              :namespace "lyte"
              :rets [{:name "val" :type "Sound" :wrapped true}]}
             {:args [{:name "orig" :type "Sound" :wrapped true}]
              :doc "Clone the sound specified in the path. "
              :impl "lua"
              :mapwrapto {:args [{:name "orig" :type "pointer"}]
                          :doc "Clone the sound specified in the path. "
                          :impl "lua"
                          :name "sound_clone"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "clone_sound"
              :namespace "lyte"
              :rets [{:name "val" :type "Sound" :wrapped true}]}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Play the sound. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Play the sound. "
                          :impl "lua"
                          :name "sound_play"
                          :namespace "lyte_core"
                          :rets {}}
              :name "play_sound"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Pause the sound. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Pause the sound. "
                          :impl "lua"
                          :name "sound_pause"
                          :namespace "lyte_core"
                          :rets {}}
              :name "pause_sound"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Resume the sound. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Resume the sound. "
                          :impl "lua"
                          :name "sound_resume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "resume_sound"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Stop the sound. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Stop the sound. "
                          :impl "lua"
                          :name "sound_stop"
                          :namespace "lyte_core"
                          :rets {}}
              :name "stop_sound"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Check if the given sound is playing. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Check if the given sound is playing. "
                          :impl "lua"
                          :name "sound_is_playing"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
              :name "is_sound_playing"
              :namespace "lyte"
              :rets [{:name "val" :type "bool"}]}
             {:args [{:name "sound" :type "Sound" :wrapped true}
                     {:name "volume" :type "double"}]
              :doc "Set the volume of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}
                                 {:name "volume" :type "double"}]
                          :doc "Set the volume of the given sound object. "
                          :impl "lua"
                          :name "sound_set_volume"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_sound_volume"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}
                     {:name "pan" :type "double"}]
              :doc "Set the pan of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}
                                 {:name "pan" :type "double"}]
                          :doc "Set the pan of the given sound object. "
                          :impl "lua"
                          :name "sound_set_pan"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_sound_pan"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}
                     {:name "pitch" :type "double"}]
              :doc "Set the pitch of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}
                                 {:name "pitch" :type "double"}]
                          :doc "Set the pitch of the given sound object. "
                          :impl "lua"
                          :name "sound_set_pitch"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_sound_pitch"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Get the volume of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the volume of the given sound object. "
                          :impl "native"
                          :name "sound_get_volume"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_sound_volume"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Get the pan of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the pan of the given sound object. "
                          :impl "lua"
                          :name "sound_get_pan"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_sound_pan"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args [{:name "sound" :type "Sound" :wrapped true}]
              :doc "Get the pitch of the given sound object. "
              :impl "lua"
              :mapwrapto {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the pitch of the given sound object. "
                          :impl "lua"
                          :name "sound_get_pitch"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
              :name "get_sound_pitch"
              :namespace "lyte"
              :rets [{:name "val" :type "double"}]}
             {:args {}
              :doc "Load the file in the path. "
              :impl "native"
              :mapto {:args [{:name "file_path" :type "string"}]
                      :doc "Load the file in the path. "
                      :impl "native"
                      :name "load_textfile"
                      :namespace "lyte_core"
                      :rets [{:name "val" :type "string"}]}
              :name "load_textfile"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. "
              :impl "native"
              :mapto {:args [{:name "file_path" :type "string"}
                             {:name "data" :type "string"}]
                      :doc "Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. "
                      :impl "native"
                      :name "save_textfile"
                      :namespace "lyte_core"
                      :rets {}}
              :name "save_textfile"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. "
              :impl "native"
              :mapto {:args [{:name "file_path" :type "string"}
                             {:name "data" :type "string"}]
                      :doc "Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. "
                      :impl "native"
                      :name "save_textfile_append"
                      :namespace "lyte_core"
                      :rets {}}
              :name "save_textfile_append"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Push the transform matrix. "
              :impl "native"
              :mapto {:args {}
                      :doc "Push the transform matrix. "
                      :impl "native"
                      :name "push_matrix"
                      :namespace "lyte_core"
                      :rets {}}
              :name "push_matrix"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Pop the transform matrix. "
              :impl "native"
              :mapto {:args {}
                      :doc "Pop the transform matrix. "
                      :impl "native"
                      :name "pop_matrix"
                      :namespace "lyte_core"
                      :rets {}}
              :name "pop_matrix"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the transformation matrix (load identity matrix.) "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the transformation matrix (load identity matrix.) "
                      :impl "native"
                      :name "reset_matrix"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_matrix"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Apply translation (changes transform matrix.) "
              :impl "native"
              :mapto {:args [{:name "delta_x" :type "double"}
                             {:name "delta_y" :type "double"}]
                      :doc "Apply translation (changes transform matrix.) "
                      :impl "native"
                      :name "translate"
                      :namespace "lyte_core"
                      :rets {}}
              :name "translate"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Apply rotation (changes transform matrix.) "
              :impl "native"
              :mapto {:args [{:name "angle" :type "double"}]
                      :doc "Apply rotation (changes transform matrix.) "
                      :impl "native"
                      :name "rotate"
                      :namespace "lyte_core"
                      :rets {}}
              :name "rotate"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Apply rotation at the given location (changes transform matrix.) "
              :impl "native"
              :mapto {:args [{:name "angle" :type "double"}
                             {:name "x" :type "double"}
                             {:name "y" :type "double"}]
                      :doc "Apply rotation at the given location (changes transform matrix.) "
                      :impl "native"
                      :name "rotate_at"
                      :namespace "lyte_core"
                      :rets {}}
              :name "rotate_at"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Apply scaling (changes transform matrix.) "
              :impl "native"
              :mapto {:args [{:name "scale_x" :type "double"}
                             {:name "scale_y" :type "double"}]
                      :doc "Apply scaling (changes transform matrix.) "
                      :impl "native"
                      :name "scale"
                      :namespace "lyte_core"
                      :rets {}}
              :name "scale"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Apply scaling at the given location (changes transform matrix.) "
              :impl "native"
              :mapto {:args [{:name "scale_x" :type "double"}
                             {:name "scale_y" :type "double"}
                             {:name "x" :type "double"}
                             {:name "y" :type "double"}]
                      :doc "Apply scaling at the given location (changes transform matrix.) "
                      :impl "native"
                      :name "scale_at"
                      :namespace "lyte_core"
                      :rets {}}
              :name "scale_at"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the default blendmode. "
              :impl "native"
              :mapto {:args [{:name "blendmode" :type "BlendMode"}]
                      :doc "Set the default blendmode. "
                      :impl "native"
                      :name "set_default_blendmode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_default_blendmode"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the effective blendmode. "
              :impl "native"
              :mapto {:args [{:name "blendmode" :type "BlendMode"}]
                      :doc "Set the effective blendmode. "
                      :impl "native"
                      :name "set_blendmode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_blendmode"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the blendmode value to its default value. "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the blendmode value to its default value. "
                      :impl "native"
                      :name "reset_blendmode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_blendmode"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the default filtermode. "
              :impl "native"
              :mapto {:args [{:name "filtermode" :type "FilterMode"}]
                      :doc "Set the default filtermode. "
                      :impl "native"
                      :name "set_default_filtermode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_default_filtermode"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Set the effective filtermode. "
              :impl "native"
              :mapto {:args [{:name "filtermode" :type "FilterMode"}]
                      :doc "Set the effective filtermode. "
                      :impl "native"
                      :name "set_filtermode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "set_filtermode"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the filtermode value to its default value. "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the filtermode value to its default value. "
                      :impl "native"
                      :name "reset_filtermode"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_filtermode"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shaderbuilder"
                      :type "ShaderBuilder"
                      :wrapped true}]
              :doc "Free ShaderBuilder resources "
              :impl "lua"
              :mapwrapto {:args [{:name "shaderbuilder" :type "pointer"}]
                          :doc "Free ShaderBuilder resources "
                          :impl "lua"
                          :name "shaderbuilder_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_shaderbuilder"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Create a ShaderBuilder object. "
              :impl "lua"
              :mapwrapto {:args {}
                          :doc "Create a ShaderBuilder object. "
                          :impl "lua"
                          :name "shaderbuilder_new"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
              :name "new_shaderbuilder"
              :namespace "lyte"
              :rets [{:name "val" :type "ShaderBuilder" :wrapped true}]}
             {:args [{:name "shaderbuilder"
                      :type "ShaderBuilder"
                      :wrapped true}
                     {:name "uniform_name" :type "string"}
                     {:name "uniform_type" :type "UniformType"}]
              :doc "Add uniform definition to the shaderbuilder "
              :impl "lua"
              :mapwrapto {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "uniform_name" :type "string"}
                                 {:name "uniform_type" :type "UniformType"}]
                          :doc "Add uniform definition to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_uniform"
                          :namespace "lyte_core"
                          :rets {}}
              :name "shaderbuilder_uniform"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shaderbuilder"
                      :type "ShaderBuilder"
                      :wrapped true}
                     {:name "vertex_code" :type "string"}]
              :doc "Add vertex code to the shaderbuilder "
              :impl "lua"
              :mapwrapto {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "vertex_code" :type "string"}]
                          :doc "Add vertex code to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_vertex"
                          :namespace "lyte_core"
                          :rets {}}
              :name "shaderbuilder_vertex"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shaderbuilder"
                      :type "ShaderBuilder"
                      :wrapped true}
                     {:name "fragment_code" :type "string"}]
              :doc "Add fragment to the shaderbuilder "
              :impl "lua"
              :mapwrapto {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "fragment_code" :type "string"}]
                          :doc "Add fragment to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_fragment"
                          :namespace "lyte_core"
                          :rets {}}
              :name "shaderbuilder_fragment"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shaderbuilder"
                      :type "ShaderBuilder"
                      :wrapped true}]
              :doc "Add fragment to the shaderbuilder "
              :impl "lua"
              :mapwrapto {:args [{:name "shaderbuilder" :type "pointer"}]
                          :doc "Add fragment to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_build"
                          :namespace "lyte_core"
                          :rets [{:name "shader" :type "pointer"}]}
              :name "shaderbuilder_build"
              :namespace "lyte"
              :rets [{:name "shader" :type "Shader" :wrapped true}]}
             {:args [{:name "shader" :type "Shader" :wrapped true}]
              :doc "Free Shader resources "
              :impl "lua"
              :mapwrapto {:args [{:name "shader" :type "pointer"}]
                          :doc "Free Shader resources "
                          :impl "lua"
                          :name "shader_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
              :name "cleanup_shader"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shaderdef" :type "ShaderDef" :wrapped true}]
              :code "function(def)
    assert(def.uniforms)
    assert(def.vert)
    assert(def.frag)
    local sb = lyte.new_shaderbuilder()
    for k,v in pairs(def.uniforms) do
        sb:uniform(k, v)
    end
    sb:vertex(def.vert)
    sb:fragment(def.frag)
    local shader = sb:build()
    return shader;
end
"
              :doc "Create a shader with given specification. "
              :impl "lua"
              :name "new_shader"
              :namespace "lyte"
              :rets [{:name "val" :type "Shader" :wrapped true}]}
             {:args [{:name "shader" :type "Shader" :wrapped true}]
              :doc "Set the custom shader and use it for consequent calls. "
              :impl "lua"
              :mapwrapto {:args [{:name "shader" :type "pointer"}]
                          :doc "Set the custom shader and use it for consequent calls. "
                          :impl "lua"
                          :name "shader_set"
                          :namespace "lyte_core"
                          :rets {}}
              :name "set_shader"
              :namespace "lyte"
              :rets {}}
             {:args {}
              :doc "Reset the shader, back to framework defaults. "
              :impl "native"
              :mapto {:args {}
                      :doc "Reset the shader, back to framework defaults. "
                      :impl "native"
                      :name "reset_shader"
                      :namespace "lyte_core"
                      :rets {}}
              :name "reset_shader"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shader" :type "Shader" :wrapped true}
                     {:name "uniform_name" :type "string"}
                     {:name "uniform_value" :type "ShaderUniformValue"}]
              :code "function (shader, uniform_name, uniform_value)
    -- check the value type for one of the following, and call the \"right\" func
      -- shader_set_uniform_float
      -- shader_set_uniform_floatvec4
      -- shader_set_uniform_image
    local vt = type(uniform_value)
    if vt == \"number\" then
        -- send float
        lyte_core.shader_set_uniform_float(shader.id, uniform_name, uniform_value)
    elseif vt == \"table\" then
        -- number table? or \"data\" table? check metatable for \"Image\" and also check count \"#\"
        if #uniform_value > 0 then
            lyte_core.shader_set_uniform_floatvec4(shader.id, uniform_name, uniform_value)
        elseif getmetatable(uniform_value) == lyte.Image then
            local img_id = uniform_value.id
            lyte_core.shader_set_uniform_image(shader.id, uniform_name, img_id)
        else
            error(\"Unknown type for uniform_value in set_shader_uniform. Expected: float, float list or lyte.Image\")
        end
    else
        error(\"Unknown value type for uniform_value in set_shader_uniform\")
    end
end
"
              :doc "Set the specified uniform. "
              :impl "lua"
              :name "set_shader_uniform"
              :namespace "lyte"
              :rets {}}
             {:args [{:name "shader" :type "Shader" :wrapped true}
                     {:name "uniform_name" :type "string"}]
              :doc "Reset the specified uniform. "
              :impl "lua"
              :mapwrapto {:args [{:name "shader" :type "pointer"}
                                 {:name "uniform_name" :type "string"}]
                          :doc "Reset the specified uniform. "
                          :impl "lua"
                          :name "shader_reset_uniform"
                          :namespace "lyte_core"
                          :rets {}}
              :name "reset_shader_uniform"
              :namespace "lyte"
              :rets {}}]
 :lists [{:doc "Float values"
          :item_type "float"
          :max_count 4
          :name "FloatVec4"
          :namespace "lyte"}]
 :name "lyte"
 :namespaces {}
 :records [{:doc "Shader definition: uniforms declaration, vertex and fragment shader code. "
            :fields [{:name "frag" :type "string"}
                     {:name "vert" :type "string"}
                     {:name "uniforms" :type "UniformNamesToTypes"}]
            :methods {}
            :name "ShaderDef"
            :namespace "lyte"}
           {:doc "Image type "
            :fields [{:mapread {:args [{:name "image"
                                        :type "Image"
                                        :wrapped true}]
                                :doc "Get the width of the image. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "image"
                                                    :type "pointer"}]
                                            :doc "Get the width of the image. "
                                            :impl "lua"
                                            :name "image_get_width"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "int"}]}
                                :name "get_image_width"
                                :namespace "lyte"
                                :rets [{:name "val" :type "int"}]}
                      :name "width"
                      :type "int"}
                     {:mapread {:args [{:name "image"
                                        :type "Image"
                                        :wrapped true}]
                                :doc "Get the height of the image. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "image"
                                                    :type "pointer"}]
                                            :doc "Get the height of the image. "
                                            :impl "lua"
                                            :name "image_get_height"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "int"}]}
                                :name "get_image_height"
                                :namespace "lyte"
                                :rets [{:name "val" :type "int"}]}
                      :name "height"
                      :type "int"}
                     {:mapread {:args [{:name "image"
                                        :type "Image"
                                        :wrapped true}]
                                :doc "Check if the image was created as a canvas. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "image"
                                                    :type "pointer"}]
                                            :doc "Check if the image was created as a canvas. "
                                            :impl "lua"
                                            :name "image_is_canvas"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "bool"}]}
                                :name "is_image_canvas"
                                :namespace "lyte"
                                :rets [{:name "val" :type "bool"}]}
                      :name "is_canvas"
                      :type "bool"}]
            :methods [{:mapto {:args [{:name "image"
                                       :type "Image"
                                       :wrapped true}]
                               :doc "Free Image resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "image"
                                                   :type "pointer"}]
                                           :doc "Free Image resources "
                                           :impl "lua"
                                           :name "image_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_image"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "Image"
            :namespace "lyte"}
           {:doc "ImageBatch type. "
            :fields [{:mapread {:args [{:name "imagebatch"
                                        :type "ImageBatch"
                                        :wrapped true}]
                                :doc "Get the number of rects in the image batch. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "imagebatch"
                                                    :type "pointer"}]
                                            :doc "Get the number of rects in the image batch. "
                                            :impl "lua"
                                            :name "imagebatch_get_rect_count"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "int"}]}
                                :name "get_imagebatch_rect_count"
                                :namespace "lyte"
                                :rets [{:name "val" :type "int"}]}
                      :name "rect_count"
                      :type "int"}]
            :methods [{:mapto {:args [{:name "imagebatch"
                                       :type "ImageBatch"
                                       :wrapped true}
                                      {:name "dest_x" :type "double"}
                                      {:name "dest_y" :type "double"}
                                      {:name "dest_width" :type "double"}
                                      {:name "dest_height" :type "double"}
                                      {:name "src_x" :type "double"}
                                      {:name "src_y" :type "double"}
                                      {:name "src_width" :type "double"}
                                      {:name "src_height" :type "double"}]
                               :doc "Add a recta to the image batch (from it's initial image). "
                               :impl "lua"
                               :mapwrapto {:args [{:name "imagebatch"
                                                   :type "pointer"}
                                                  {:name "dest_x"
                                                   :type "double"}
                                                  {:name "dest_y"
                                                   :type "double"}
                                                  {:name "dest_width"
                                                   :type "double"}
                                                  {:name "dest_height"
                                                   :type "double"}
                                                  {:name "src_x"
                                                   :type "double"}
                                                  {:name "src_y"
                                                   :type "double"}
                                                  {:name "src_width"
                                                   :type "double"}
                                                  {:name "src_height"
                                                   :type "double"}]
                                           :doc "Add a recta to the image batch (from it's initial image). "
                                           :impl "lua"
                                           :name "imagebatch_add_rect"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "add_imagebatch_rect"
                               :namespace "lyte"
                               :rets {}}
                       :name "add_rect"}
                      {:mapto {:args [{:name "imagebatch"
                                       :type "ImageBatch"
                                       :wrapped true}]
                               :doc "Draw the image batch. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "imagebatch"
                                                   :type "pointer"}]
                                           :doc "Draw the image batch. "
                                           :impl "lua"
                                           :name "imagebatch_draw"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "draw_imagebatch"
                               :namespace "lyte"
                               :rets {}}
                       :name "draw"}
                      {:mapto {:args [{:name "imagebatch"
                                       :type "ImageBatch"
                                       :wrapped true}]
                               :doc "Reset the image batch, remove all added rects. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "imagebatch"
                                                   :type "pointer"}]
                                           :doc "Reset the image batch, remove all added rects. "
                                           :impl "lua"
                                           :name "imagebatch_reset"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "reset_imagebatch"
                               :namespace "lyte"
                               :rets {}}
                       :name "reset"}
                      {:mapto {:args [{:name "imagebatch"
                                       :type "ImageBatch"
                                       :wrapped true}]
                               :doc "Free ImageBatch resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "imagebatch"
                                                   :type "pointer"}]
                                           :doc "Free ImageBatch resources "
                                           :impl "lua"
                                           :name "imagebatch_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_imagebatch"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "ImageBatch"
            :namespace "lyte"}
           {:doc "Font type. "
            :fields {}
            :methods [{:mapto {:args [{:name "font" :type "Font" :wrapped true}]
                               :doc "Free Font resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "font"
                                                   :type "pointer"}]
                                           :doc "Free Font resources "
                                           :impl "lua"
                                           :name "font_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_font"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "Font"
            :namespace "lyte"}
           {:doc "Music type. "
            :fields [{:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Check if the given music is playing. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Check if the given music is playing. "
                                            :impl "lua"
                                            :name "music_is_playing"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "bool"}]}
                                :name "is_music_playing"
                                :namespace "lyte"
                                :rets [{:name "val" :type "bool"}]}
                      :name "playing"
                      :type "bool"}
                     {:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Get the length of the given music object in seconds. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Get the length of the given music object in seconds. "
                                            :impl "lua"
                                            :name "music_get_length"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_music_length"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :name "length"
                      :type "double"}
                     {:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Get the already played length of the given music object in seconds. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Get the already played length of the given music object in seconds. "
                                            :impl "lua"
                                            :name "music_get_length_played"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_music_length_played"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :name "length_played"
                      :type "double"}
                     {:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Get the pan of the given music object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Get the pan of the given music object. "
                                            :impl "lua"
                                            :name "music_get_pan"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_music_pan"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "music"
                                         :type "Music"
                                         :wrapped true}
                                        {:name "pan" :type "double"}]
                                 :doc "Set the pan of the given music object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "music"
                                                     :type "pointer"}
                                                    {:name "volume"
                                                     :type "double"}]
                                             :doc "Set the volume of the given music object. "
                                             :impl "lua"
                                             :name "music_set_volume"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_music_pan"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "pan"
                      :type "double"}
                     {:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Get the pitch of the given music object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Get the pitch of the given music object. "
                                            :impl "lua"
                                            :name "music_get_pitch"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_music_pitch"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "music"
                                         :type "Music"
                                         :wrapped true}
                                        {:name "pitch" :type "double"}]
                                 :doc "Set the pitch of the given music object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "music"
                                                     :type "pointer"}
                                                    {:name "pitch"
                                                     :type "double"}]
                                             :doc "Set the pitch of the given music object. "
                                             :impl "lua"
                                             :name "music_set_pitch"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_music_pitch"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "pitch"
                      :type "double"}
                     {:mapread {:args [{:name "music"
                                        :type "Music"
                                        :wrapped true}]
                                :doc "Get the volume of the given music object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "music"
                                                    :type "pointer"}]
                                            :doc "Get the volume of the given music object. "
                                            :impl "lua"
                                            :name "music_get_volume"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_music_volume"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "music"
                                         :type "Music"
                                         :wrapped true}
                                        {:name "volume" :type "double"}]
                                 :doc "Set the volume of the given music object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "music"
                                                     :type "pointer"}
                                                    {:name "volume"
                                                     :type "double"}]
                                             :doc "Set the volume of the given music object. "
                                             :impl "lua"
                                             :name "music_set_volume"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_music_volume"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "volume"
                      :type "double"}]
            :methods [{:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}]
                               :doc "Play the music. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}]
                                           :doc "Play the music. "
                                           :impl "lua"
                                           :name "music_play"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "play_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "play"}
                      {:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}]
                               :doc "Pause the music. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}]
                                           :doc "Pause the music. "
                                           :impl "lua"
                                           :name "music_pause"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "pause_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "pause"}
                      {:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}]
                               :doc "Resume the music. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}]
                                           :doc "Resume the music. "
                                           :impl "lua"
                                           :name "music_resume"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "resume_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "resume"}
                      {:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}]
                               :doc "Stop the music. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}]
                                           :doc "Resume the music. "
                                           :impl "lua"
                                           :name "music_resume"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "stop_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "stop"}
                      {:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}
                                      {:name "secs" :type "double"}]
                               :doc "Move the music time played to the given value. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}
                                                  {:name "secs" :type "double"}]
                                           :doc "Move the music time played to the given value. "
                                           :impl "lua"
                                           :name "music_seek"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "seek_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "seek"}
                      {:mapto {:args [{:name "music"
                                       :type "Music"
                                       :wrapped true}]
                               :doc "Free Music resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "music"
                                                   :type "pointer"}]
                                           :doc "Free Music resources "
                                           :impl "lua"
                                           :name "music_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_music"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "Music"
            :namespace "lyte"}
           {:doc "Sound type. "
            :fields [{:mapread {:args [{:name "sound"
                                        :type "Sound"
                                        :wrapped true}]
                                :doc "Get the pan of the given sound object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "sound"
                                                    :type "pointer"}]
                                            :doc "Get the pan of the given sound object. "
                                            :impl "lua"
                                            :name "sound_get_pan"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_sound_pan"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "sound"
                                         :type "Sound"
                                         :wrapped true}
                                        {:name "pan" :type "double"}]
                                 :doc "Set the pan of the given sound object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "sound"
                                                     :type "pointer"}
                                                    {:name "pan"
                                                     :type "double"}]
                                             :doc "Set the pan of the given sound object. "
                                             :impl "lua"
                                             :name "sound_set_pan"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_sound_pan"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "pan"
                      :type "double"}
                     {:mapread {:args [{:name "sound"
                                        :type "Sound"
                                        :wrapped true}]
                                :doc "Get the pitch of the given sound object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "sound"
                                                    :type "pointer"}]
                                            :doc "Get the pitch of the given sound object. "
                                            :impl "lua"
                                            :name "sound_get_pitch"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_sound_pitch"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "sound"
                                         :type "Sound"
                                         :wrapped true}
                                        {:name "pitch" :type "double"}]
                                 :doc "Set the pitch of the given sound object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "sound"
                                                     :type "pointer"}
                                                    {:name "pitch"
                                                     :type "double"}]
                                             :doc "Set the pitch of the given sound object. "
                                             :impl "lua"
                                             :name "sound_set_pitch"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_sound_pitch"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "pitch"
                      :type "double"}
                     {:mapread {:args [{:name "sound"
                                        :type "Sound"
                                        :wrapped true}]
                                :doc "Get the volume of the given sound object. "
                                :impl "lua"
                                :mapwrapto {:args [{:name "sound"
                                                    :type "pointer"}]
                                            :doc "Get the volume of the given sound object. "
                                            :impl "native"
                                            :name "sound_get_volume"
                                            :namespace "lyte_core"
                                            :rets [{:name "val" :type "double"}]}
                                :name "get_sound_volume"
                                :namespace "lyte"
                                :rets [{:name "val" :type "double"}]}
                      :mapwrite {:args [{:name "sound"
                                         :type "Sound"
                                         :wrapped true}
                                        {:name "volume" :type "double"}]
                                 :doc "Set the volume of the given sound object. "
                                 :impl "lua"
                                 :mapwrapto {:args [{:name "sound"
                                                     :type "pointer"}
                                                    {:name "volume"
                                                     :type "double"}]
                                             :doc "Set the volume of the given sound object. "
                                             :impl "lua"
                                             :name "sound_set_volume"
                                             :namespace "lyte_core"
                                             :rets {}}
                                 :name "set_sound_volume"
                                 :namespace "lyte"
                                 :rets {}}
                      :name "volume"
                      :type "double"}]
            :methods [{:mapto {:args [{:name "orig"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Clone the sound specified in the path. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "orig"
                                                   :type "pointer"}]
                                           :doc "Clone the sound specified in the path. "
                                           :impl "lua"
                                           :name "sound_clone"
                                           :namespace "lyte_core"
                                           :rets [{:name "val" :type "pointer"}]}
                               :name "clone_sound"
                               :namespace "lyte"
                               :rets [{:name "val" :type "Sound" :wrapped true}]}
                       :name "clone"}
                      {:mapto {:args [{:name "sound"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Pause the sound. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "sound"
                                                   :type "pointer"}]
                                           :doc "Pause the sound. "
                                           :impl "lua"
                                           :name "sound_pause"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "pause_sound"
                               :namespace "lyte"
                               :rets {}}
                       :name "pause"}
                      {:mapto {:args [{:name "sound"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Play the sound. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "sound"
                                                   :type "pointer"}]
                                           :doc "Play the sound. "
                                           :impl "lua"
                                           :name "sound_play"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "play_sound"
                               :namespace "lyte"
                               :rets {}}
                       :name "play"}
                      {:mapto {:args [{:name "sound"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Resume the sound. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "sound"
                                                   :type "pointer"}]
                                           :doc "Resume the sound. "
                                           :impl "lua"
                                           :name "sound_resume"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "resume_sound"
                               :namespace "lyte"
                               :rets {}}
                       :name "resume"}
                      {:mapto {:args [{:name "sound"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Stop the sound. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "sound"
                                                   :type "pointer"}]
                                           :doc "Stop the sound. "
                                           :impl "lua"
                                           :name "sound_stop"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "stop_sound"
                               :namespace "lyte"
                               :rets {}}
                       :name "stop"}
                      {:mapto {:args [{:name "sound"
                                       :type "Sound"
                                       :wrapped true}]
                               :doc "Free Sound resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "sound"
                                                   :type "pointer"}]
                                           :doc "Free Sound resources "
                                           :impl "lua"
                                           :name "sound_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_sound"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "Sound"
            :namespace "lyte"}
           {:doc "Shader type "
            :fields {}
            :methods [{:mapto {:args [{:name "shader"
                                       :type "Shader"
                                       :wrapped true}
                                      {:name "uniform_name" :type "string"}
                                      {:name "uniform_value"
                                       :type "ShaderUniformValue"}]
                               :code "function (shader, uniform_name, uniform_value)
    -- check the value type for one of the following, and call the \"right\" func
      -- shader_set_uniform_float
      -- shader_set_uniform_floatvec4
      -- shader_set_uniform_image
    local vt = type(uniform_value)
    if vt == \"number\" then
        -- send float
        lyte_core.shader_set_uniform_float(shader.id, uniform_name, uniform_value)
    elseif vt == \"table\" then
        -- number table? or \"data\" table? check metatable for \"Image\" and also check count \"#\"
        if #uniform_value > 0 then
            lyte_core.shader_set_uniform_floatvec4(shader.id, uniform_name, uniform_value)
        elseif getmetatable(uniform_value) == lyte.Image then
            local img_id = uniform_value.id
            lyte_core.shader_set_uniform_image(shader.id, uniform_name, img_id)
        else
            error(\"Unknown type for uniform_value in set_shader_uniform. Expected: float, float list or lyte.Image\")
        end
    else
        error(\"Unknown value type for uniform_value in set_shader_uniform\")
    end
end
"
                               :doc "Set the specified uniform. "
                               :impl "lua"
                               :name "set_shader_uniform"
                               :namespace "lyte"
                               :rets {}}
                       :name "set"}
                      {:mapto {:args [{:name "shader"
                                       :type "Shader"
                                       :wrapped true}
                                      {:name "uniform_name" :type "string"}]
                               :doc "Reset the specified uniform. "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shader"
                                                   :type "pointer"}
                                                  {:name "uniform_name"
                                                   :type "string"}]
                                           :doc "Reset the specified uniform. "
                                           :impl "lua"
                                           :name "shader_reset_uniform"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "reset_shader_uniform"
                               :namespace "lyte"
                               :rets {}}
                       :name "reset"}
                      {:mapto {:args [{:name "shader"
                                       :type "Shader"
                                       :wrapped true}]
                               :doc "Free Shader resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shader"
                                                   :type "pointer"}]
                                           :doc "Free Shader resources "
                                           :impl "lua"
                                           :name "shader_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_shader"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "Shader"
            :namespace "lyte"}
           {:doc "ShaderBuilder type "
            :fields {}
            :methods [{:mapto {:args [{:name "shaderbuilder"
                                       :type "ShaderBuilder"
                                       :wrapped true}
                                      {:name "uniform_name" :type "string"}
                                      {:name "uniform_type"
                                       :type "UniformType"}]
                               :doc "Add uniform definition to the shaderbuilder "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shaderbuilder"
                                                   :type "pointer"}
                                                  {:name "uniform_name"
                                                   :type "string"}
                                                  {:name "uniform_type"
                                                   :type "UniformType"}]
                                           :doc "Add uniform definition to the shaderbuilder "
                                           :impl "lua"
                                           :name "shaderbuilder_uniform"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "shaderbuilder_uniform"
                               :namespace "lyte"
                               :rets {}}
                       :name "uniform"}
                      {:mapto {:args [{:name "shaderbuilder"
                                       :type "ShaderBuilder"
                                       :wrapped true}
                                      {:name "vertex_code" :type "string"}]
                               :doc "Add vertex code to the shaderbuilder "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shaderbuilder"
                                                   :type "pointer"}
                                                  {:name "vertex_code"
                                                   :type "string"}]
                                           :doc "Add vertex code to the shaderbuilder "
                                           :impl "lua"
                                           :name "shaderbuilder_vertex"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "shaderbuilder_vertex"
                               :namespace "lyte"
                               :rets {}}
                       :name "vertex"}
                      {:mapto {:args [{:name "shaderbuilder"
                                       :type "ShaderBuilder"
                                       :wrapped true}
                                      {:name "fragment_code" :type "string"}]
                               :doc "Add fragment to the shaderbuilder "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shaderbuilder"
                                                   :type "pointer"}
                                                  {:name "fragment_code"
                                                   :type "string"}]
                                           :doc "Add fragment to the shaderbuilder "
                                           :impl "lua"
                                           :name "shaderbuilder_fragment"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "shaderbuilder_fragment"
                               :namespace "lyte"
                               :rets {}}
                       :name "fragment"}
                      {:mapto {:args [{:name "shaderbuilder"
                                       :type "ShaderBuilder"
                                       :wrapped true}]
                               :doc "Add fragment to the shaderbuilder "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shaderbuilder"
                                                   :type "pointer"}]
                                           :doc "Add fragment to the shaderbuilder "
                                           :impl "lua"
                                           :name "shaderbuilder_build"
                                           :namespace "lyte_core"
                                           :rets [{:name "shader"
                                                   :type "pointer"}]}
                               :name "shaderbuilder_build"
                               :namespace "lyte"
                               :rets [{:name "shader"
                                       :type "Shader"
                                       :wrapped true}]}
                       :name "build"}
                      {:mapto {:args [{:name "shaderbuilder"
                                       :type "ShaderBuilder"
                                       :wrapped true}]
                               :doc "Free ShaderBuilder resources "
                               :impl "lua"
                               :mapwrapto {:args [{:name "shaderbuilder"
                                                   :type "pointer"}]
                                           :doc "Free ShaderBuilder resources "
                                           :impl "lua"
                                           :name "shaderbuilder_cleanup"
                                           :namespace "lyte_core"
                                           :rets {}}
                               :name "cleanup_shaderbuilder"
                               :namespace "lyte"
                               :rets {}}
                       :name "__gc"}]
            :name "ShaderBuilder"
            :namespace "lyte"}]
 :requires [{:dicts {}
             :doc "
lyte_core namespace. Direct API mappings to C library."
             :enums [{:doc "Acceptable uniformtype values."
                      :name "UniformType"
                      :namespace "lyte_core"
                      :values ["_invalid"
                               "float"
                               "vec2"
                               "vec3"
                               "vec4"
                               "int"
                               "ivec2"
                               "ivec3"
                               "ivec4"
                               "mat4"
                               "sampler2D"]}
                     {:doc "Acceptable blendmode values."
                      :name "BlendMode"
                      :namespace "lyte_core"
                      :values ["none" "blend" "add" "mod" "mul"]}
                     {:doc "Acceptable filtermode values."
                      :name "FilterMode"
                      :namespace "lyte_core"
                      :values ["_invalid" "nearest" "linear"]}
                     {:doc "Acceptable gamepadaxis values."
                      :name "GamepadAxis"
                      :namespace "lyte_core"
                      :values ["left_x"
                               "left_y"
                               "right_x"
                               "right_y"
                               "left_trigger"
                               "right_trigger"]}
                     {:doc "Acceptable gamepadbutton values."
                      :name "GamepadButton"
                      :namespace "lyte_core"
                      :values ["pad_a"
                               "pad_b"
                               "pad_x"
                               "pad_y"
                               "left_bumper"
                               "right_bumper"
                               "back"
                               "start"
                               "guide"
                               "left_thumb"
                               "right_thumb"
                               "dpad_up"
                               "dpad_right"
                               "dpad_down"
                               "dpad_left"]}
                     {:doc "Acceptable mousebutton values."
                      :name "MouseButton"
                      :namespace "lyte_core"
                      :values ["mb1" "mb2" "mb3" "mb4" "mb5" "mb6" "mb7" "mb8"]}
                     {:doc "Acceptable keyboardkey values."
                      :name "KeyboardKey"
                      :namespace "lyte_core"
                      :values ["space"
                               "'"
                               ","
                               "-"
                               "."
                               "/"
                               "0"
                               "1"
                               "2"
                               "3"
                               "4"
                               "5"
                               "6"
                               "7"
                               "8"
                               "9"
                               ";"
                               "="
                               "a"
                               "b"
                               "c"
                               "d"
                               "e"
                               "f"
                               "g"
                               "h"
                               "i"
                               "j"
                               "k"
                               "l"
                               "m"
                               "n"
                               "o"
                               "p"
                               "q"
                               "r"
                               "s"
                               "t"
                               "u"
                               "v"
                               "w"
                               "x"
                               "y"
                               "z"
                               "["
                               "\\"
                               "]"
                               "`"
                               "world_1"
                               "world_2"
                               "escape"
                               "enter"
                               "tab"
                               "backspace"
                               "insert"
                               "delete"
                               "right"
                               "left"
                               "down"
                               "up"
                               "page_up"
                               "page_down"
                               "home"
                               "end"
                               "caps_lock"
                               "scroll_lock"
                               "num_lock"
                               "print_screen"
                               "pause"
                               "f1"
                               "f2"
                               "f3"
                               "f4"
                               "f5"
                               "f6"
                               "f7"
                               "f8"
                               "f9"
                               "f10"
                               "f11"
                               "f12"
                               "f13"
                               "f14"
                               "f15"
                               "f16"
                               "f17"
                               "f18"
                               "f19"
                               "f20"
                               "f21"
                               "f22"
                               "f23"
                               "f24"
                               "f25"
                               "kp_0"
                               "kp_1"
                               "kp_2"
                               "kp_3"
                               "kp_4"
                               "kp_5"
                               "kp_6"
                               "kp_7"
                               "kp_8"
                               "kp_9"
                               "kp_decimal"
                               "kp_divide"
                               "kp_multiply"
                               "kp_subtract"
                               "kp_add"
                               "kp_enter"
                               "kp_equal"
                               "left_shift"
                               "left_control"
                               "left_alt"
                               "left_super"
                               "right_shift"
                               "right_control"
                               "right_alt"
                               "right_super"
                               "menu"]}]
             :functions [{:args {}
                          :doc "Quit the application by closing the window. "
                          :impl "native"
                          :name "quit"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "r" :type "double"}
                                 {:name "g" :type "double"}
                                 {:name "b" :type "double"}
                                 {:name "a" :type "double"}]
                          :doc "Clear the screen or current canvas if one is used. "
                          :impl "native"
                          :name "cls"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "r" :type "double"}
                                 {:name "g" :type "double"}
                                 {:name "b" :type "double"}
                                 {:name "a" :type "double"}]
                          :doc "Set the foreground color to be used in the drawing operations. "
                          :impl "native"
                          :name "set_color"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the foreground color to its default value. "
                          :impl "native"
                          :name "reset_color"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "x" :type "double"}
                                 {:name "y" :type "double"}]
                          :doc "Draw a point. "
                          :impl "native"
                          :name "draw_point"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "x1" :type "double"}
                                 {:name "y1" :type "double"}
                                 {:name "x2" :type "double"}
                                 {:name "y2" :type "double"}]
                          :doc "Draw a line "
                          :impl "native"
                          :name "draw_line"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "ax" :type "double"}
                                 {:name "ay" :type "double"}
                                 {:name "bx" :type "double"}
                                 {:name "by" :type "double"}
                                 {:name "cx" :type "double"}
                                 {:name "cy" :type "double"}]
                          :doc "Draw a filled triangle "
                          :impl "native"
                          :name "draw_triangle"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "ax" :type "double"}
                                 {:name "ay" :type "double"}
                                 {:name "bx" :type "double"}
                                 {:name "by" :type "double"}
                                 {:name "cx" :type "double"}
                                 {:name "cy" :type "double"}]
                          :doc "Draw a triangle border "
                          :impl "native"
                          :name "draw_triangle_line"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "rect_width" :type "double"}
                                 {:name "rect_height" :type "double"}]
                          :doc "Draw a filled rectangle. "
                          :impl "native"
                          :name "draw_rect"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "rect_width" :type "double"}
                                 {:name "rect_height" :type "double"}]
                          :doc "Draw a rectangle border. "
                          :impl "native"
                          :name "draw_rect_line"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "radius" :type "double"}]
                          :doc "Draw a filled circle. "
                          :impl "native"
                          :name "draw_circle"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "radius" :type "double"}]
                          :doc "Draw a circle border. "
                          :impl "native"
                          :name "draw_circle_line"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "radius_x" :type "double"}
                                 {:name "radius_y" :type "double"}]
                          :doc "Draw a filled ellipse. "
                          :impl "native"
                          :name "draw_ellipse"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "radius_x" :type "double"}
                                 {:name "radius_y" :type "double"}]
                          :doc "Draw an ellipse border. "
                          :impl "native"
                          :name "draw_ellipse_line"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image" :type "pointer"}]
                          :doc "Free Image resources "
                          :impl "lua"
                          :name "image_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image_path" :type "string"}]
                          :doc "Load the image specified in the path. "
                          :impl "lua"
                          :name "image_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "image" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}]
                          :doc "Draw an image. "
                          :impl "lua"
                          :name "image_draw"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "src_x" :type "double"}
                                 {:name "src_y" :type "double"}
                                 {:name "rect_width" :type "double"}
                                 {:name "rect_height" :type "double"}]
                          :doc "Draw a rectangular area from the image. "
                          :impl "lua"
                          :name "image_draw_rect"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image" :type "pointer"}]
                          :doc "Get the width of the image. "
                          :impl "lua"
                          :name "image_get_width"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "image" :type "pointer"}]
                          :doc "Get the height of the image. "
                          :impl "lua"
                          :name "image_get_height"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "width" :type "int"}
                                 {:name "height" :type "int"}]
                          :doc "Create a canvas image with given width and height. "
                          :impl "lua"
                          :name "image_new_canvas"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "canvas_image" :type "pointer"}]
                          :doc "Set the effective canvas image. All draw operations will go to this canvas until it's reset. "
                          :impl "lua"
                          :name "image_set_canvas"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the drawing target, back to screen. "
                          :impl "native"
                          :name "reset_canvas"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image" :type "pointer"}]
                          :doc "Check if the image was created as a canvas. "
                          :impl "lua"
                          :name "image_is_canvas"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Free ImageBatch resources "
                          :impl "lua"
                          :name "imagebatch_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "image" :type "pointer"}]
                          :doc "Create an image batch "
                          :impl "lua"
                          :name "imagebatch_new"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Reset the image batch, remove all added rects. "
                          :impl "lua"
                          :name "imagebatch_reset"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "imagebatch" :type "pointer"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}
                                 {:name "dest_width" :type "double"}
                                 {:name "dest_height" :type "double"}
                                 {:name "src_x" :type "double"}
                                 {:name "src_y" :type "double"}
                                 {:name "src_width" :type "double"}
                                 {:name "src_height" :type "double"}]
                          :doc "Add a recta to the image batch (from it's initial image). "
                          :impl "lua"
                          :name "imagebatch_add_rect"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Get the number of rects in the image batch. "
                          :impl "lua"
                          :name "imagebatch_get_rect_count"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "imagebatch" :type "pointer"}]
                          :doc "Draw the image batch. "
                          :impl "lua"
                          :name "imagebatch_draw"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "font" :type "pointer"}]
                          :doc "Free Font resources "
                          :impl "lua"
                          :name "font_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "font_path" :type "string"}
                                 {:name "size" :type "double"}]
                          :doc "Load the font specified in the path, and set the initial size. "
                          :impl "lua"
                          :name "font_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "font" :type "pointer"}]
                          :doc "Set the effective font to be used in the drawing operations. "
                          :impl "lua"
                          :name "font_set"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "text" :type "string"}
                                 {:name "dest_x" :type "double"}
                                 {:name "dest_y" :type "double"}]
                          :doc "Draw a text line. "
                          :impl "native"
                          :name "draw_text"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "text" :type "string"}]
                          :doc "Get the width of the given text line. "
                          :impl "native"
                          :name "get_text_width"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "text" :type "string"}]
                          :doc "Get the height of the given text line. "
                          :impl "native"
                          :name "get_text_height"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args {}
                          :doc "Get the number of currently connected monitors. "
                          :impl "native"
                          :name "get_monitor_count"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "index" :type "int"}]
                          :doc "Get the name of the monitor at the index "
                          :impl "native"
                          :name "get_monitor_name"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "string"}]}
                         {:args [{:name "index" :type "int"}]
                          :doc "Get the width of the monitor at the index "
                          :impl "native"
                          :name "get_monitor_width"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "index" :type "int"}]
                          :doc "Get the height of the monitor at the index "
                          :impl "native"
                          :name "get_monitor_height"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "index" :type "int"}]
                          :doc " Set the window's initial monitor to the indexed value. Must be set before the window is opened. "
                          :impl "native"
                          :name "set_window_monitor"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "resizable" :type "bool"}]
                          :doc " Set the window resizable flag to the given value. Must be set before the window is opened. "
                          :impl "native"
                          :name "set_window_resizable"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "width" :type "int"}
                                 {:name "height" :type "int"}]
                          :doc "Set the window's minimum possible size. "
                          :impl "native"
                          :name "set_window_minsize"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "width" :type "int"}
                                 {:name "height" :type "int"}]
                          :doc "Set the window's size. "
                          :impl "native"
                          :name "set_window_size"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Get the width of the window. "
                          :impl "native"
                          :name "get_window_width"
                          :namespace "lyte_core"
                          :rets [{:doc "Width of the window in pixels"
                                  :name "val"
                                  :type "int"}]}
                         {:args {}
                          :doc "Get the height of the window. "
                          :impl "native"
                          :name "get_window_height"
                          :namespace "lyte_core"
                          :rets [{:doc "Height of the window in pixels"
                                  :name "val"
                                  :type "int"}]}
                         {:args [{:name "x" :type "int"}
                                 {:name "y" :type "int"}]
                          :doc "Set the window's position. "
                          :impl "native"
                          :name "set_window_position"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "fullscreen" :type "bool"}]
                          :doc "Set the window to fullscreen, or windowed mode. "
                          :impl "native"
                          :name "set_fullscreen"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Check if the window is set to fullscreen. "
                          :impl "native"
                          :name "is_fullscreen"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "title" :type "string"}]
                          :doc "Set the window's title. "
                          :impl "native"
                          :name "set_window_title"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "vsync" :type "bool"}]
                          :doc "Set the window vsync flag to the given value. "
                          :impl "native"
                          :name "set_window_vsync"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Check if the window vsync flag is set. "
                          :impl "native"
                          :name "is_window_vsync"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "icon_path" :type "string"}]
                          :doc "Set the window icon. "
                          :impl "native"
                          :name "set_window_icon_file"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "left" :type "int"}
                                 {:name "right" :type "int"}
                                 {:name "top" :type "int"}
                                 {:name "bottom" :type "int"}]
                          :doc "Set the window margins. Margins are ignored and no drawing can be made there.. "
                          :impl "native"
                          :name "set_window_margins"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "left" :type "int"}
                                 {:name "right" :type "int"}
                                 {:name "top" :type "int"}
                                 {:name "bottom" :type "int"}]
                          :doc "Set the window paddings. Paddings are can be drawn on. "
                          :impl "native"
                          :name "set_window_paddings"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "key" :type "KeyboardKey"}]
                          :doc "Check if the given key is down. "
                          :impl "native"
                          :name "is_key_down"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "key" :type "KeyboardKey"}]
                          :doc "Check if the given key is pressed. "
                          :impl "native"
                          :name "is_key_pressed"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "key" :type "KeyboardKey"}]
                          :doc "Check if the given key is released. "
                          :impl "native"
                          :name "is_key_released"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "key" :type "KeyboardKey"}]
                          :doc "Check if the given key is repeated. "
                          :impl "native"
                          :name "is_key_repeat"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "mouse_button" :type "MouseButton"}]
                          :doc "Check if the given mouse button is down. "
                          :impl "native"
                          :name "is_mouse_down"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "mouse_button" :type "MouseButton"}]
                          :doc "Check if the given mouse button is pressed. "
                          :impl "native"
                          :name "is_mouse_pressed"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "mouse_button" :type "MouseButton"}]
                          :doc "Check if the given mouse button is released. "
                          :impl "native"
                          :name "is_mouse_released"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args {}
                          :doc "Get the mouse x position. "
                          :impl "native"
                          :name "get_mouse_x"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args {}
                          :doc "Get the mouse y position. "
                          :impl "native"
                          :name "get_mouse_y"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args {}
                          :doc "Get the number of gamepads. "
                          :impl "native"
                          :name "get_gamepad_count"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "int"}]}
                         {:args [{:name "index" :type "int"}]
                          :doc "Get the name of the gamepad at the given index. "
                          :impl "native"
                          :name "get_gamepad_name"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "string"}]}
                         {:args [{:name "index" :type "int"}
                                 {:name "gamepad_button" :type "GamepadButton"}]
                          :doc "Check if the given button of the gamepad at the given index is down. "
                          :impl "native"
                          :name "is_gamepad_down"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "index" :type "int"}
                                 {:name "gamepad_button" :type "GamepadButton"}]
                          :doc "Check if the given button of the gamepad at the given index is pressed. "
                          :impl "native"
                          :name "is_gamepad_pressed"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "index" :type "int"}
                                 {:name "gamepad_button" :type "GamepadButton"}]
                          :doc "Check if the given button of the gamepad at the given index is released. "
                          :impl "native"
                          :name "is_gamepad_released"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "index" :type "int"}
                                 {:name "gamepad_axis" :type "GamepadAxis"}]
                          :doc "Get the given axis of the gamepad at the given index. "
                          :impl "native"
                          :name "get_gamepad_axis"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "mastervolume" :type "double"}]
                          :doc "Set the master volume. "
                          :impl "native"
                          :name "set_mastervolume"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Get the master volume. "
                          :impl "native"
                          :name "get_mastervolume"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Free Music resources "
                          :impl "lua"
                          :name "music_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music_path" :type "string"}]
                          :doc "Load the music specified in the path. "
                          :impl "lua"
                          :name "music_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Play the music. "
                          :impl "lua"
                          :name "music_play"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Pause the music. "
                          :impl "lua"
                          :name "music_pause"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Resume the music. "
                          :impl "lua"
                          :name "music_resume"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Stop the music. "
                          :impl "lua"
                          :name "music_stop"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Check if the given music is playing. "
                          :impl "lua"
                          :name "music_is_playing"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Get the length of the given music object in seconds. "
                          :impl "lua"
                          :name "music_get_length"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Get the already played length of the given music object in seconds. "
                          :impl "lua"
                          :name "music_get_length_played"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "music" :type "pointer"}
                                 {:name "secs" :type "double"}]
                          :doc "Move the music time played to the given value. "
                          :impl "lua"
                          :name "music_seek"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}
                                 {:name "volume" :type "double"}]
                          :doc "Set the volume of the given music object. "
                          :impl "lua"
                          :name "music_set_volume"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}
                                 {:name "pan" :type "double"}]
                          :doc "Set the pan of the given music object. "
                          :impl "lua"
                          :name "music_set_pan"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}
                                 {:name "pitch" :type "double"}]
                          :doc "Set the pitch of the given music object. "
                          :impl "lua"
                          :name "music_set_pitch"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Get the volume of the given music object. "
                          :impl "lua"
                          :name "music_get_volume"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Get the pan of the given music object. "
                          :impl "lua"
                          :name "music_get_pan"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "music" :type "pointer"}]
                          :doc "Get the pitch of the given music object. "
                          :impl "lua"
                          :name "music_get_pitch"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Free Sound resources "
                          :impl "lua"
                          :name "sound_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound_path" :type "string"}]
                          :doc "Load the sound specified in the path. "
                          :impl "lua"
                          :name "sound_load"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "orig" :type "pointer"}]
                          :doc "Clone the sound specified in the path. "
                          :impl "lua"
                          :name "sound_clone"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Play the sound. "
                          :impl "lua"
                          :name "sound_play"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Pause the sound. "
                          :impl "lua"
                          :name "sound_pause"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Resume the sound. "
                          :impl "lua"
                          :name "sound_resume"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Stop the sound. "
                          :impl "lua"
                          :name "sound_stop"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Check if the given sound is playing. "
                          :impl "lua"
                          :name "sound_is_playing"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "bool"}]}
                         {:args [{:name "sound" :type "pointer"}
                                 {:name "volume" :type "double"}]
                          :doc "Set the volume of the given sound object. "
                          :impl "lua"
                          :name "sound_set_volume"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}
                                 {:name "pan" :type "double"}]
                          :doc "Set the pan of the given sound object. "
                          :impl "lua"
                          :name "sound_set_pan"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}
                                 {:name "pitch" :type "double"}]
                          :doc "Set the pitch of the given sound object. "
                          :impl "lua"
                          :name "sound_set_pitch"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the volume of the given sound object. "
                          :impl "native"
                          :name "sound_get_volume"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the pan of the given sound object. "
                          :impl "lua"
                          :name "sound_get_pan"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "sound" :type "pointer"}]
                          :doc "Get the pitch of the given sound object. "
                          :impl "lua"
                          :name "sound_get_pitch"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "double"}]}
                         {:args [{:name "file_path" :type "string"}]
                          :doc "Load the file in the path. "
                          :impl "native"
                          :name "load_textfile"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "string"}]}
                         {:args [{:name "file_path" :type "string"}
                                 {:name "data" :type "string"}]
                          :doc "Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. "
                          :impl "native"
                          :name "save_textfile"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "file_path" :type "string"}
                                 {:name "data" :type "string"}]
                          :doc "Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. "
                          :impl "native"
                          :name "save_textfile_append"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Push the transform matrix. "
                          :impl "native"
                          :name "push_matrix"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Pop the transform matrix. "
                          :impl "native"
                          :name "pop_matrix"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the transformation matrix (load identity matrix.) "
                          :impl "native"
                          :name "reset_matrix"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "delta_x" :type "double"}
                                 {:name "delta_y" :type "double"}]
                          :doc "Apply translation (changes transform matrix.) "
                          :impl "native"
                          :name "translate"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "angle" :type "double"}]
                          :doc "Apply rotation (changes transform matrix.) "
                          :impl "native"
                          :name "rotate"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "angle" :type "double"}
                                 {:name "x" :type "double"}
                                 {:name "y" :type "double"}]
                          :doc "Apply rotation at the given location (changes transform matrix.) "
                          :impl "native"
                          :name "rotate_at"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "scale_x" :type "double"}
                                 {:name "scale_y" :type "double"}]
                          :doc "Apply scaling (changes transform matrix.) "
                          :impl "native"
                          :name "scale"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "scale_x" :type "double"}
                                 {:name "scale_y" :type "double"}
                                 {:name "x" :type "double"}
                                 {:name "y" :type "double"}]
                          :doc "Apply scaling at the given location (changes transform matrix.) "
                          :impl "native"
                          :name "scale_at"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "blendmode" :type "BlendMode"}]
                          :doc "Set the default blendmode. "
                          :impl "native"
                          :name "set_default_blendmode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "blendmode" :type "BlendMode"}]
                          :doc "Set the effective blendmode. "
                          :impl "native"
                          :name "set_blendmode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the blendmode value to its default value. "
                          :impl "native"
                          :name "reset_blendmode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "filtermode" :type "FilterMode"}]
                          :doc "Set the default filtermode. "
                          :impl "native"
                          :name "set_default_filtermode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "filtermode" :type "FilterMode"}]
                          :doc "Set the effective filtermode. "
                          :impl "native"
                          :name "set_filtermode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the filtermode value to its default value. "
                          :impl "native"
                          :name "reset_filtermode"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shaderbuilder" :type "pointer"}]
                          :doc "Free ShaderBuilder resources "
                          :impl "lua"
                          :name "shaderbuilder_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Create a ShaderBuilder object. "
                          :impl "lua"
                          :name "shaderbuilder_new"
                          :namespace "lyte_core"
                          :rets [{:name "val" :type "pointer"}]}
                         {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "uniform_name" :type "string"}
                                 {:name "uniform_type" :type "UniformType"}]
                          :doc "Add uniform definition to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_uniform"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "vertex_code" :type "string"}]
                          :doc "Add vertex code to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_vertex"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shaderbuilder" :type "pointer"}
                                 {:name "fragment_code" :type "string"}]
                          :doc "Add fragment to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_fragment"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shaderbuilder" :type "pointer"}]
                          :doc "Add fragment to the shaderbuilder "
                          :impl "lua"
                          :name "shaderbuilder_build"
                          :namespace "lyte_core"
                          :rets [{:name "shader" :type "pointer"}]}
                         {:args [{:name "shader" :type "pointer"}]
                          :doc "Free Shader resources "
                          :impl "lua"
                          :name "shader_cleanup"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shader" :type "pointer"}]
                          :doc "Set the custom shader and use it for consequent calls. "
                          :impl "lua"
                          :name "shader_set"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args {}
                          :doc "Reset the shader, back to framework defaults. "
                          :impl "native"
                          :name "reset_shader"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shader" :type "pointer"}
                                 {:name "uniform_name" :type "string"}
                                 {:name "uniform_value" :type "float"}]
                          :doc "Set the specified uniform. "
                          :impl "lua"
                          :name "shader_set_uniform_float"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shader" :type "pointer"}
                                 {:name "uniform_name" :type "string"}
                                 {:name "uniform_value" :type "FloatVec4"}]
                          :doc "Set the specified uniform. "
                          :impl "lua"
                          :name "shader_set_uniform_floatvec4"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shader" :type "pointer"}
                                 {:name "uniform_name" :type "string"}
                                 {:name "uniform_value" :type "pointer"}]
                          :doc "Set the specified uniform. "
                          :impl "lua"
                          :name "shader_set_uniform_image"
                          :namespace "lyte_core"
                          :rets {}}
                         {:args [{:name "shader" :type "pointer"}
                                 {:name "uniform_name" :type "string"}]
                          :doc "Reset the specified uniform. "
                          :impl "lua"
                          :name "shader_reset_uniform"
                          :namespace "lyte_core"
                          :rets {}}]
             :lists [{:doc "Float values"
                      :item_type "float"
                      :max_count 4
                      :name "FloatVec4"
                      :namespace "lyte_core"}]
             :name "lyte_core"
             :namespaces {}
             :records {}
             :requires {}
             :variants {}}]
 :variants [{:doc "Shader uniform value "
             :name "ShaderUniformValue"
             :namespace "lyte"
             :options [{:doc "Note: Used for single numbers, int or float"
                        :name "float_val"
                        :type "float"}
                       {:name "vec_val" :type "FloatVec4"}
                       {:name "sampler2D_val" :type "Image"}]}]}

