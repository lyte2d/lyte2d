---------------------------------------------------------------------------------------------
-- LYTE API -- source of truth for the API
---------------------------------------------------------------------------------------------

require "lib.apidef"

-- enums

local UniformType = T"UniformType"
local BlendMode = T"BlendMode"
local FilterMode = T"FilterMode"
local GamepadAxis = T"GamepadAxis"
local GamepadButton = T"GamepadButton"
local MouseButton = T"MouseButton"
local KeyboardKey = T"KeyboardKey"


-- pointer types (to be "lightuserdata" in Lua side)

local Image_Ptr = Pointer
local ImageBatch_Ptr = Pointer
local Font_Ptr = Pointer
local Music_Ptr = Pointer
local Sound_Ptr = Pointer
local Shader_Ptr = Pointer
local ShaderBuilder_Ptr = Pointer
local World_Ptr = Pointer
local Body_Ptr = Pointer
local Space_Ptr = Pointer
local JointGroup_Ptr = Pointer
local Geom_Ptr = Pointer
local Joint_Ptr = Pointer


return process_def_tree(Namespace("lyte_core", {
    Doc"lyte_core namespace. Direct API mappings to C library.",

    Function("quit",
        Doc"Quit the application by closing the window."
    ),

    Function("cls",
        Arg("r", Double),
        Arg("g", Double),
        Arg("b", Double),
        Arg("a", Double),
        Doc"Clear the screen or current canvas if one is used."
    ),

    Function("set_color",
        Arg("r", Double),
        Arg("g", Double),
        Arg("b", Double),
        Arg("a", Double),
        Doc"Set the foreground color to be used in the drawing operations."
    ),

    Function("reset_color",
        Doc"Reset the foreground color to its default value."
    ),

    Function("draw_point",
        Arg("x", Double),
        Arg("y", Double),
        Doc"Draw a point."
    ),

    Function("draw_line",
        Arg("x1", Double),
        Arg("y1", Double),
        Arg("x2", Double),
        Arg("y2", Double),
        Doc"Draw a line"
    ),

    Function("draw_triangle",
        Arg("ax", Double),
        Arg("ay", Double),
        Arg("bx", Double),
        Arg("by", Double),
        Arg("cx", Double),
        Arg("cy", Double),
        Doc"Draw a filled triangle"
    ),

    Function("draw_triangle_line",
        Arg("ax", Double),
        Arg("ay", Double),
        Arg("bx", Double),
        Arg("by", Double),
        Arg("cx", Double),
        Arg("cy", Double),
        Doc"Draw a triangle border"
    ),

    Function("draw_rect",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("rect_width", Double),
        Arg("rect_height", Double),
        Doc"Draw a filled rectangle."
    ),

    Function("draw_rect_line",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("rect_width", Double),
        Arg("rect_height", Double),
        Doc"Draw a rectangle border."
    ),

    Function("draw_circle",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("radius", Double),
        Doc"Draw a filled circle."
    ),

    Function("draw_circle_line",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("radius", Double),
        Doc"Draw a circle border."
    ),

    Function("draw_ellipse",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("radius_x", Double),
        Arg("radius_y", Double),
        Doc"Draw a filled ellipse."
    ),

    Function("draw_ellipse_line",
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("radius_x", Double),
        Arg("radius_y", Double),
        Doc"Draw an ellipse border."
    ),

    -- RENAMED
    Function("image_cleanup",
        Arg("image", Image_Ptr),
        Doc("Free Image resources"),
        -- dtor=true
        LuaImpl
    ),

    -- RENAMED
    Function("image_load",
        Arg("image_path", String),
        Ret("val", Image_Ptr),
        Doc"Load the image specified in the path.",
        -- ctor=true
        LuaImpl
    ),

    -- RENAMED
    Function("image_draw",
        Arg("image", Image_Ptr),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Doc"Draw an image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_draw_ex",
        Arg("image", Image_Ptr),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("angle", Double),
        Arg("origin_x", Double),
        Arg("origin_y", Double),
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Doc"Draw an image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_draw_rect",
        Arg("image", Image_Ptr),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("src_x", Double),
        Arg("src_y", Double),
        Arg("src_width", Double),
        Arg("src_height", Double),
        Doc"Draw a rectangular area from the image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_draw_rect_ex",
        Arg("image", Image_Ptr),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("src_x", Double),
        Arg("src_y", Double),
        Arg("src_width", Double),
        Arg("src_height", Double),
        Arg("angle", Double),
        Arg("origin_x", Double),
        Arg("origin_y", Double),
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Doc"Draw a rectangular area from the image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_get_width",
        Arg("image", Image_Ptr),
        Ret("val", Int),
        Doc"Get the width of the image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_get_height",
        Arg("image", Image_Ptr),
        Ret("val", Int),
        Doc"Get the height of the image.",
        LuaImpl
    ),

    -- RENAMED
    Function("image_new_canvas",
        Arg("width", Int),
        Arg("height", Int),
        Ret("val", Image_Ptr),
        Doc"Create a canvas image with given width and height.",
        -- ctor=true
        LuaImpl
    ),

    -- RENAMED
    Function("image_set_canvas",
        Arg("canvas_image", Image_Ptr),
        Doc"Set the effective canvas image. All draw operations will go to this canvas until it's reset.",
        LuaImpl
    ),

    Function("reset_canvas",
        Doc"Reset the drawing target, back to screen."
    ),

    -- RENAMED
    Function("image_is_canvas",
        Arg("image", Image_Ptr),
        Ret("val", Bool),
        Doc"Check if the image was created as a canvas.",
        LuaImpl
    ),

    Function("capture_image",
        Arg("x", Int),
        Arg("y", Int),
        Arg("w", Int),
        Arg("h", Int),
        Ret("val", Image_Ptr),
        -- ctor=true
        Doc("Note: slow. Capture render image. This is a slow operation!")
    ),

    -- RENAMED
    Function("imagebatch_cleanup",
        Arg("imagebatch", ImageBatch_Ptr),
        Doc("Free ImageBatch resources"),
        -- dtor=true
        LuaImpl
    ),

    -- RENAMED
    Function("imagebatch_new",
        Arg("image", Image_Ptr),
        Ret("val", ImageBatch_Ptr),
        Doc"Create an image batch",
        -- ctor=true
        LuaImpl
    ),

    -- RENAMED
    Function("imagebatch_reset",
        Arg("imagebatch", ImageBatch_Ptr),
        Doc"Reset the image batch, remove all added rects.",
        LuaImpl
    ),

    -- RENAMED
    Function("imagebatch_add_rect",
        Arg("imagebatch", ImageBatch_Ptr),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("dest_width", Double),
        Arg("dest_height", Double),
        Arg("src_x", Double),
        Arg("src_y", Double),
        Arg("src_width", Double),
        Arg("src_height", Double),
        Doc"Add a recta to the image batch (from it's initial image).",
        LuaImpl
    ),

    -- RENAMED
    Function("imagebatch_get_rect_count",
        Arg("imagebatch", ImageBatch_Ptr),
        Ret("val", Int),
        Doc"Get the number of rects in the image batch.",
        LuaImpl
    ),

    -- RENAMED
    Function("imagebatch_draw",
        Arg("imagebatch", ImageBatch_Ptr),
        Doc"Draw the image batch.",
        LuaImpl
    ),

    -- RENAMED
    Function("font_cleanup",
        -- dtor=true
        Arg("font", Font_Ptr),
        Doc("Free Font resources"),
        LuaImpl
    ),

    -- RENAMED
    Function("font_load",
        Arg("font_path", String),
        Arg("size", Double),
        Ret("val", Font_Ptr),
        Doc"Load the font specified in the path, and set the initial size.",
        -- ctor=true
        LuaImpl
    ),

    -- RENAMED
    Function("font_set",
        Arg("font", Font_Ptr),
        Doc"Set the effective font to be used in the drawing operations.",
        LuaImpl
    ),

    -- Function("reset_font",
    --     Doc"Reset the font to its default value.",
    --     LuaImpl
    -- ),

    Function("draw_text",
        Arg("text", String),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Doc"Draw a text line."
    ),

    Function("get_text_width",
        Arg("text", String),
        Ret("val", Int),
        Doc"Get the width of the given text line."
    ),

    Function("get_text_height",
        Arg("text", String),
        Ret("val", Int),
        Doc"Get the height of the given text line."
    ),

    Function("get_monitor_count",
        Ret("val", Int),
        Doc"Get the number of currently connected monitors."
    ),

    Function("get_monitor_name",
        Arg("index", Int),
        Ret("val", String),
        Doc"Get the name of the monitor at the index"
    ),

    Function("get_monitor_width",
        Arg("index", Int),
        Ret("val", Int),
        Doc"Get the width of the monitor at the index"
    ),

    Function("get_monitor_height",
        Arg("index", Int),
        Ret("val", Int),
        Doc"Get the height of the monitor at the index"
    ),

    Function("set_window_monitor",
        Arg("index", Int),
        Doc[[ Set the window's initial monitor to the indexed value. Must be set before the window is opened.]]
    ),

    Function("set_window_resizable",
        Arg("resizable", Bool),
        Doc[[ Set the window resizable flag to the given value. Must be set before the window is opened.]]
    ),

    Function("set_window_minsize",
        Arg("width", Int),
        Arg("height", Int),
        Doc"Set the window's minimum possible size."
    ),

    Function("set_window_size",
        Arg("width", Int),
        Arg("height", Int),
        Doc"Set the window's size."
    ),

    Function("get_window_width",
        Ret("val", Int, Doc"Width of the window in pixels"),
        Doc"Get the width of the window."
    ),

    Function("get_window_height",
        Ret("val", Int, Doc"Height of the window in pixels"),
        Doc"Get the height of the window."
    ),

    Function("set_window_position",
        Arg("x", Int),
        Arg("y", Int),
        Doc"Set the window's position."
    ),

    Function("set_fullscreen",
        Arg("fullscreen", Bool),
        Doc"Set the window to fullscreen, or windowed mode."
    ),

    Function("is_fullscreen",
        Ret("val", Bool),
        Doc"Check if the window is set to fullscreen."
    ),

    Function("set_window_title",
        Arg("title", String),
        Doc"Set the window's title."
    ),

    Function("set_window_vsync",
        Arg("vsync", Bool),
        Doc"Set the window vsync flag to the given value."
    ),

    Function("is_window_vsync",
        Ret("val", Bool),
        Doc"Check if the window vsync flag is set."
    ),

    Function("set_window_icon_file",
        Arg("icon_path", String),
        Doc"Set the window icon."
    ),

    Function("set_window_margins",
        Arg("left", Int),
        Arg("right", Int),
        Arg("top", Int),
        Arg("bottom", Int),
        Doc"Set the window margins. Margins are ignored and no drawing can be made there.."
    ),

    Function("set_window_paddings",
        Arg("left", Int),
        Arg("right", Int),
        Arg("top", Int),
        Arg("bottom", Int),
        Doc"Set the window paddings. Paddings are can be drawn on."
    ),

    Function("is_key_down",
        Arg("key", KeyboardKey),
        Ret("val", Bool),
        Doc"Check if the given key is down."
    ),

    Function("is_key_pressed",
        Arg("key", KeyboardKey),
        Ret("val", Bool),
        Doc"Check if the given key is pressed."
    ),

    Function("is_key_released",
        Arg("key", KeyboardKey),
        Ret("val", Bool),
        Doc"Check if the given key is released."
    ),

    Function("is_key_repeat",
        Arg("key", KeyboardKey),
        Ret("val", Bool),
        Doc"Check if the given key is repeated."
    ),

    Function("get_pressed_keys",
        Ret("val", T("KeyList")),
        Doc"Get the list of pressed keys."
    ),

    Function("get_textinput",
        Ret("val", String),
        Doc"Get all keyboard text input from last frame. Output is utf8 encoded."
    ),

    Function("is_mouse_down",
        Arg("mouse_button", MouseButton),
        Ret("val", Bool),
        Doc"Check if the given mouse button is down."
    ),

    Function("is_mouse_pressed",
        Arg("mouse_button", MouseButton),
        Ret("val", Bool),
        Doc"Check if the given mouse button is pressed."
    ),

    Function("is_mouse_released",
        Arg("mouse_button", MouseButton),
        Ret("val", Bool),
        Doc"Check if the given mouse button is released."
    ),

    Function("get_mouse_x",
        Ret("val", Int),
        Doc"Get the mouse x position."
    ),

    Function("get_mouse_y",
        Ret("val", Int),
        Doc"Get the mouse y position."
    ),

    Function("get_gamepad_count",
        Ret("val", Int),
        Doc"Get the number of gamepads."
    ),

    Function("get_gamepad_name",
        Arg("index", Int),
        Ret("val", String),
        Doc"Get the name of the gamepad at the given index."
    ),

    Function("is_gamepad_down",
        Arg("index", Int),
        Arg("gamepad_button", GamepadButton),
        Ret("val", Bool),
        Doc"Check if the given button of the gamepad at the given index is down."
    ),

    Function("is_gamepad_pressed",
        Arg("index", Int),
        Arg("gamepad_button", GamepadButton),
        Ret("val", Bool),
        Doc"Check if the given button of the gamepad at the given index is pressed."
    ),

    Function("is_gamepad_released",
        Arg("index", Int),
        Arg("gamepad_button", GamepadButton),
        Ret("val", Bool),
        Doc"Check if the given button of the gamepad at the given index is released."
    ),

    Function("get_gamepad_axis",
        Arg("index", Int),
        Arg("gamepad_axis", GamepadAxis),
        Ret("val", Double),
        Doc"Get the given axis of the gamepad at the given index."
    ),

    Function("set_mastervolume",
        Arg("mastervolume", Double),
        Doc"Set the master volume."
    ),

    Function("get_mastervolume",
        Ret("val", Double),
        Doc"Get the master volume."
    ),

    -- RENAMED
    Function("music_cleanup",
        Arg("music", Music_Ptr),
        Doc("Free Music resources"),
        -- dtor=true
        LuaImpl
    ),

    -- RENAMED
    Function("music_load",
        Arg("music_path", String),
        Ret("val", Music_Ptr),
        Doc"Load the music specified in the path.",
        -- ctor=true
        LuaImpl
    ),

    -- RENAMED
    Function("music_play",
        Arg("music", Music_Ptr),
        Doc"Play the music.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_pause",
        Arg("music", Music_Ptr),
        Doc"Pause the music.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_resume",
        Arg("music", Music_Ptr),
        Doc"Resume the music.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_stop",
        Arg("music", Music_Ptr),
        Doc"Stop the music.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_is_playing",
        Arg("music", Music_Ptr),
        Ret("val", Bool),
        Doc"Check if the given music is playing.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_get_length",
        Arg("music", Music_Ptr),
        Ret("val", Double),
        Doc"Get the length of the given music object in seconds.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_get_length_played",
        Arg("music", Music_Ptr),
        Ret("val", Double),
        Doc"Get the already played length of the given music object in seconds.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_seek",
        Arg("music", Music_Ptr),
        Arg("secs", Double),
        Doc"Move the music time played to the given value.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_set_volume",
        Arg("music", Music_Ptr),
        Arg("volume", Double),
        Doc"Set the volume of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_set_pan",
        Arg("music", Music_Ptr),
        Arg("pan", Double),
        Doc"Set the pan of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_set_pitch",
        Arg("music", Music_Ptr),
        Arg("pitch", Double),
        Doc"Set the pitch of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_get_volume",
        Arg("music", Music_Ptr),
        Ret("val", Double),
        Doc"Get the volume of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_get_pan",
        Arg("music", Music_Ptr),
        Ret("val", Double),
        Doc"Get the pan of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("music_get_pitch",
        Arg("music", Music_Ptr),
        Ret("val", Double),
        Doc"Get the pitch of the given music object.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_cleanup",
        Arg("sound", Sound_Ptr),
        Doc("Free Sound resources"),
        -- dtor=true
        LuaImpl
    ),

    -- RENAMED
    Function("sound_load",
        Arg("sound_path", String),
        Ret("val", Sound_Ptr),
        Doc"Load the sound specified in the path.",
        -- ctor=true,
        LuaImpl
    ),

    -- RENAMED
    Function("sound_clone",
        Arg("orig", Sound_Ptr),
        Ret("val", Sound_Ptr),
        Doc"Clone the sound specified in the path.",
        -- ctor=true,
        LuaImpl
    ),

    -- RENAMED
    Function("sound_play",
        Arg("sound", Sound_Ptr),
        Doc"Play the sound.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_pause",
        Arg("sound", Sound_Ptr),
        Doc"Pause the sound.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_resume",
        Arg("sound", Sound_Ptr),
        Doc"Resume the sound.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_stop",
        Arg("sound", Sound_Ptr),
        Doc"Stop the sound.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_is_playing",
        Arg("sound", Sound_Ptr),
        Ret("val", Bool),
        Doc"Check if the given sound is playing.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_set_volume",
        Arg("sound", Sound_Ptr),
        Arg("volume", Double),
        Doc"Set the volume of the given sound object.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_set_pan",
        Arg("sound", Sound_Ptr),
        Arg("pan", Double),
        Doc"Set the pan of the given sound object.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_set_pitch",
        Arg("sound", Sound_Ptr),
        Arg("pitch", Double),
        Doc"Set the pitch of the given sound object.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_get_volume",
        Arg("sound", Sound_Ptr),
        Ret("val", Double),
        Doc"Get the volume of the given sound object."
    ),

    -- RENAMED
    Function("sound_get_pan",
        Arg("sound", Sound_Ptr),
        Ret("val", Double),
        Doc"Get the pan of the given sound object.",
        LuaImpl
    ),

    -- RENAMED
    Function("sound_get_pitch",
        Arg("sound", Sound_Ptr),
        Ret("val", Double),
        Doc"Get the pitch of the given sound object.",
        LuaImpl
    ),

    Function("load_textfile",
        Arg("file_path", String),
        Ret("val", String),
        Doc"Load the file in the path."
    ),

    Function("save_textfile",
        Arg("file_path", String),
        Arg("data", String),
        Doc"Append the text to the file in the path. Override if the file exists. Create if it doesn't exist."
    ),

    Function("save_textfile_append",
        Arg("file_path", String),
        Arg("data", String),
        Doc"Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist."
    ),

    Function("push_matrix",
        Doc"Push the transform matrix."
    ),

    Function("pop_matrix",
        Doc"Pop the transform matrix."
    ),

    Function("reset_matrix",
        Doc"Reset the transformation matrix (load identity matrix.)"
    ),

    Function("translate",
        Arg("delta_x", Double),
        Arg("delta_y", Double),
        Doc"Apply translation (changes transform matrix.)"
    ),

    Function("rotate",
        Arg("angle", Double),
        Doc"Apply rotation (changes transform matrix.)"
    ),

    Function("rotate_at",
        Arg("angle", Double),
        Arg("x", Double),
        Arg("y", Double),
        Doc"Apply rotation at the given location (changes transform matrix.)"
    ),

    Function("scale",
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Doc"Apply scaling (changes transform matrix.)"
    ),

    Function("scale_at",
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Arg("x", Double),
        Arg("y", Double),
        Doc"Apply scaling at the given location (changes transform matrix.)"
    ),

    Function("set_default_blendmode",
        Arg("blendmode", BlendMode),
        Doc"Set the default blendmode."
    ),

    Function("set_blendmode",
        Arg("blendmode", BlendMode),
        Doc"Set the effective blendmode."
    ),

    Function("reset_blendmode",
        Doc"Reset the blendmode value to its default value."
    ),

    Function("set_default_filtermode",
        Arg("filtermode", FilterMode),
        Doc"Set the default filtermode."
    ),

    Function("set_filtermode",
        Arg("filtermode", FilterMode),
        Doc"Set the effective filtermode."
    ),

    Function("reset_filtermode",
        Doc"Reset the filtermode value to its default value."
    ),

    -- RENAMED
    Function("shaderbuilder_cleanup",
        Arg("shaderbuilder", ShaderBuilder_Ptr),
        Doc("Free ShaderBuilder resources"),
        -- dtor=true
        LuaImpl
    ),

    -- RENAMED
    Function("shaderbuilder_new",
        Ret("val", ShaderBuilder_Ptr),
        Doc"Create a ShaderBuilder object.",
        -- ctor=true,
        LuaImpl
    ),

    Function("shaderbuilder_uniform",
        Arg("shaderbuilder", ShaderBuilder_Ptr),
        Arg("uniform_name", String),
        Arg("uniform_type", UniformType),
        Doc"Add uniform definition to the shaderbuilder",
        LuaImpl
    ),

    Function("shaderbuilder_vertex",
        Arg("shaderbuilder", ShaderBuilder_Ptr),
        Arg("vertex_code", String),
        Doc"Add vertex code to the shaderbuilder",
        LuaImpl
    ),

    Function("shaderbuilder_fragment",
        Arg("shaderbuilder", ShaderBuilder_Ptr),
        Arg("fragment_code", String),
        Doc"Add fragment to the shaderbuilder",
        LuaImpl
    ),

    Function("shaderbuilder_build",
        Arg("shaderbuilder", ShaderBuilder_Ptr),
        Ret("shader", Shader_Ptr),
        Doc"Add fragment to the shaderbuilder",
        -- ctor="true"
        LuaImpl
    ),

    -- RENAMED
    Function("shader_cleanup",
        Arg("shader", Shader_Ptr),
        Doc("Free Shader resources"),
        -- dtor=true
        LuaImpl
    ),

    -- -- this is lua only API
    -- Function("shader_new",
    --     Arg("shaderdef", T("ShaderDef")),
    --     Ret("val", Shader_Ptr),
    --     Doc"Create a shader with given specification.",
    --     -- ctor=true,
    --     LuaImpl
    -- ),

    -- RENAMED
    Function("shader_set",
        Arg("shader", Shader_Ptr),
        Doc"Set the custom shader and use it for consequent calls.",
        LuaImpl
    ),

    Function("reset_shader",
        Doc"Reset the shader, back to framework defaults."
    ),

    -- -- TODO: this will go away. three new ones will come
    -- -- RENAMED
    -- Function("shader_set_uniform",
    --     Arg("shader", Shader_Ptr),
    --     Arg("uniform_name", String),
    --     Arg("uniform_value", T("ShaderUniformValue")),
    --     Doc"Set the specified uniform.",
    --     LuaImpl
    -- ),

    -- RENAMED (NEW)
    Function("shader_set_uniform_float",
        Arg("shader", Shader_Ptr),
        Arg("uniform_name", String),
        Arg("uniform_value", Float),
        Doc"Set the specified uniform.",
        LuaImpl
    ),
    -- RENAMED (NEW)
    Function("shader_set_uniform_floatvec4",
        Arg("shader", Shader_Ptr),
        Arg("uniform_name", String),
        Arg("uniform_value", T("FloatVec4")),
        Doc"Set the specified uniform.",
        LuaImpl
    ),
    -- RENAMED (NEW)
    Function("shader_set_uniform_image",
        Arg("shader", Shader_Ptr),
        Arg("uniform_name", String),
        Arg("uniform_value", Image_Ptr),
        Doc"Set the specified uniform.",
        LuaImpl
    ),

    -- RENAMED
    Function("shader_reset_uniform",
        Arg("shader", Shader_Ptr),
        Arg("uniform_name", String),
        Doc"Reset the specified uniform.",
        LuaImpl
    ),

--[==[

    Function("world_new",
        Ret("val", World_Ptr),
        Doc"Create a new physics world."
    ),

    Function("world_cleanup",
        Arg("world", World_Ptr),
        Doc"Cleanup (delete) world and all contained objects."
    ),

    Function("world_set_gravity",
        Arg("world", World_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set worlds gravity values. By default, gravity is (0, 0).")
    ),

    Function("world_update",
        Arg("world", World_Ptr),
        Arg("step_size", Double),
        Doc("Update world.")
    ),


    Function("body_new",
        Arg("world", World_Ptr),
        Ret("val", Body_Ptr),
        Doc"Create a new physics body."
    ),

    Function("body_cleanup",
        Arg("body", Body_Ptr),
        Doc"Cleanup (delete) a body."
    ),

    Function("body_set_position",
        Arg("body", Body_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set body's position.")
    ),

    Function("body_get_position",
        Arg("body", Body_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get body's position.")
    ),

    Function("body_set_rotation",
        Arg("body", Body_Ptr),
        Arg("angle", Double),
        Doc("Set body's rotation (angle).")
    ),

    Function("body_get_rotation",
        Arg("body", Body_Ptr),
        Ret("angle", Double),
        Doc("Get body's rotation (angle).")
    ),

    Function("body_set_linear_vel",
        Arg("body", Body_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set body's linear velocity.")
    ),

    Function("body_get_linear_vel",
        Arg("body", Body_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get body's linear velocity.")
    ),

    Function("body_set_angular_vel",
        Arg("body", Body_Ptr),
        Arg("z", Double),
        Doc("Set body's angular velocity.")
    ),

    Function("body_get_angular_vel",
        Arg("body", Body_Ptr),
        Ret("z", Double),
        Doc("Get body's angular velocity.")
    ),

    Function("body_set_mass_circle",
        Arg("body", Body_Ptr),
        Arg("mass", Double),
        Arg("radius", Double),
        Doc("Set body's (circular) mass.")
    ),

    Function("body_set_mass_rect",
        Arg("body", Body_Ptr),
        Arg("mass", Double),
        Arg("width", Double),
        Arg("height", Double),
        Doc("Set body's (rectangular) mass.")
    ),

    Function("body_add_force",
        Arg("body", Body_Ptr),
        Arg("fx", Double),
        Arg("fy", Double),
        Doc("Add force to body.")
    ),

    Function("body_get_force",
        Arg("body", Body_Ptr),
        Ret("fx", Double),
        Ret("fy", Double),
        Doc("Get body's linear .")
    ),

    Function("body_add_torque",
        Arg("body", Body_Ptr),
        Arg("fz", Double),
        Doc("Add torque to body.")
    ),

    Function("body_get_torque",
        Arg("body", Body_Ptr),
        Ret("fz", Double),
        Doc("Get body's torque.")
    ),

    Function("body_set_kinematic",
        Arg("body", Body_Ptr),
        Arg("val", Bool),
        Doc("Set body as 'kinematic'. False by default.")
    ),

    Function("body_is_kinematic",
        Arg("body", Body_Ptr),
        Ret("val", Bool),
        Doc("Is body set as 'kinematic'? False by default.")
    ),

    Function("space_new",
        Ret("val", Space_Ptr),
        Doc("Create a new Space for collisions")
    ),

    Function("space_cleanup",
        Arg("space", Space_Ptr),
        Doc("Cleanup the Space (delete).")
    ),

    Function("jointgroup_new",
        Ret("val", JointGroup_Ptr),
        Doc("Create a new JointGroup.")
    ),

    Function("jointgroup_cleanup",
        Arg("jointgroup", JointGroup_Ptr),
        Doc("Cleanup the JointGroup (delete).")
    ),

    Function("coll_update_check",
        Arg("world", World_Ptr),
        Arg("space", Space_Ptr),
        Arg("jointgroup", JointGroup_Ptr),
        Doc("Check collisions for current frame")
    ),

    Function("coll_update_correct",
        Arg("space", Space_Ptr),
        Doc("Correct angular drift for 2D")
    ),

    Function("body_get_collision_count",
        Arg("body", Body_Ptr),
        Ret("count", Int),
        Doc("Get the number of collisions for this body.")
    ),

    Function("body_get_collision_data_at",
        Arg("body", Body_Ptr),
        Arg("index", Int),
        Ret("body2", Body_Ptr),
        Ret("pos_x", Double),
        Ret("pos_y", Double),
        Ret("depth", Double),
        Doc("Get the data of for collision for this body at given index. Indexes start with 0.")
    ),

    Function("joint_cleanup",
        Arg("joint", Joint_Ptr),
        Doc("Cleanup (delete) given joint.")
    ),

    Function("joint_is_hinge",
        Arg("joint", Joint_Ptr),
        Ret("val", Bool),
        Doc("Check if the Joint is of class 'hinge'.")
    ),

    Function("joint_is_slider",
        Arg("joint", Joint_Ptr),
        Ret("val", Bool),
        Doc("Check if the Joint is of class 'slider'.")
    ),

    Function("joint_is_fixed",
        Arg("joint", Joint_Ptr),
        Ret("val", Bool),
        Doc("Check if the Joint is of class 'fixed'.")
    ),

    Function("joint_get_body",
        Arg("joint", Joint_Ptr),
        Arg("index", Int),
        Ret("body", Body_Ptr),
        Doc("Get the body at 'index' for the given joint.")
    ),

    Function("joint_attach",
        Arg("joint", Joint_Ptr),
        Arg("body1", Body_Ptr),
        Arg("body2", Body_Ptr),
        Doc("Attach the given bodies with the joint.")
    ),

    Function("joint_attach_one",
        Arg("joint", Joint_Ptr),
        Arg("body", Body_Ptr),
        Doc("Attach the given body with to the 'world'.")
    ),

    Function("joint_new_hinge",
        Arg("world", World_Ptr),
        Arg("jointgroup", JointGroup_Ptr),
        Ret("joint", Joint_Ptr),
        Doc("Create a new Joint of class 'hinge'.")
    ),

    Function("joint_new_slider",
        Arg("world", World_Ptr),
        Arg("jointgroup", JointGroup_Ptr),
        Ret("joint", Joint_Ptr),
        Doc("Create a new Joint of class 'slider'.")
    ),

    Function("joint_new_fixed",
        Arg("world", World_Ptr),
        Arg("jointgroup", JointGroup_Ptr),
        Ret("joint", Joint_Ptr),
        Doc("Create a new Joint of class 'fixed'.")
    ),

    Function("joint_set_hinge_anchor",
        Arg("joint", Joint_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set the anchor location for the given hinge joint.")
    ),

    Function("joint_get_hinge_anchor1",
        Arg("joint", Joint_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get the anchor location for the given hinge joint. From body1. Should be the same for body2.")
    ),

    Function("joint_get_hinge_anchor2",
        Arg("joint", Joint_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get the anchor location for the given hinge joint. From body2. Should be the same for body1.")
    ),

    Function("joint_get_hinge_angle",
        Arg("joint", Joint_Ptr),
        Ret("angle", Double),
        Doc("Get the angle or the given hinge joint.")
    ),

    Function("joint_get_hinge_angle_rate",
        Arg("joint", Joint_Ptr),
        Ret("anglerate", Double),
        Doc("Get the angle rate for the given hinge joint.")
    ),

    Function("joint_set_slider_axis",
        Arg("joint", Joint_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set the axis for the given slider joint.")
    ),

    Function("joint_get_slider_axis",
        Arg("joint", Joint_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get the axis for the given slider joint.")
    ),

    Function("joint_get_slider_position",
        Arg("joint", Joint_Ptr),
        Ret("pos", Double),
        Doc("Get the slider position for the given slider joint.")
    ),

    Function("joint_get_slider_position_rate",
        Arg("joint", Joint_Ptr),
        Ret("posrate", Double),
        Doc("Get the slider position rate for the given slider joint.")
    ),

    Function("joint_set_fixed",
        Arg("joint", Joint_Ptr),
        Doc("Set the joint as 'fixed'.")
    ),

    Function("geom_cleanup",
        Arg("geom", Geom_Ptr),
        Doc("Cleanup the Geom (delete).")
    ),

    Function("geom_new_circle",
        Arg("space", Space_Ptr),
        Arg("radius", Double),
        Ret("geom", Geom_Ptr),
        Doc("Create a new Geom (for collision).")
    ),

    Function("geom_new_rect",
        Arg("space", Space_Ptr),
        Arg("width", Double),
        Arg("height", Double),
        Ret("geom", Geom_Ptr),
        Doc("Create a new Geom (for collision).")
    ),

    Function("geom_is_circle",
        Arg("geom", Geom_Ptr),
        Ret("val", Bool),
        Doc("Is the Geom a 'circle'?")
    ),

    Function("geom_is_rect",
        Arg("geom", Geom_Ptr),
        Ret("val", Bool),
        Doc("Is the Geom a 'rect'?")
    ),

    Function("geom_set_circle_radius",
        Arg("geom", Geom_Ptr),
        Arg("radius", Double),
        Doc("Set the Geom's (circle) radius.")
    ),

    Function("geom_get_circle_radius",
        Arg("geom", Geom_Ptr),
        Ret("radius", Double),
        Doc("Get the Geom's (circle) radius.")
    ),

    Function("geom_set_rect_size",
        Arg("geom", Geom_Ptr),
        Arg("width", Double),
        Arg("height", Double),
        Doc("Set the Geom's (rect) width and height.")
    ),

    Function("geom_get_rect_size",
        Arg("geom", Geom_Ptr),
        Ret("width", Double),
        Ret("height", Double),
        Doc("Get the Geom's (rect) width and height.")
    ),

    Function("geom_get_circle_point_depth",
        Arg("geom", Geom_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Ret("depth", Double),
        Doc("Get the depth of the point in Geom's (circle). Positive inside, Negative outside, Zero on the surface.")
    ),

    Function("geom_get_rect_point_depth",
        Arg("geom", Geom_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Ret("depth", Double),
        Doc("Get the depth of the point in Geom's (rect). Positive inside, Negative outside, Zero on the surface.")
    ),

    Function("geom_get_AABB",
        Arg("geom", Geom_Ptr),
        Ret("minx", Double),
        Ret("miny", Double),
        Ret("maxx", Double),
        Ret("maxy", Double),
        Doc("Get the AABB rectangle coord associated with the Geom.")
    ),

    Function("geom_set_body",
        Arg("geom", Geom_Ptr),
        Arg("body", Body_Ptr),
        Doc("Set a Geom for the Body.")
    ),

    Function("geom_get_body",
        Arg("geom", Geom_Ptr),
        Ret("body", Body_Ptr),
        Doc("Get the Body associated with the Geom.")
    ),


    Function("geom_set_position",
        Arg("geom", Geom_Ptr),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set geom's position.")
    ),

    Function("geom_get_position",
        Arg("geom", Geom_Ptr),
        Ret("x", Double),
        Ret("y", Double),
        Doc("Get geom's position.")
    ),

    Function("geom_set_rotation",
        Arg("geom", Geom_Ptr),
        Arg("angle", Double),
        Doc("Set geom's rotation (angle).")
    ),

    Function("geom_get_rotation",
        Arg("geom", Geom_Ptr),
        Ret("angle", Double),
        Doc("Get geom's rotation (angle).")
    ),




    -- TODO: offset position and rotation (available in lyte_core)

    Function("geom_set_category_bit",
        Arg("geom", Geom_Ptr),
        Arg("category_bit", Int),
        Doc("Set the category bit for the Geom. Between 0 and 63.")
    ),

    Function("geom_is_category_bit_set",
        Arg("geom", Geom_Ptr),
        Arg("category_bit", Int),
        Ret("val", Bool),
        Doc("Is the category bit associated with the Geom? (Between 0 and 63.)")
    ),

    Function("geom_set_collide_bit",
        Arg("geom", Geom_Ptr),
        Arg("collide_bit", Int),
        Doc("Set the collide bit for the Geom. Between 0 and 63.")
    ),

    Function("geom_is_collide_bit_set",
        Arg("geom", Geom_Ptr),
        Arg("collide_bit", Int),
        Ret("val", Bool),
        Doc("Is the collide bit associated with the Geom? (Between 0 and 63.)")
    ),

--]==]

    List("FloatVec4",
        Float,
        MaxCount(4),
        Doc"Float values"
    ),

    List("KeyList",
        T("KeyboardKey"),
        MaxCount(16),
        Doc"List of keys"
    ),

    Enum("UniformType",
        '_invalid', 'float', 'vec2', 'vec3', 'vec4', 'int', 'ivec2',
        'ivec3', 'ivec4', 'mat4', 'sampler2D',
        Doc"Acceptable uniformtype values."
    ),

    Enum("BlendMode",
        'none' , 'blend' , 'add' , 'mod' , 'mul',
        Doc"Acceptable blendmode values."
    ),

    Enum("FilterMode",
        '_invalid', 'nearest', 'linear',
        Doc"Acceptable filtermode values."
    ),

    Enum("GamepadAxis",
        'left_x', 'left_y', 'right_x', 'right_y', 'left_trigger', 'right_trigger',
        Doc"Acceptable gamepadaxis values."
    ),

    Enum("GamepadButton",
        'pad_a', 'pad_b', 'pad_x', 'pad_y', 'left_bumper', 'right_bumper',
        'back', 'start', 'guide', 'left_thumb', 'right_thumb', 'dpad_up',
        'dpad_right', 'dpad_down', 'dpad_left',
        Doc"Acceptable gamepadbutton values."
    ),

    Enum("MouseButton",
        'mb1', 'mb2', 'mb3', 'mb4', 'mb5', 'mb6',
        'mb7', 'mb8', 'scrollup', 'scrolldown',
        Doc"Acceptable mousebutton values."
    ),

    Enum("KeyboardKey",
        {
            'space', "'", ',', '-', '.', '/',
            '0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', ';', '=',
            'a', 'b', 'c', 'd', 'e', 'f',
            'g', 'h', 'i', 'j', 'k', 'l',
            'm', 'n', 'o', 'p', 'q', 'r',
            's', 't', 'u', 'v', 'w', 'x',
            'y', 'z', '[', '\\', ']', '`',
            'world_1', 'world_2', 'escape', 'enter', 'tab', 'backspace',
            'insert', 'delete', 'right', 'left', 'down', 'up',
            'page_up', 'page_down', 'home', 'end', 'caps_lock', 'scroll_lock',
            'num_lock', 'print_screen', 'pause', 'f1', 'f2', 'f3',
            'f4', 'f5', 'f6', 'f7', 'f8', 'f9',
            'f10', 'f11', 'f12', 'f13', 'f14', 'f15',
            'f16', 'f17', 'f18', 'f19', 'f20', 'f21',
            'f22', 'f23', 'f24', 'f25', 'kp_0', 'kp_1',
            'kp_2', 'kp_3', 'kp_4', 'kp_5', 'kp_6', 'kp_7',
            'kp_8', 'kp_9', 'kp_decimal', 'kp_divide', 'kp_multiply', 'kp_subtract',
            'kp_add', 'kp_enter', 'kp_equal', 'left_shift', 'left_control', 'left_alt',
            'left_super', 'right_shift', 'right_control', 'right_alt', 'right_super', 'menu',
            Doc"Acceptable keyboardkey values."
        }
    )

}))
