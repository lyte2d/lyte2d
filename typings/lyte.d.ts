declare namespace lyte {
    // functions
    function tick(delta_time: number, window_width: number, window_height: number, window_resized: boolean): void
    function quit(): void
    function cls(r: number, g: number, b: number, a: number): void
    function set_color(r: number, g: number, b: number, a: number): void
    function reset_color(): void
    function draw_point(x: number, y: number): void
    function draw_line(x1: number, y1: number, x2: number, y2: number): void
    function draw_rect(dest_x: number, dest_y: number, rect_width: number, rect_height: number): void
    function draw_rect_line(dest_x: number, dest_y: number, rect_width: number, rect_height: number): void
    function draw_circle(dest_x: number, dest_y: number, radius: number): void
    function draw_circle_line(dest_x: number, dest_y: number, radius: number): void
    function load_image(image_path: string): Image
    function draw_image(image: Image, dest_x: number, dest_y: number): void
    function draw_image_rect(image: Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number): void
    function get_image_width(image: Image): number
    function get_image_height(image: Image): number
    function new_canvas(width: number, height: number): Image
    function set_canvas(canvas_image: Image): void
    function reset_canvas(): void
    function is_image_canvas(image: Image): boolean
    function load_font(font_path: string, size: number): Font
    function set_font(font: Font): void
    function reset_font(): void
    function draw_text(text: string, dest_x: number, dest_y: number): void
    function get_text_width(text: string): number
    function get_text_height(text: string): number
    function get_monitor_count(): number
    function get_monitor_name(index: number): string
    function get_monitor_width(index: number): number
    function get_monitor_height(index: number): number
    function set_window_monitor(index: number): void
    function set_window_resizable(resizable: boolean): void
    function set_window_minsize(width: number, height: number): void
    function set_window_size(width: number, height: number): void
    function get_window_width(): number
    function get_window_height(): number
    function set_window_position(x: number, y: number): void
    function set_fullscreen(fullscreen: boolean): void
    function is_fullscreen(): boolean
    function set_window_title(title: string): void
    function set_window_vsync(vsync: boolean): void
    function is_window_vsync(): boolean
    function set_window_icon_file(icon_path: string): void
    function set_window_margins(left: number, right: number, top: number, bottom: number): void
    function set_window_paddings(left: number, right: number, top: number, bottom: number): void
    function is_key_down(key: KeyboardKey): boolean
    function is_key_pressed(key: KeyboardKey): boolean
    function is_key_released(key: KeyboardKey): boolean
    function is_key_repeat(key: KeyboardKey): boolean
    function is_mouse_down(mouse_button: MouseButton): boolean
    function is_mouse_pressed(mouse_button: MouseButton): boolean
    function is_mouse_released(mouse_button: MouseButton): boolean
    function get_mouse_x(): number
    function get_mouse_y(): number
    function get_gamepad_count(): number
    function get_gamepad_name(index: number): string
    function is_gamepad_down(index: number, gamepad_button: GamepadButton): boolean
    function is_gamepad_pressed(index: number, gamepad_button: GamepadButton): boolean
    function is_gamepad_released(index: number, gamepad_button: GamepadButton): boolean
    function get_gamepad_axis(index: number, gamepad_axis: GamepadAxis): number
    function set_mastervolume(mastervolume: number): void
    function get_mastervolume(): number
    function load_music(music_path: string): Music
    function play_music(music: Music): void
    function pause_music(music: Music): void
    function resume_music(music: Music): void
    function stop_music(music: Music): void
    function is_music_playing(music: Music): boolean
    function get_music_length(music: Music): number
    function get_music_length_played(music: Music): number
    function seek_music(music: Music, secs: number): void
    function set_music_volume(music: Music, volume: number): void
    function set_music_pan(music: Music, pan: number): void
    function set_music_pitch(music: Music, pitch: number): void
    function get_music_volume(music: Music): number
    function get_music_pan(music: Music): number
    function get_music_pitch(music: Music): number
    function load_sound(sound_path: string): Sound
    function clone_sound(orig: Sound): Sound
    function play_sound(sound: Sound): void
    function pause_sound(sound: Sound): void
    function resume_sound(sound: Sound): void
    function stop_sound(sound: Sound): void
    function is_sound_playing(sound: Sound): boolean
    function set_sound_volume(sound: Sound, volume: number): void
    function set_sound_pan(sound: Sound, pan: number): void
    function set_sound_pitch(sound: Sound, pitch: number): void
    function get_sound_volume(sound: Sound): number
    function get_sound_pan(sound: Sound): number
    function get_sound_pitch(sound: Sound): number
    function load_textfile(file_path: string): string
    function save_textfile(file_path: string, data: string): void
    function save_textfile_append(file_path: string, data: string): void
    function push_matrix(): void
    function pop_matrix(): void
    function reset_matrix(): void
    function translate(delta_x: number, delta_y: number): void
    function rotate(angle: number): void
    function rotate_at(angle: number, x: number, y: number): void
    function scale(scale_x: number, scale_y: number): void
    function scale_at(scale_x: number, scale_y: number, x: number, y: number): void
    function set_default_blendmode(blendmode: BlendMode): void
    function set_blendmode(blendmode: BlendMode): void
    function reset_blendmode(): void
    function set_default_filtermode(filtermode: FilterMode): void
    function set_filtermode(filtermode: FilterMode): void
    function reset_filtermode(): void
    function new_shader(shaderdef: ShaderDef): Shader
    function set_shader(shader: Shader): void
    function reset_shader(): void
    function set_shader_uniform(shader: Shader, uniform_name: string, uniform_value: ShaderUniformValue): void
    function reset_shader_uniform(shader: Shader, uniform_name: string): void
    function new_shaderbuilder(): ShaderBuilder
    function shaderbuilder_uniform(shaderbuilder: ShaderBuilder, uniform_name: string, uniform_type: UniformType): void
    function shaderbuilder_vertex(shaderbuilder: ShaderBuilder, vertex_code: string): void
    function shaderbuilder_fragment(shaderbuilder: ShaderBuilder, fragment_code: string): void
    function shaderbuilder_build(shaderbuilder: ShaderBuilder): Shader
    // lists
    // tuples
    type FloatVec4 = number[]
    // dicts
    type UniformNamesToTypes = {[key: string]: UniformType}
    // variants
    type ShaderUniformValue = number | FloatVec4 | Image
    // records
    type Image = {
        width: number
        height: number
        is_canvas: boolean
    }
    type Font = {
    }
    type Music = {
        playing: boolean
        length: number
        length_played: number
        pan: number
        pitch: number
        volume: number
        play: (music: Music) => void
        pause: (music: Music) => void
        resume: (music: Music) => void
        stop: (music: Music) => void
        seek: (music: Music, secs: number) => void
    }
    type Sound = {
        pan: number
        pitch: number
        volume: number
        clone: (orig: Sound) => Sound
        pause: (sound: Sound) => void
        play: (sound: Sound) => void
        resume: (sound: Sound) => void
        stop: (sound: Sound) => void
    }
    type Shader = {
        set: (shader: Shader, uniform_name: string, uniform_value: ShaderUniformValue) => void
        reset: (shader: Shader, uniform_name: string) => void
    }
    type ShaderDef = {
        frag: string
        vert: string
        uniforms: UniformNamesToTypes
    }
    type ShaderBuilder = {
        uniform: (shaderbuilder: ShaderBuilder, uniform_name: string, uniform_type: UniformType) => void
        vertex: (shaderbuilder: ShaderBuilder, vertex_code: string) => void
        fragment: (shaderbuilder: ShaderBuilder, fragment_code: string) => void
        build: (shaderbuilder: ShaderBuilder) => Shader
    }
    // enums
    type UniformType = 
        "_invalid" | "float" | "vec2" | "vec3" | "vec4" | "int" | "ivec2" | "ivec3" | "ivec4" | "mat4" |
        "sampler2D" 
    type BlendMode = 
        "none" | "blend" | "add" | "mod" | "mul" 
    type FilterMode = 
        "_invalid" | "nearest" | "linear" 
    type GamepadAxis = 
        "left_x" | "left_y" | "right_x" | "right_y" | "left_trigger" | "right_trigger" 
    type GamepadButton = 
        "pad_a" | "pad_b" | "pad_x" | "pad_y" | "left_bumper" | "right_bumper" | "back" | "start" | "guide" |
        "left_thumb" | "right_thumb" | "dpad_up" | "dpad_right" | "dpad_down" | "dpad_left" 
    type MouseButton = 
        "mb1" | "mb2" | "mb3" | "mb4" | "mb5" | "mb6" | "mb7" | "mb8" 
    type KeyboardKey = 
        "space" | "'" | "," | "-" | "." | "/" | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" |
        "9" | ";" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" |
        "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "[" | "\\" | "]" |
        "`" | "world_1" | "world_2" | "escape" | "enter" | "tab" | "backspace" | "insert" | "delete" |
        "right" | "left" | "down" | "up" | "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" |
        "num_lock" | "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" |
        "f9" | "f10" | "f11" | "f12" | "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" |
        "f21" | "f22" | "f23" | "f24" | "f25" | "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" |
        "kp_6" | "kp_7" | "kp_8" | "kp_9" | "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" |
        "kp_add" | "kp_enter" | "kp_equal" | "left_shift" | "left_control" | "left_alt" | "left_super" |
        "right_shift" | "right_control" | "right_alt" | "right_super" | "menu" 
    }

