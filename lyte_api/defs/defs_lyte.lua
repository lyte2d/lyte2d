---------------------------------------------------------------------------------------------
-- LYTE API -- source of truth for the API
---------------------------------------------------------------------------------------------

local apidef = require "lib.apidef"

local String = apidef.String
local Integer = apidef.Integer
local Float = apidef.Float
local Number = apidef.Number
local Boolean = apidef.Boolean
local Nil = apidef.Nil
local Defined = apidef.Defined
local Record = apidef.Record
local Namespace = apidef.Namespace
local Field = apidef.Field
local Variant = apidef.Variant
local Option = apidef.Option
local Enum = apidef.Enum
local Dict = apidef.Dict
local List = apidef.List
local Tuple = apidef.Tuple
local Function = apidef.Function
local Method = apidef.Method
local Arg = apidef.Arg
local Ret = apidef.Ret

---------------------------------------------------------------------------------------------
-- Definitions
---------------------------------------------------------------------------------------------

local lyte_namespace = Namespace("lyte", {


    --------------------
    -- Tuple("TF4", Float(), 4, {d="Tuple of floats"}),
    -- List("VF8", Float(), {d="List of floats", max_count=8}),
    -- Function("testtest", {
    --     -- Arg("test1arg", Defined("VF8")),
    --     Arg("test2arg", Defined("TF4")),
    -- }, {
    --     -- Ret("test1ret", Defined("VF8")),
    --     -- Ret("test2ret", Defined("TF4")),
    -- }, {d="apidef test func. remove"}),
    --------------------

    Function("tick", {
        Arg("delta_time", Number(), {optional=true, default=0.0}),
        Arg("window_width", Integer(), {optional=true, default=0.0}),
        Arg("window_height", Integer(), {optional=true, default=0.0}),
        Arg("window_resized", Boolean(), {optional=true, default=false}),
    }, nil, {d="Tick function. Should be created by the user.", c_api_skip=true}),

    Function("quit", nil, nil, {d="Quit the application by closing the window."}),

    Function("cls", {
        Arg("r", Number()),
        Arg("g", Number()),
        Arg("b", Number()),
        Arg("a", Number()),
    }, nil, {d="Clear the screen or current canvas if one is used."}),

    Function("set_color", {
        Arg("r", Number()),
        Arg("g", Number()),
        Arg("b", Number()),
        Arg("a", Number()),
    }, nil, {d="Set the foreground color to be used in the drawing operations."}),

    Function("reset_color", nil, nil, {d="Reset the foreground color to its default value."}),

    Function("draw_point", {
        Arg("x", Integer()),
        Arg("y", Integer()),
    }, nil, {d="Draw a point."}),

    Function("draw_line", {
        Arg("x1", Integer()),
        Arg("y1", Integer()),
        Arg("x2", Integer()),
        Arg("y2", Integer()),
    }, nil, {d="Draw a line"}),

    Function("draw_rect", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a filled rectangle."}),

    Function("draw_rect_line", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a rectangle border."}),

    Function("draw_circle", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("radius", Integer()),
    }, nil, {d="Draw a filled circle."}),

    Function("draw_circle_line", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("radius", Integer()),
    }, nil, {d="Draw a circle border."}),

    Function("load_image", {
        Arg("image_path", String()),
    },{
        Ret("val", Defined("Image")),
    }, {d="Load the image specified in the path.", ctor=true}),

    Function("draw_image", {
        Arg("image", Defined("Image")),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
    }, nil, {d="Draw an image."}),

    Function("draw_image_rect", {
        Arg("image", Defined("Image")),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("src_x", Integer()),
        Arg("src_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a rectangular area from the image."}),

    Function("get_image_width", {
        Arg("image", Defined("Image")),
    }, {
        Ret("val", Integer()),
    }, {d="Get the width of the image."}),

    Function("get_image_height",  {
        Arg("image", Defined("Image")),
    }, {
        Ret("val", Integer()),
    }, {d="Get the height of the image."}),

    Function("new_canvas", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    },{
        Ret("val", Defined("Image")),
    }, {d="Create a canvas image with given width and height.", ctor=true}),

    Function("set_canvas", {
        Arg("canvas_image", Defined("Image"), {save_to_registry=true}), -- TODO: save_to_registry
    }, nil, {d="Set the effective canvas image. All draw operations will go to this canvas until it's reset."}),

    Function("reset_canvas", nil, nil, {d="Reset the drawing target, back to screen."}),

    Function("is_image_canvas",  {
        Arg("image", Defined("Image")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the image was created as a canvas."}),

    Function("load_font", {
        Arg("font_path", String()),
        Arg("size", Number()),
    },{
        Ret("val", Defined("Font")),
    }, {d="Load the font specified in the path, and set the initial size.", ctor=true}),

    Function("set_font", {
        Arg("font", Defined("Font"), {nativetype="udata", save_to_registry=true}), -- TODO: save_to_registry
    }, nil, {d="Set the effective font to be used in the drawing operations."}),

    Function("reset_font", nil, nil, {d="Reset the font to its default value.", c_api_skip=true}),

    Function("draw_text", {
        Arg("text", String()),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
    }, nil, {d="Draw a text line."}),

    Function("get_text_width", {
        Arg("text", String()),
    }, {
        Ret("val", Integer()),
    }, {d="Get the width of the given text line."}),

    Function("get_text_height", {
        Arg("text", String()),
    }, {
        Ret("val", Integer()),
    }, {d="Get the height of the given text line."}),

    Function("set_window_minsize", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    }, nil, {d="Set the window's minimum possible size."}),

    Function("set_window_size", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    }, nil, {d="Set the window's size."}),

    Function("get_window_width", nil, {
        Ret("val", Integer()),
    }, {d="Get the width of the window."}),

    Function("get_window_height", nil, {
        Ret("val", Integer()),
    }, {d="Get the height of the window."}),

    Function("set_fullscreen", {
        Arg("fullscreen", Boolean()),
    }, nil, {d="Set the window to fullscreen, or windowed mode."}),

    Function("is_fullscreen", nil, {
        Ret("val", Boolean()),
    }, {d="Check if the window is set to fullscreen."}),

    Function("set_window_title", {
        Arg("title", String()),
    }, nil, {d="Set the window's title."}),

    Function("set_window_vsync", {
        Arg("vsync", Boolean()),
    }, nil, {d="Set the window vsync flag to the given value."}),

    Function("is_window_vsync", nil , {
        Ret("val", Boolean()),
    }, {d="Check if the window vsync flag is set."}),

    Function("set_window_icon_file", {
        Arg("icon_path", String()),
    }, nil, {d="Set the window icon."}),

    Function("set_window_margins", {
        Arg("left", Integer()),
        Arg("right", Integer()),
        Arg("top", Integer()),
        Arg("bottom", Integer()),
    }, nil, {d="Set the window margins. Margins are ignored and no drawing can be made there.."}),

    Function("set_window_paddings", {
        Arg("left", Integer()),
        Arg("right", Integer()),
        Arg("top", Integer()),
        Arg("bottom", Integer()),
    }, nil, {d="Set the window paddings. Paddings are can be drawn on."}),

    Function("is_key_down", {
        Arg("key", Defined("KeyboardKey")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is down."}),

    Function("is_key_pressed", {
        Arg("key", Defined("KeyboardKey")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is pressed."}),

    Function("is_key_released", {
        Arg("key", Defined("KeyboardKey")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is released."}),

    Function("is_key_repeat", {
        Arg("key", Defined("KeyboardKey")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is repeated."}),

    Function("is_mouse_down", {
        Arg("mouse_button", Defined("MouseButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is down."}),

    Function("is_mouse_pressed", {
        Arg("mouse_button", Defined("MouseButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is pressed."}),

    Function("is_mouse_released", {
        Arg("mouse_button", Defined("MouseButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is released."}),

    Function("get_mouse_x", nil, {
        Ret("val", Integer()),
    }, {d="Get the mouse x position."}),

    Function("get_mouse_y", nil, {
        Ret("val", Integer()),
    }, {d="Get the mouse y position."}),

    Function("get_gamepad_count", nil, {
        Ret("val", Integer()),
    }, {d="Get the number of gamepads."}),

    Function("get_gamepad_name", {
        Arg("index", Integer()),
    }, {
        Ret("val", String()),
    }, {d="Get the name of the gamepad at the given index."}),

    Function("is_gamepad_down", {
        Arg("index", Integer()),
        Arg("gamepad_button", Defined("GamepadButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is down."}),

    Function("is_gamepad_pressed", {
        Arg("index", Integer()),
        Arg("gamepad_button", Defined("GamepadButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is pressed."}),

    Function("is_gamepad_released", {
        Arg("index", Integer()),
        Arg("gamepad_button", Defined("GamepadButton")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is released."}),

    Function("get_gamepad_axis", {
        Arg("index", Integer()),
        Arg("gamepad_axis", Defined("GamepadAxis")),
    }, {
        Ret("val", Number()),
    }, {d="Get the given axis of the gamepad at the given index."}),

    Function("set_mastervolume", {
        Arg("mastervolume", Number()),
    }, nil, {d="Set the master volume."}),

    Function("get_mastervolume", nil, {
        Ret("val", Number()),
    }, {d="Get the master volume."}),

    Function("load_music", {
        Arg("music_path", String()),
    },{
        Ret("val", Defined("Music")),
    }, {d="Load the music specified in the path.", ctor=true}),

    Function("play_music", {
        Arg("music", Defined("Music")), -- TODO: save to registry??
    }, nil, {d="Play the music."}),

    Function("pause_music", {
        Arg("music", Defined("Music")),
    }, nil, {d="Pause the music."}),

    Function("resume_music", {
        Arg("music", Defined("Music")),
    }, nil, {d="Resume the music."}),

    Function("stop_music", {
        Arg("music", Defined("Music")),
    }, nil, {d="Stop the music."}),

    Function("is_music_playing", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given music is playing."}),

    Function("get_music_length", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Number()),
    }, {d="Get the length of the given music object in seconds."}),

    Function("get_music_length_played", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Number()),
    }, {d="Get the already played length of the given music object in seconds."}),

    Function("seek_music", {
        Arg("music", Defined("Music")),
        Arg("secs", Number()),
    }, nil, {d="Move the music time played to the given value."}),

    Function("set_music_volume", {
        Arg("music", Defined("Music")),
        Arg("volume", Number()),
    }, nil, {d="Set the volume of the given music object."}),

    Function("set_music_pan", {
        Arg("music", Defined("Music")),
        Arg("pan", Number()),
    }, nil, {d="Set the pan of the given music object."}),

    Function("set_music_pitch", {
        Arg("music", Defined("Music")),
        Arg("pitch", Number()),
    }, nil, {d="Set the pitch of the given music object."}),

    Function("get_music_volume", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Number()),
    }, {d="Get the volume of the given music object."}),

    Function("get_music_pan", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Number()),
    }, {d="Get the pan of the given music object."}),

    Function("get_music_pitch", {
        Arg("music", Defined("Music")),
    }, {
        Ret("val", Number()),
    }, {d="Get the pitch of the given music object."}),

    Function("load_sound", {
        Arg("sound_path", String()),
    },{
        Ret("val", Defined("Sound")),
    }, {d="Load the sound specified in the path.", ctor=true}),

    Function("clone_sound", {
        Arg("orig", Defined("Sound")),
    },{
        Ret("val", Defined("Sound")),
    }, {d="Clone the sound specified in the path.", ctor=true}),

    Function("play_sound", {
        Arg("sound", Defined("Sound")),
    }, nil, {d="Play the sound."}),

    Function("pause_sound", {
        Arg("sound", Defined("Sound")),
    }, nil, {d="Pause the sound."}),

    Function("resume_sound", {
        Arg("sound", Defined("Sound")),
    }, nil, {d="Resume the sound."}),

    Function("stop_sound", {
        Arg("sound", Defined("Sound")),
    }, nil, {d="Stop the sound."}),

    Function("is_sound_playing", {
        Arg("sound", Defined("Sound")),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given sound is playing."}),

    Function("set_sound_volume", {
        Arg("sound", Defined("Sound")),
        Arg("volume", Number()),
    }, nil, {d="Set the volume of the given sound object."}),

    Function("set_sound_pan", {
        Arg("sound", Defined("Sound")),
        Arg("pan", Number()),
    }, nil, {d="Set the pan of the given sound object."}),

    Function("set_sound_pitch", {
        Arg("sound", Defined("Sound")),
        Arg("pitch", Number()),
    }, nil, {d="Set the pitch of the given sound object."}),

    Function("get_sound_volume", {
        Arg("sound", Defined("Sound")),
    }, {
        Ret("val", Number()),
    }, {d="Get the volume of the given sound object."}),

    Function("get_sound_pan", {
        Arg("sound", Defined("Sound")),
    }, {
        Ret("val", Number()),
    }, {d="Get the pan of the given sound object."}),

    Function("get_sound_pitch", {
        Arg("sound", Defined("Sound")),
    }, {
        Ret("val", Number()),
    }, {d="Get the pitch of the given sound object."}),

    Function("load_textfile", {
        Arg("file_path", String()),
    },{
        Ret("val", String()),
    },{ d="Load the file in the path."}),

    Function("save_textfile", {
        Arg("file_path", String()),
        Arg("data", String()),
    }, nil, {d="Append the text to the file in the path. Override if the file exists. Create if it doesn't exist."}),

    Function("save_textfile_append", {
        Arg("file_path", String()),
        Arg("data", String()),
    }, nil, {d="Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist."}),

    Function("push_matrix", nil, nil, {d="Push the transform matrix."}),

    Function("pop_matrix", nil, nil, {d="Pop the transform matrix."}),

    Function("reset_matrix", nil, nil, {d="Reset the transformation matrix (load identity matrix.)"}),

    Function("translate", {
        Arg("delta_x", Integer()),
        Arg("delta_y", Integer()),
    }, nil, {d="Apply translation (changes transform matrix.)"}),

    Function("rotate", {
        Arg("angle", Number()),
    }, nil, {d="Apply rotation (changes transform matrix.)"}),

    Function("rotate_at", {
        Arg("angle", Number()),
        Arg("x", Integer()),
        Arg("y", Integer()),
    }, nil, {d="Apply rotation at the given location (changes transform matrix.)"}),

    Function("scale", {
        Arg("scale_x", Number()),
        Arg("scale_y", Number()),
    }, nil, {d="Apply scaling (changes transform matrix.)"}),

    Function("scale_at", {
        Arg("scale_x", Integer()),
        Arg("scale_y", Integer()),
        Arg("x", Number()),
        Arg("y", Number()),
    }, nil, {d="Apply scaling at the given location (changes transform matrix.)"}),

    Function("set_default_blendmode", {
        Arg("blendmode", Defined("BlendMode")),
    }, nil, {d="Set the default blendmode."}),

    Function("set_blendmode", {
        Arg("blendmode", Defined("BlendMode")),
    }, nil, {d="Set the effective blendmode."}),

    Function("reset_blendmode", nil, nil, {d="Reset the blendmode value to its default value."}),

    Function("set_default_filtermode", {
        Arg("filtermode", Defined("FilterMode")),
    }, nil, {d="Set the default filtermode."}),

    Function("set_filtermode", {
        Arg("filtermode", Defined("FilterMode")),
    }, nil, {d="Set the effective filtermode."}),

    Function("reset_filtermode", nil, nil, {d="Reset the filtermode value to its default value."}),

    Function("new_shader", {
        Arg("shaderdef", Defined("ShaderDef")),
    },{
        Ret("val", Defined("Shader")),
    }, {d="Create a shader with given specification.", ctor=true, c_api_skip=true}),

    Function("set_shader", {
        Arg("shader", Defined("Shader")),
    }, nil, {d="Set the custom shader and use it for consequent calls."}),

    Function("reset_shader", nil, nil, {d="Reset the shader, back to framework defaults."}),

    Function("set_shader_uniform", {
        Arg("shader", Defined("Shader")),
        Arg("uniform_name", String()),
        Arg("uniform_value", Defined("ShaderUniformValue")),
    }, nil, {d="Set the specified uniform."}),

    Function("reset_shader_uniform", {
        Arg("shader", Defined("Shader")),
        Arg("uniform_name", String()),
    }, nil, {d="Reset the specified uniform."}),

    Function("new_shaderbuilder", nil, {
        Ret("val", Defined("ShaderBuilder")),
    }, {d="Create a ShaderBuilder object.", ctor=true}),

    Function("shaderbuilder_uniform", {
        Arg("shaderbuilder", Defined("ShaderBuilder")),
        Arg("uniform_name", String()),
        Arg("uniform_type", Defined("UniformType")),
    }, nil, {d="Add uniform definition to the shaderbuilder"}),

    Function("shaderbuilder_vertex", {
        Arg("shaderbuilder", Defined("ShaderBuilder")),
        Arg("vertex_code", String()),
    }, nil, {d="Add vertex code to the shaderbuilder"}),

    Function("shaderbuilder_fragment", {
        Arg("shaderbuilder", Defined("ShaderBuilder")),
        Arg("fragment_code", String()),
    }, nil, {d="Add fragment to the shaderbuilder"}),

    Function("shaderbuilder_build", {
        Arg("shaderbuilder", Defined("ShaderBuilder")),
    }, {
        Ret("shader", Defined("Shader"))
    }, {d="Add fragment to the shaderbuilder", ctor="true"}),

    Record("Image", {
        Field("width", Integer(), {map_read = "get_image_width"}),
        Field("height", Integer(), {map_read = "get_image_height"}),
        Field("is_canvas", Boolean(), {map_read = "is_image_canvas"}),
    }, nil, {d="Image type"}),

    Record("Font", nil, nil, {d="Font type."}),

    Record("Music", {
        Field("playing", Boolean(), {map_read = "is_music_playing"}),
        Field("length", Number(), {map_read = "get_music_length"}),
        Field("length_played", Number(), {map_read = "get_music_length_played"}),
        Field("pan", Number(), {map_read = "get_music_pan", map_write = "set_music_pan"}),
        Field("pitch", Number(), {map_read = "get_music_pitch", map_write = "set_music_pitch"}),
        Field("volume", Number(), {map_read = "get_music_volume", map_write = "set_music_volume"}),
    }, {
        Method("play", {map_to = "play_music"}),
        Method("pause", {map_to = "pause_music"}),
        Method("resume", {map_to = "resume_music"}),
        Method("stop", {map_to = "stop_music"}),
        Method("seek", {map_to = "seek_music"}),
    }, {d="Music type."}),

    Record("Sound", {
        Field("pan", Number(), {map_read = "get_sound_pan", map_write = "set_sound_pan"}),
        Field("pitch", Number(), {map_read = "get_sound_pitch", map_write = "set_sound_pitch"}),
        Field("volume", Number(), {map_read = "get_sound_volume", map_write = "set_sound_volume"}),
    }, {
        Method("clone", {map_to = "clone_sound"}),
        Method("pause", {map_to = "pause_sound"}),
        Method("play", {map_to = "play_sound"}),
        Method("resume", {map_to = "resume_sound"}),
        Method("stop", {map_to = "stop_sound"}),
    }, {d="Sound type."}),

    Tuple("FloatVec4", Float(), 4, {d="Tuple of floats"}),

    Variant("ShaderUniformValue", {
        Option("float_val", Float(), {d="Note: Used for single numbers, int or float"}),
        Option("vec_val", Defined("FloatVec4")),
        Option("sampler2D_val", Defined("Image")),
    }, {d="Shader uniform value"}),

    Record("Shader", nil, {
        Method("set", {map_to = "set_shader_uniform"}),
        Method("reset", {map_to = "reset_shader_uniform"}),
    }, {d="Shader type"}),

    Dict("UniformNamesToTypes",String(), Defined("UniformType"), {c_api_skip=true}),

    Record("ShaderDef", {
        Field("frag", String()),
        Field("vert", String()),
        Field("uniforms", Defined("UniformNamesToTypes")),
    }, nil, {d="Shader definition: uniforms declaration, vertex and fragment shader code.", c_api_skip=true}),

    Record("ShaderBuilder", nil, {
        Method("uniform", {map_to = "shaderbuilder_uniform"}),
        Method("vertex", {map_to = "shaderbuilder_vertex"}),
        Method("fragment", {map_to = "shaderbuilder_fragment"}),
        Method("build", {map_to = "shaderbuilder_build"}),
    }, {d="ShaderBuilder type"}),

    Enum("UniformType", {
        '_invalid', 'float', 'vec2', 'vec3', 'vec4', 'int', 'ivec2',
        'ivec3', 'ivec4', 'mat4', 'sampler2D',
    }, {d="Acceptable uniformtype values."}),

    Enum("BlendMode", {
        'none' , 'blend' , 'add' , 'mod' , 'mul' ,
    }, {d="Acceptable blendmode values."}),

    Enum("FilterMode", {
        '_invalid', 'nearest', 'linear',
    }, {d="Acceptable filtermode values."}),

    Enum("GamepadAxis", {
        'left_x', 'left_y', 'right_x', 'right_y', 'left_trigger', 'right_trigger',
    }, {d="Acceptable gamepadaxis values."}),

    Enum("GamepadButton", {
        'pad_a', 'pad_b', 'pad_x', 'pad_y', 'left_bumper', 'right_bumper',
        'back', 'start', 'guide', 'left_thumb', 'right_thumb', 'dpad_up',
        'dpad_right', 'dpad_down', 'dpad_left',
    }, {d="Acceptable gamepadbutton values."}),

    Enum("MouseButton", {
        'mb1', 'mb2', 'mb3', 'mb4', 'mb5', 'mb6',
        'mb7', 'mb8',
    }, {d="Acceptable mousebutton values."}),

    Enum("KeyboardKey", {
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
    }, {d="Acceptable keyboardkey values."}),



    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- -- BEGIN: PHYSICS ------------------------------

    Function("set_physics_engine", {
        Arg("state", Defined("PhysicsState")),
    }, nil, {d="Set the physics engine state."});

    -- Function("reset_physics_engine", nil, nil, {d="Reset the physics engine state."});

    -- Function("set_physics_config", {
    --     Arg("name", Defined("PhysicsConfig"), {nativetype="udata"}),
    --     Arg("value", Number()),
    -- }, nil, {d="Set the given physics engine/world config."});

    -- Function("reset_physics_config", {
    --     Arg("name", Defined("PhysicsConfig"), {nativetype="udata"}),
    -- }, nil, {d="Reset the given physics engine/world config."});

    -- Function("get_physics_config", {
    --     Arg("name", Defined("PhysicsConfig"), {nativetype="udata"}),
    -- }, {
    --     Ret("val", Number()),
    -- }, {d="Gets the given physics engine/world config."});

    -- Function("add_body_geom", {
    --     Arg("body", Defined("Body"), {nativetype="udata"}),
    --     Arg("geom", Defined("Geom"), {nativetype="union"}),
    --     Arg("mmmm", List("_Mmm", Float(), {max_count=4})),
    -- }, {
    -- }, {d=""}),


    -- -- Function("get_body_geom", {
    -- --     Arg("body", Defined("Body"), {nativetype="udata"}),
    -- --     Arg("key", String()),
    -- -- }, {
    -- --     Ret("val", Defined("Geom"), {nativetype="union"}),
    -- -- }, {d=""}),

    -- Record("Body", {
    --     Field("x", Number(), {map_read="get_body_x", map_write="set_body_x"}),
    --     Field("y", Number(), {map_read="get_body_y", map_write="set_body_y"}),
    --     Field("angle", Number(), {map_read="get_body_angle", map_write="set_body_angle"}),
    --     Field("vel_x", Number(), {map_read="get_body_vel_x", map_write="set_body_vel_x"}),
    --     Field("vel_y", Number(), {map_read="get_body_vel_y", map_write="set_body_vel_y"}),
    --     Field("angular_vel_x", Number(), {map_read="get_body_angular_vel_x", map_write="set_body_angular_vel_x"}),
    --     Field("angular_vel_y", Number(), {map_read="get_body_angular_vel_y", map_write="set_body_angular_vel_y"}),
    --     Field("rotation_enabled", Boolean(), {map_read="is_body_rotation_enabled", map_write="set_body_rotation_enabled"}),
    --     Field("mass", Number(), {map_read="get_body_mass", map_write="set_body_mass"}),

    --     --   methods:
    --     -- set_body_location
    --     -- set_body_linearvelocity
    --     -- set_body_angularvelocity
    --     --
    -- }, {d="Physics body."}),

    -- -- Record("Joint", {
    -- --     -- Field(),
    -- -- }, {d="Physics joint."}),


    -- Record("CircleGeom", {
    --     Field("radius", Number(), {map_read="get_circle_geom_radius", map_write="set_circle_geom_radius"}),
    -- }, {d="Circle geom type."}),

    -- Record("RectGeom", {
    --     Field("width", Number(), {map_read="get_rect_geom_width", map_write="set_rect_geom_width"}),
    --     Field("height", Number(), {map_read="get_rect_geom_height", map_write="set_rect_geom_height"}),
    -- }, {d="Rectangle geom type."}),

    -- Variant("Geom", {
    --     Option("circle_geom", Defined("CircleGeom","udata"),
    --     Option("rect_geom", Defined("RectGeom"),
    -- }, {d="Physics collision geometry object."}),


    -- Enum("GeomType", {"circle", "rect"}, {d="Physics Geom types"}),

    -- -- Enum("JointType", {"mmm", "hinge"}, {d="Physics Joint types"}),

    -- Enum("PhysicsConfig", {"num_dimensions", "gravity_x", "gravity_y", "gravity_z", "ERP", "CFM", }), -- there's a lot more

    Enum("PhysicsState", {"off", "on", "paused"}, {d="Physics engine state.", dd={["off"]="Physics engine off", ["on"]="Physics engine on", ["paused"]="Physics engine paused"}}), -- dd: testing enum docs


    -- END:   PHYSICS ------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------

})

local summary = apidef.process(lyte_namespace)

return summary, lyte_namespace
