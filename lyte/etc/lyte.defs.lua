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
    frame = Func({Var(Num, "dt", {d=""}), Var(Num, "width", {d=""}), Var(Num, "height", {d=""}), Var(Bool, "resized", {d=""})}, {} , {d="Frame function. To be implemented by the user"}),
    quit = Func(),
    get_windowwidth = Func(nil, {Num}),
    get_windowheight = Func(nil, {Num}),
    set_windowsize = Func({Var(Num, "width"), Var(Num, "height")}),
    set_windowminsize = Func({Var(Num, "width"), Var(Num, "height")}),
    set_fullscreen = Func({Var(Bool, "fullscreen")}),
    get_fullscreen = Func(nil, {Bool}),
    set_windowtitle = Func({Var(Str, "title")}),
    set_windowicon = Func({Var(Str, "icon")}),
    set_vsync = Func({Var(Bool, "vsync")}),
    get_vsync = Func(nil, {Bool}),
    set_margins = Func({Var(Num, "left"), Var(Num, "right"), Var(Num, "top"), Var(Num, "bottom")}),
    set_paddings = Func({Var(Num, "left"), Var(Num, "right"), Var(Num, "top"), Var(Num, "bottom")}),
    push_matrix = Func(),
    pop_matrix = Func(),
    identity_matrix = Func(),
    translate = Func({Var(Num, "dx"), Var(Num, "dy")}),
    rotate = Func({Var(Num, "r")}),
    rotate_at = Func({Var(Num, "r"), Var(Num, "x"), Var(Num, "y")}),
    scale = Func({Var(Num, "sx"), Var(Num, "sy")}),
    scale_at = Func({Var(Num, "sx"), Var(Num, "sy"), Var(Num, "x"), Var(Num, "y")}),
    clear = Func({Var(Num, "r"), Var(Num, "g"), Var(Num, "b"), Var(Num, "a")}),
    set_color = Func({Var(Num, "r"), Var(Num, "g"), Var(Num, "b"), Var(Num, "a")}),
    reset_color = Func(),
    set_defaultblendmode = Func({Var("lyte.BlendMode", "blendmode")}),
    set_blendmode = Func({Var("lyte.BlendMode", "blendmode")}),
    reset_blendmode = Func(),
    set_defaultfiltermode = Func({Var("lyte.FilterMode", "filtermode")}),
    set_filtermode = Func({Var("lyte.FilterMode", "filtermode")}),
    reset_filtermode = Func(),
    set_canvas= Func({Var("lyte.Canvas", "canvas")}),
    reset_canvas = Func(),
    new_shader = Func({Var("lyte.ShaderDef", "shaderdef")}, {"lyte.Shader"}),
    set_shader= Func({Var("lyte.Shader", "shader")}),
    reset_shader = Func(),
    send_shader= Func({Var("lyte.Shader", "shader"), Var("lyte.ShaderUniforms", "uniforms")}),
    set_mastervolume = Func({Var(Num, "mastervolume")}),
    get_mastervolume = Func(nil, {Num}),
    file_read = Func({Var(Str, "path")}, {Str}),
    file_write = Func({Var(Str, "path"), Var(Str, "data")}, {}),
    file_append = Func({Var(Str, "path"), Var(Str, "data")}, {}),
    load_font = Func({Var(Str, "path"), Var(Num, "size")}, {"lyte.Font"}),
    set_font = Func({Var("lyte.Font", "font")}),
    reset_font = Func(),
    draw_text = Func({Var(Str, "text"), Var(Num, "x"), Var(Num, "y")}, {Num, Num}),
    measure_text = Func({Var(Str, "text")}, {Num, Num}),
    draw_image = Func({Var("lyte.Image", "image"), Var(Num, "x"), Var(Num, "y")}),
    draw_imagerect = Func({Var("lyte.Image", "image"), Var(Num, "x"), Var(Num, "y"), Var(Num, "rect_x"), Var(Num, "rect_y"), Var(Num, "rect_width"), Var(Num, "rect_height")}),
    draw_point = Func({Var(Num, "x"), Var(Num, "y")}),
    draw_points = Func({Var(List("lyte.Point"), "points")}),
    draw_line = Func({Var(Num, "x1"), Var(Num, "y1"), Var(Num, "x2"), Var(Num, "y2")}),
    draw_lines = Func({Var(List("lyte.Line"), "lines")}),
    draw_rect = Func({Var(Num, "x"), Var(Num, "y"), Var(Num, "width"), Var(Num, "height")}),
    draw_rect_filled = Func({Var(Num, "x"), Var(Num, "y"), Var(Num, "width"), Var(Num, "height")}),
    draw_circle = Func({Var(Num, "x"), Var(Num, "y"), Var(Num, "radius")}),
    draw_circle_filled = Func({Var(Num, "x"), Var(Num, "y"), Var(Num, "radius")}),
    draw_rects_filled = Func({Var(List("lyte.Rect"), "rects")}),
    draw_triangles_filled = Func({Var(List("lyte.Triangle"), "triangles")}),
    draw_striplines = Func({Var(List("lyte.Point"), "points")}),
    draw_striptriangles_filled = Func({Var(List("lyte.Triangle"), "triangles")}),
    is_keydown = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_keyrepeat = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_keypressed = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    is_keyreleased = Func({Var("lyte.KeyboardKey", "key")}, {Bool}),
    get_mouse = Func({}, {Num, Num}),
    is_mousedown = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    is_mousepressed = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    is_mousereleased = Func({Var("lyte.MouseButton", "mousebutton")}, {Bool}),
    num_gamepads = Func(nil, {Num}),
    get_gamepadaxis = Func({Var(Num, "index"), Var("lyte.GamepadAxis", "gamepadaxis")}, {Num}),
    is_gamepaddown = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    is_gamepadpressed = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    is_gamepadreleased = Func({Var(Num, "index"), Var("lyte.GamepadButton", "gamepadbutton")}, {Bool}),
    get_gamepadname = Func({Var(Num, "index")},{Str}),
    get_musicvolume = Func({Var("lyte.Music", "music")}, {Num}),
    set_musicvolume = Func({Var("lyte.Music", "music"), Var(Num, "volume")}, {Num}),
    get_musicpitch = Func({Var("lyte.Music", "music")}, {Num}),
    set_musicpitch = Func({Var("lyte.Music", "music"), Var(Num, "pitch")}, {Num}),
    get_musicpan = Func({Var("lyte.Music", "music")}, {Num}),
    set_musicpan = Func({Var("lyte.Music", "music"), Var(Num, "pan")}, {Num}),
    play_music = Func({Var("lyte.Music", "music")}),
    pause_music = Func({Var("lyte.Music", "music")}),
    resume_music = Func({Var("lyte.Music", "music")}),
    stop_music = Func({Var("lyte.Music", "music")}),
    is_musicplaying = Func({Var("lyte.Music", "music")}, {Bool}),
    seek_music = Func({Var("lyte.Music", "music"), Var(Num, "secs")}),
    get_musiclength = Func({Var("lyte.Music", "music")}, {Num}),
    get_musiclength_played = Func({Var("lyte.Music", "music")}, {Num}),
    get_sounddatavolume = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddatavolume = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "volume")}, {Num}),
    get_sounddatapitch = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddatapitch = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "pitch")}, {Num}),
    get_sounddatapan = Func({Var("lyte.SoundData", "sounddata")}, {Num}),
    set_sounddatapan = Func({Var("lyte.SoundData", "sounddata"), Var(Num, "pan")}, {Num}),
    get_soundvolume = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_soundvolume = Func({Var("lyte.Sound", "sound"), Var(Num, "volume")}, {Num}),
    get_soundpitch = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_soundpitch = Func({Var("lyte.Sound", "sound"), Var(Num, "pitch")}, {Num}),
    get_soundpan = Func({Var("lyte.Sound", "sound")}, {Num}),
    set_soundpan = Func({Var("lyte.Sound", "sound"), Var(Num, "pan")}, {Num}),
    play_sound = Func({Var("lyte.Sound", "sound")}),
    pause_sound = Func({Var("lyte.Sound", "sound")}),
    resume_sound = Func({Var("lyte.Sound", "sound")}),
    stop_sound = Func({Var("lyte.Sound", "sound")}),
    is_soundplaying = Func({Var("lyte.Sound", "sound")}, {Bool}),
    load_image = Func({Var(Str, "path")}, {"lyte.Image"}),
    Image = Record({ width=Num, height=Num }),
    new_canvas = Func({Var(Num, "width"), Var(Num, "height")}, {"lyte.Canvas"}),
    Canvas = Record({ width=Num, height=Num, image="lyte.Image" }),
    load_music =  Func({Var(Str, "path")}, {"lyte.Music"}),
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
    ShaderDef = Record({ ver=Str, frag=Str, uniforms=Dict(Str, "lyte.UniformType") }),
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
    Point = Record({ x=Num, y=Num }),
    Line = Record({ x1=Num, y1=Num, x2=Num, y2=Num }),
    Rect = Record({ x=Num, y=Num, w=Num, h=Num }),
    Triangle = Record({ x1=Num, y1=Num, x2=Num, y2=Num, x3=Num, y3=Num  }),
    FilterMode = Enum({"nearest", "linear"}, {d=""}),
    BlendMode = Enum({"blend" , "add" , "mod" , "mul" , "none"}, {d=""}),
    UniformType = Enum({
        "float" , "vec2" , "vec3" , "vec4"
        , "int" , "ivec2" , "ivec3" , "ivec4"
        , "mat4"
        , "sampler2D"
    }),
    GamepadAxis = Enum({
        "axis_left_x" , "axis_left_y" , "axis_right_x" , "axis_right_y" ,
        "axis_trigger_left" ,  "axis_trigger_right"
    }),
    GamepadButton = Enum({
        "but_a" , "but_b" , "but_x" , "but_y" , "but_leftbumper" , "but_rightbumper" ,
        "but_back" , "but_start" , "but_guide" , "but_leftthumb" , "but_righthumb" ,
        "but_dpad_up" , "but_dpad_right" , "but_dpad_down" , "but_dpad_left"
    }),
    MouseButton = Enum({
        "m_1" , "m_2" , "m_3" , "m_4" , "m_5" , "m_6" , "m_7" , "m_8"
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

}


print(defs.pp_typescript_d_ts("lyte", lyte, 1))



return lyte