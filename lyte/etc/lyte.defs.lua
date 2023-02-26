local defs = require "defs"

local Str = defs.String  -- As a value
local Num = defs.Number  -- As a value
local Bool = defs.Boolean  -- As a value
local Nil = defs.Nil     -- As a value

local NS = defs.NS
local List = defs.List -- Table(typ, desc)
local Dict = defs.Dict -- Table(k_type, v_type)
local Func = defs.Function -- Fn(arglist, retlist, desc)
local Method = defs.Method -- Fn(arglist, retlist, desc)

local Record = defs.Record -- Record({ name_to_type_dict}, desc)
local Enum = defs.Enum -- Enum(list_of_strings, desc)
local Or = defs.Or      -- Or(list_of_types, desc)
local Var = defs.Var  -- Function arguments. A(type, name?, desc?)
local Alias = defs.Alias --- Alias(name, decl, tag)

local lyte = NS {
    tick = Func({Var(Num, "delta_time", {d=""}), Var(Num, "window_width", {d=""}), Var(Num, "window_height", {d=""}), Var(Bool, "window_resized", {d=""})}, {} , {d="'tick' function. To be implemented by the user"}),
    quit = Func(),
    -- get_window_width = Func(nil, {Num}),
    -- get_window_height = Func(nil, {Num}),
    get_window_size = Func(nil, {Num, Num}),
    set_window_size = Func({Var(Num, "width"), Var(Num, "height")}),
    set_window_minsize = Func({Var(Num, "width"), Var(Num, "height")}),
    set_fullscreen = Func({Var(Bool, "fullscreen")}),
    is_fullscreen = Func(nil, {Bool}),
    set_window_title = Func({Var(Str, "title")}),
    set_window_icon = Func({Var(Str, "icon_path")}),
    set_window_vsync = Func({Var(Bool, "vsync")}),
    is_window_vsync = Func(nil, {Bool}),
    set_window_margins = Func({Var(Num, "left"), Var(Num, "right"), Var(Num, "top"), Var(Num, "bottom")}),
    set_window_paddings = Func({Var(Num, "left"), Var(Num, "right"), Var(Num, "top"), Var(Num, "bottom")}),
    push_matrix = Func(),
    pop_matrix = Func(),
    reset_matrix = Func(),
    translate = Func({Var(Num, "dx"), Var(Num, "dy")}),
    rotate = Func({Var(Num, "r")}),
    rotate_at = Func({Var(Num, "r"), Var(Num, "x"), Var(Num, "y")}),
    scale = Func({Var(Num, "sx"), Var(Num, "sy")}),
    scale_at = Func({Var(Num, "sx"), Var(Num, "sy"), Var(Num, "x"), Var(Num, "y")}),
    cls = Func({Var(Num, "r"), Var(Num, "g"), Var(Num, "b"), Var(Num, "a")}),
    set_color = Func({Var(Num, "r"), Var(Num, "g"), Var(Num, "b"), Var(Num, "a")}),
    reset_color = Func(),
    set_default_blendmode = Func({Var("lyte.BlendMode", "blendmode")}),
    set_blendmode = Func({Var("lyte.BlendMode", "blendmode")}),
    reset_blendmode = Func(),
    set_default_filtermode = Func({Var("lyte.FilterMode", "filtermode")}),
    set_filtermode = Func({Var("lyte.FilterMode", "filtermode")}),
    reset_filtermode = Func(),
    set_canvas= Func({Var("lyte.Canvas", "canvas")}),
    reset_canvas = Func(),
    new_shader = Func({Var("lyte.ShaderDef", "shaderdef")}, {"lyte.Shader"}),
    set_shader= Func({Var("lyte.Shader", "shader")}),
    reset_shader = Func(),
    send_shader_uniforms= Func({Var("lyte.Shader", "shader"), Var("lyte.ShaderUniforms", "uniforms")}),
    set_mastervolume = Func({Var(Num, "mastervolume")}),
    get_mastervolume = Func(nil, {Num}),
    load_file = Func({Var(Str, "file_path")}, {Str}),
    save_file_write = Func({Var(Str, "file_path"), Var(Str, "data")}, {}),
    save_file_append = Func({Var(Str, "file_path"), Var(Str, "data")}, {}),
    load_font = Func({Var(Str, "font_path"), Var(Num, "size")}, {"lyte.Font"}),
    set_font = Func({Var("lyte.Font", "font")}),
    reset_font = Func(),
    draw_text = Func({Var(Str, "text"), Var(Num, "dest_x"), Var(Num, "dest_y")}, {}),
    get_text_size = Func({Var(Str, "text")}, {Num, Num}),
    draw_image = Func({Var("lyte.Image", "image"), Var(Num, "dest_x"), Var(Num, "dest_y")}),
    draw_image_rect = Func({Var("lyte.Image", "image"), Var(Num, "dest_x"), Var(Num, "dest_y"), Var(Num, "src_x"), Var(Num, "src_y"), Var(Num, "src_width"), Var(Num, "src_height")}),
    draw_point = Func({Var(Num, "dest_x"), Var(Num, "dest_y")}),
    draw_line = Func({Var(Num, "x1"), Var(Num, "y1"), Var(Num, "x2"), Var(Num, "y2")}),
    draw_rect_line = Func({Var(Num, "dest_x"), Var(Num, "dest_y"), Var(Num, "width"), Var(Num, "height")}),
    draw_rect = Func({Var(Num, "dest_x"), Var(Num, "dest_y"), Var(Num, "width"), Var(Num, "height")}),
    draw_circle_line = Func({Var(Num, "dest_x"), Var(Num, "dest_y"), Var(Num, "radius")}),
    draw_circle = Func({Var(Num, "dest_x"), Var(Num, "dest_y"), Var(Num, "radius")}),
    is_key_down = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_key_repeat = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_key_pressed = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_key_released = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    get_mouse_position = Func({}, {Num, Num}),
    is_mouse_down = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    is_mouse_pressed = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    is_mouse_released = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    get_gamepad_count = Func(nil, {Num}),
    get_gamepad_axis = Func({Var(Num, "index"), Var("lyte.GamepadAxis", "gamepadaxis")}, {Num}),
    is_gamepad_down = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    is_gamepad_pressed = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    is_gamepad_released = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    get_gamepad_name = Func({Var(Num, "index")},{Str}),
    get_music_volume = Func({Var("lyte.Music", "music")}, {Num}),
    set_music_volume = Func({Var("lyte.Music", "music"), Var(Num, "volume")}, {}),
    get_music_pitch = Func({Var("lyte.Music", "music")}, {Num}),
    set_music_pitch = Func({Var("lyte.Music", "music"), Var(Num, "pitch")}, {}),
    get_music_pan = Func({Var("lyte.Music", "music")}, {Num}),
    set_music_pan = Func({Var("lyte.Music", "music"), Var(Num, "pan")}, {}),
    play_music = Func({Var("lyte.Music", "music")}),
    pause_music = Func({Var("lyte.Music", "music")}),
    resume_music = Func({Var("lyte.Music", "music")}),
    stop_music = Func({Var("lyte.Music", "music")}),
    is_music_playing = Func({Var("lyte.Music", "music")}, {Bool}),
    seek_music = Func({Var("lyte.Music", "music"), Var(Num, "secs")}),
    get_music_length = Func({Var("lyte.Music", "music")}, {Num}),
    get_music_length_played = Func({Var("lyte.Music", "music")}, {Num}),
    get_sounddata_volume = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddata_volume = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "volume")}, {}),
    get_sounddata_pitch = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddata_pitch = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "pitch")}, {}),
    get_sounddata_pan = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddata_pan = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "pan")}, {}),
    get_sound_volume = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_sound_volume = Func({Var("lyte.Sound", "sound"), Var(Num, "volume")}, {}),
    get_sound_pitch = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_sound_pitch = Func({Var("lyte.Sound", "sound"), Var(Num, "pitch")}, {}),
    get_sound_pan = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_sound_pan = Func({Var("lyte.Sound", "sound"), Var(Num, "pan")}, {}),
    play_sound = Func({Var("lyte.Sound", "sound")}),
    pause_sound = Func({Var("lyte.Sound", "sound")}),
    resume_sound = Func({Var("lyte.Sound", "sound")}),
    stop_sound = Func({Var("lyte.Sound", "sound")}),
    is_sound_playing = Func({Var("lyte.Sound", "sound")}, {Bool}),
    load_image = Func({Var(Str, "image_path")}, {"lyte.Image"}),
    Image = Record({ width=Num, height=Num }),
    new_canvas = Func({Var(Num, "width"), Var(Num, "height")}, {"lyte.Canvas"}),
    Canvas = Record({ width=Num, height=Num, image="lyte.Image" }),
    load_music =  Func({Var(Str, "music_path")}, {"lyte.Music"}),
    Music = Record({
        volume = Num, pitch = Num, pan = Num,
        length = Number,
        length_played = Num,
        playing = Bool,
        play = Method({Var(Bool, "loop")}, {}, ""),
        pause = Method({}, {}, ""),
        resume = Method({}, {}, ""),
        stop = Method({}, {}, ""),
        seek = Method({Var(Num, "secs")}, {}, ""),
    }, {d=""}),
    load_sounddata = Func({Var(Str, "path")}, {"lyte.SoundData"}),
    SoundData = Record({ volume = Num, pitch = Num, pan = Num, }),
    new_sound = Func(Var("lyte.SoundData", "sounddata"), {"lyte.Sound"}),
    Sound = Record({
        volume = Num, pitch = Num, pan = Num,
        play = Method({Var(Bool, "loop")}, {}, ""),
        pause = Method({}, {}, ""),
        resume = Method({}, {}, ""),
        stop = Method({}, {}, ""),
    }, {d="An playable instance of a SoundData"}),
    ShaderDef = Record({ vert=Str, frag=Str, uniforms=Dict(Str, "lyte.UniformType") }),
    --- ShaderUniforms = Dict(Str,"any_tbd"),
    Shader = Record({
        send = Method({Var("lyte.ShaderUniforms", "uniforms")}),
    }),
    ShaderUniformValue = Alias(Or({
        Num,
        List(Num),
        "lyte.Image"
    }), {d=""}),
    ShaderUniforms = Alias(Dict(Str, "lyte.ShaderUniformValue")),
    Font = Record({}),

    FilterMode = Enum({"nearest", "linear"}, {d=""}),
    BlendMode = Enum({"blend" , "add" , "mod" , "mul" , "none"}, {d=""}),
    UniformType = Enum({
        "float" , "vec2" , "vec3" , "vec4"
        , "int" , "ivec2" , "ivec3" , "ivec4"
        , "mat4"
        , "sampler2D"
    }),
    GamepadAxis = Enum({
        "left_x" , "left_y" ,
        "right_x" , "right_y" ,
        "left_trigger" ,  "right_trigger"
    }),
    GamepadButton = Enum({
        "pad_a" , "pad_b" , "pad_x" , "pad_y" , "left_bumper" , "right_bumper" ,
        "back" , "start" , "guide" , "left_thumb" , "right_thumb" ,
        "dpad_up" , "dpad_right" , "dpad_down" , "dpad_left"
    }),
    MouseButton = Enum({
        "mb1" , "mb2" , "mb3" , "mb4" , "mb5" , "mb6" , "mb7" , "mb8"
    }),
    KeyboardKey = Enum({
        "space" , "'" , "," , "-" , "." , "/" , "0" , "1" , "2" , "3" , "4" ,
        "5" , "6" , "7" , "8" , "9" , ";" , "=" ,
        "a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" ,
        "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z" ,
        "[" , "\\" , "]" , "`" ,
        "world_1" , "world_2" , "escape" ,
        "enter" , "tab" , "backspace" , "insert" , "delete" , "right" , "left" , "down" , "up" ,
        "page_up" , "page_down" , "home" , "end" , "caps_lock" , "scroll_lock" , "num_lock" ,
        "print_screen" , "pause" , "f1" , "f2" , "f3" , "f4" ,
        "f5" , "f6" , "f7" , "f8" , "f9" , "f10" , "f11" , "f12" ,
        "f13" , "f14" , "f15" , "f16" , "f17" , "f18" , "f19" , "f20" , "f21" , "f22" , "f23" ,
        "f24" , "f25" ,
        "kp_0" , "kp_1" , "kp_2" , "kp_3" , "kp_4" , "kp_5" , "kp_6" , "kp_7" , "kp_8" , "kp_9" ,
        "kp_decimal" , "kp_divide" , "kp_multiply" , "kp_subtract" , "kp_add" , "kp_enter" , "kp_equal" ,
        "left_shift" , "left_control" , "left_alt" , "left_super" ,
        "right_shift" , "right_control" , "right_alt" , "right_super" ,
        "menu"
    }),
    -- EXPERIMENTAL API --
    -- These are available, but will have design changes, so commmented out for now
    -- Point = Record({ x=Num, y=Num }),
    -- Line = Record({ x1=Num, y1=Num, x2=Num, y2=Num }),
    -- Rect = Record({ x=Num, y=Num, w=Num, h=Num }),
    -- Triangle = Record({ x1=Num, y1=Num, x2=Num, y2=Num, x3=Num, y3=Num  }),
    -- draw_many_points = Func({Var(List("lyte.Point"), "points")}),
    -- draw_many_lines = Func({Var(List("lyte.Line"), "lines")}),
    -- draw_many_rects = Func({Var(List("lyte.Rect"), "rects")}),
    -- draw_many_triangles = Func({Var(List("lyte.Triangle"), "triangles")}),

    -- THESE ARE probably permanantly removed. issues in sokol_gp batching, I think.
    --draw_line_strips = Func({Var(List("lyte.Point"), "points")}),
    --draw_triangle_strips = Func({Var(List("lyte.Triangle"), "triangles")}),
}


print(defs.pp_typescript_d_ts("lyte", lyte, 1))



return lyte