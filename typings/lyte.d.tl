global record lyte
    -- functions
    tick: function(delta_time: number, window_width: number, window_height: number, window_resized: boolean)
    quit: function()
    cls: function(r: number, g: number, b: number, a: number)
    set_color: function(r: number, g: number, b: number, a: number)
    reset_color: function()
    draw_point: function(x: number, y: number)
    draw_line: function(x1: number, y1: number, x2: number, y2: number)
    draw_triangle: function(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    draw_triangle_line: function(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    draw_rect: function(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    draw_rect_line: function(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    draw_circle: function(dest_x: number, dest_y: number, radius: number)
    draw_circle_line: function(dest_x: number, dest_y: number, radius: number)
    draw_ellipse: function(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    draw_ellipse_line: function(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    load_image: function(image_path: string): Image
    draw_image: function(image: Image, dest_x: number, dest_y: number)
    draw_image_rect: function(image: Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number)
    get_image_width: function(image: Image): number
    get_image_height: function(image: Image): number
    new_canvas: function(width: number, height: number): Image
    set_canvas: function(canvas_image: Image)
    reset_canvas: function()
    is_image_canvas: function(image: Image): boolean
    new_imagebatch: function(image: Image): ImageBatch
    reset_imagebatch: function(imagebatch: ImageBatch)
    add_imagebatch_rect: function(imagebatch: ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
    get_imagebatch_rect_count: function(imagebatch: ImageBatch): number
    draw_imagebatch: function(imagebatch: ImageBatch)
    load_font: function(font_path: string, size: number): Font
    set_font: function(font: Font)
    reset_font: function()
    draw_text: function(text: string, dest_x: number, dest_y: number)
    get_text_width: function(text: string): number
    get_text_height: function(text: string): number
    get_monitor_count: function(): number
    get_monitor_name: function(index: number): string
    get_monitor_width: function(index: number): number
    get_monitor_height: function(index: number): number
    set_window_monitor: function(index: number)
    set_window_resizable: function(resizable: boolean)
    set_window_minsize: function(width: number, height: number)
    set_window_size: function(width: number, height: number)
    get_window_width: function(): number
    get_window_height: function(): number
    set_window_position: function(x: number, y: number)
    set_fullscreen: function(fullscreen: boolean)
    is_fullscreen: function(): boolean
    set_window_title: function(title: string)
    set_window_vsync: function(vsync: boolean)
    is_window_vsync: function(): boolean
    set_window_icon_file: function(icon_path: string)
    set_window_margins: function(left: number, right: number, top: number, bottom: number)
    set_window_paddings: function(left: number, right: number, top: number, bottom: number)
    is_key_down: function(key: KeyboardKey): boolean
    is_key_pressed: function(key: KeyboardKey): boolean
    is_key_released: function(key: KeyboardKey): boolean
    is_key_repeat: function(key: KeyboardKey): boolean
    is_mouse_down: function(mouse_button: MouseButton): boolean
    is_mouse_pressed: function(mouse_button: MouseButton): boolean
    is_mouse_released: function(mouse_button: MouseButton): boolean
    get_mouse_x: function(): number
    get_mouse_y: function(): number
    get_gamepad_count: function(): number
    get_gamepad_name: function(index: number): string
    is_gamepad_down: function(index: number, gamepad_button: GamepadButton): boolean
    is_gamepad_pressed: function(index: number, gamepad_button: GamepadButton): boolean
    is_gamepad_released: function(index: number, gamepad_button: GamepadButton): boolean
    get_gamepad_axis: function(index: number, gamepad_axis: GamepadAxis): number
    set_mastervolume: function(mastervolume: number)
    get_mastervolume: function(): number
    load_music: function(music_path: string): Music
    play_music: function(music: Music)
    pause_music: function(music: Music)
    resume_music: function(music: Music)
    stop_music: function(music: Music)
    is_music_playing: function(music: Music): boolean
    get_music_length: function(music: Music): number
    get_music_length_played: function(music: Music): number
    seek_music: function(music: Music, secs: number)
    set_music_volume: function(music: Music, volume: number)
    set_music_pan: function(music: Music, pan: number)
    set_music_pitch: function(music: Music, pitch: number)
    get_music_volume: function(music: Music): number
    get_music_pan: function(music: Music): number
    get_music_pitch: function(music: Music): number
    load_sound: function(sound_path: string): Sound
    clone_sound: function(orig: Sound): Sound
    play_sound: function(sound: Sound)
    pause_sound: function(sound: Sound)
    resume_sound: function(sound: Sound)
    stop_sound: function(sound: Sound)
    is_sound_playing: function(sound: Sound): boolean
    set_sound_volume: function(sound: Sound, volume: number)
    set_sound_pan: function(sound: Sound, pan: number)
    set_sound_pitch: function(sound: Sound, pitch: number)
    get_sound_volume: function(sound: Sound): number
    get_sound_pan: function(sound: Sound): number
    get_sound_pitch: function(sound: Sound): number
    load_textfile: function(file_path: string): string
    save_textfile: function(file_path: string, data: string)
    save_textfile_append: function(file_path: string, data: string)
    push_matrix: function()
    pop_matrix: function()
    reset_matrix: function()
    translate: function(delta_x: number, delta_y: number)
    rotate: function(angle: number)
    rotate_at: function(angle: number, x: number, y: number)
    scale: function(scale_x: number, scale_y: number)
    scale_at: function(scale_x: number, scale_y: number, x: number, y: number)
    set_default_blendmode: function(blendmode: BlendMode)
    set_blendmode: function(blendmode: BlendMode)
    reset_blendmode: function()
    set_default_filtermode: function(filtermode: FilterMode)
    set_filtermode: function(filtermode: FilterMode)
    reset_filtermode: function()
    new_shader: function(shaderdef: ShaderDef): Shader
    set_shader: function(shader: Shader)
    reset_shader: function()
    set_shader_uniform: function(shader: Shader, uniform_name: string, uniform_value: ShaderUniformValue)
    reset_shader_uniform: function(shader: Shader, uniform_name: string)
    new_shaderbuilder: function(): ShaderBuilder
    shaderbuilder_uniform: function(shaderbuilder: ShaderBuilder, uniform_name: string, uniform_type: UniformType)
    shaderbuilder_vertex: function(shaderbuilder: ShaderBuilder, vertex_code: string)
    shaderbuilder_fragment: function(shaderbuilder: ShaderBuilder, fragment_code: string)
    shaderbuilder_build: function(shaderbuilder: ShaderBuilder): Shader
    -- lists
    -- tuples
    type FloatVec4 = {number}
    -- dicts
    type UniformNamesToTypes = {string: UniformType}
    -- variants
    type ShaderUniformValue = number | FloatVec4 | Image
    -- records
    record Image
        userdata
        width: number
        height: number
        is_canvas: boolean
    end
    record ImageBatch
        userdata
        rect_count: number
        add_rect: function (imagebatch: ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
        draw: function (imagebatch: ImageBatch)
        reset: function (imagebatch: ImageBatch)
    end
    record Font
        userdata
    end
    record Music
        userdata
        playing: boolean
        length: number
        length_played: number
        pan: number
        pitch: number
        volume: number
        play: function (music: Music)
        pause: function (music: Music)
        resume: function (music: Music)
        stop: function (music: Music)
        seek: function (music: Music, secs: number)
    end
    record Sound
        userdata
        pan: number
        pitch: number
        volume: number
        clone: function (orig: Sound): Sound
        pause: function (sound: Sound)
        play: function (sound: Sound)
        resume: function (sound: Sound)
        stop: function (sound: Sound)
    end
    record Shader
        userdata
        set: function (shader: Shader, uniform_name: string, uniform_value: ShaderUniformValue)
        reset: function (shader: Shader, uniform_name: string)
    end
    record ShaderDef
        userdata
        frag: string
        vert: string
        uniforms: UniformNamesToTypes
    end
    record ShaderBuilder
        userdata
        uniform: function (shaderbuilder: ShaderBuilder, uniform_name: string, uniform_type: UniformType)
        vertex: function (shaderbuilder: ShaderBuilder, vertex_code: string)
        fragment: function (shaderbuilder: ShaderBuilder, fragment_code: string)
        build: function (shaderbuilder: ShaderBuilder): Shader
    end
    -- enums
    enum UniformType
        "_invalid"  "float"  "vec2"  "vec3"  "vec4"  "int"  "ivec2"  "ivec3"  "ivec4"  "mat4"  "sampler2D"
        
    end
    enum BlendMode
        "none"  "blend"  "add"  "mod"  "mul" 
    end
    enum FilterMode
        "_invalid"  "nearest"  "linear" 
    end
    enum GamepadAxis
        "left_x"  "left_y"  "right_x"  "right_y"  "left_trigger"  "right_trigger" 
    end
    enum GamepadButton
        "pad_a"  "pad_b"  "pad_x"  "pad_y"  "left_bumper"  "right_bumper"  "back"  "start"  "guide"  "left_thumb" 
        "right_thumb"  "dpad_up"  "dpad_right"  "dpad_down"  "dpad_left" 
    end
    enum MouseButton
        "mb1"  "mb2"  "mb3"  "mb4"  "mb5"  "mb6"  "mb7"  "mb8" 
    end
    enum KeyboardKey
        "space"  "'"  ","  "-"  "."  "/"  "0"  "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  ";"  "=" 
        "a"  "b"  "c"  "d"  "e"  "f"  "g"  "h"  "i"  "j"  "k"  "l"  "m"  "n"  "o"  "p"  "q"  "r"  "s" 
        "t"  "u"  "v"  "w"  "x"  "y"  "z"  "["  "\\"  "]"  "`"  "world_1"  "world_2"  "escape"  "enter" 
        "tab"  "backspace"  "insert"  "delete"  "right"  "left"  "down"  "up"  "page_up"  "page_down" 
        "home"  "end"  "caps_lock"  "scroll_lock"  "num_lock"  "print_screen"  "pause"  "f1"  "f2"  "f3" 
        "f4"  "f5"  "f6"  "f7"  "f8"  "f9"  "f10"  "f11"  "f12"  "f13"  "f14"  "f15"  "f16"  "f17"  "f18" 
        "f19"  "f20"  "f21"  "f22"  "f23"  "f24"  "f25"  "kp_0"  "kp_1"  "kp_2"  "kp_3"  "kp_4"  "kp_5" 
        "kp_6"  "kp_7"  "kp_8"  "kp_9"  "kp_decimal"  "kp_divide"  "kp_multiply"  "kp_subtract"  "kp_add" 
        "kp_enter"  "kp_equal"  "left_shift"  "left_control"  "left_alt"  "left_super"  "right_shift" 
        "right_control"  "right_alt"  "right_super"  "menu" 
    end
end

