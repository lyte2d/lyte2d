
 declare namespace lyte {
    function tick(delta_time: number, window_width: number, window_height: number, window_resized: boolean): void;
    function cls(r: number, g: number, b: number, a: number): void;
    function draw_circle(dest_x: number, dest_y: number, radius: number): void;
    function draw_circle_line(dest_x: number, dest_y: number, radius: number): void;
    function draw_image(image: lyte.Image, dest_x: number, dest_y: number): void;
    function draw_image_rect(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, src_width: number, src_height: number): void;
    function draw_line(x1: number, y1: number, x2: number, y2: number): void;
    function draw_point(dest_x: number, dest_y: number): void;
    function draw_rect(dest_x: number, dest_y: number, width: number, height: number): void;
    function draw_rect_line(dest_x: number, dest_y: number, width: number, height: number): void;
    function draw_text(text: string, dest_x: number, dest_y: number): void;
    function get_gamepad_axis(index: number, gamepadaxis: lyte.GamepadAxis): (number);
    function get_gamepad_count(): (number);
    function get_gamepad_name(index: number): (string);
    function get_mastervolume(): (number);
    function get_mouse_position(): (number, number);
    function get_music_length(music: lyte.Music): (number);
    function get_music_length_played(music: lyte.Music): (number);
    function get_music_pan(music: lyte.Music): (number);
    function get_music_pitch(music: lyte.Music): (number);
    function get_music_volume(music: lyte.Music): (number);
    function get_sound_pan(sound: lyte.Sound): (number);
    function get_sound_pitch(sound: lyte.Sound): (number);
    function get_sound_volume(sound: lyte.Sound): (number);
    function get_sounddata_pan(sounddata: lyte.SoundData): (number);
    function get_sounddata_pitch(sounddata: lyte.SoundData): (number);
    function get_sounddata_volume(sounddata: lyte.SoundData): (number);
    function get_text_size(text: string): (number, number);
    function get_window_size(): (number, number);
    function is_fullscreen(): (boolean);
    function is_gamepad_down(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_gamepad_pressed(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_gamepad_released(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_key_down(key: lyte.KeyboardKey): (boolean);
    function is_key_pressed(key: lyte.KeyboardKey): (boolean);
    function is_key_released(key: lyte.KeyboardKey): (boolean);
    function is_key_repeat(key: lyte.KeyboardKey): (boolean);
    function is_mouse_down(mousebutton: lyte.MouseButton): (boolean);
    function is_mouse_pressed(mousebutton: lyte.MouseButton): (boolean);
    function is_mouse_released(mousebutton: lyte.MouseButton): (boolean);
    function is_music_playing(music: lyte.Music): (boolean);
    function is_sound_playing(sound: lyte.Sound): (boolean);
    function is_window_vsync(): (boolean);
    function load_file(file_path: string): (string);
    function load_font(font_path: string, size: number): (lyte.Font);
    function load_image(image_path: string): (lyte.Image);
    function load_music(music_path: string): (lyte.Music);
    function load_sounddata(path: string): (lyte.SoundData);
    function new_canvas(width: number, height: number): (lyte.Canvas);
    function new_shader(shaderdef: lyte.ShaderDef): (lyte.Shader);
    function new_sound(): (lyte.Sound);
    function pause_music(music: lyte.Music): void;
    function pause_sound(sound: lyte.Sound): void;
    function play_music(music: lyte.Music): void;
    function play_sound(sound: lyte.Sound): void;
    function pop_matrix(): void;
    function push_matrix(): void;
    function quit(): void;
    function reset_blendmode(): void;
    function reset_canvas(): void;
    function reset_color(): void;
    function reset_filtermode(): void;
    function reset_font(): void;
    function reset_matrix(): void;
    function reset_shader(): void;
    function resume_music(music: lyte.Music): void;
    function resume_sound(sound: lyte.Sound): void;
    function rotate(r: number): void;
    function rotate_at(r: number, x: number, y: number): void;
    function save_file_append(file_path: string, data: string): void;
    function save_file_write(file_path: string, data: string): void;
    function scale(sx: number, sy: number): void;
    function scale_at(sx: number, sy: number, x: number, y: number): void;
    function seek_music(music: lyte.Music, secs: number): void;
    function send_shader_uniforms(shader: lyte.Shader, uniforms: lyte.ShaderUniforms): void;
    function set_blendmode(blendmode: lyte.BlendMode): void;
    function set_canvas(canvas: lyte.Canvas): void;
    function set_color(r: number, g: number, b: number, a: number): void;
    function set_default_blendmode(blendmode: lyte.BlendMode): void;
    function set_default_filtermode(filtermode: lyte.FilterMode): void;
    function set_filtermode(filtermode: lyte.FilterMode): void;
    function set_font(font: lyte.Font): void;
    function set_fullscreen(fullscreen: boolean): void;
    function set_mastervolume(mastervolume: number): void;
    function set_music_pan(music: lyte.Music, pan: number): void;
    function set_music_pitch(music: lyte.Music, pitch: number): void;
    function set_music_volume(music: lyte.Music, volume: number): void;
    function set_shader(shader: lyte.Shader): void;
    function set_sound_pan(sound: lyte.Sound, pan: number): void;
    function set_sound_pitch(sound: lyte.Sound, pitch: number): void;
    function set_sound_volume(sound: lyte.Sound, volume: number): void;
    function set_sounddata_pan(sounddata: lyte.SoundData, pan: number): void;
    function set_sounddata_pitch(sounddata: lyte.SoundData, pitch: number): void;
    function set_sounddata_volume(sounddata: lyte.SoundData, volume: number): void;
    function set_window_icon(icon_path: string): void;
    function set_window_margins(left: number, right: number, top: number, bottom: number): void;
    function set_window_minsize(width: number, height: number): void;
    function set_window_paddings(left: number, right: number, top: number, bottom: number): void;
    function set_window_size(width: number, height: number): void;
    function set_window_title(title: string): void;
    function set_window_vsync(vsync: boolean): void;
    function stop_music(music: lyte.Music): void;
    function stop_sound(sound: lyte.Sound): void;
    function translate(dx: number, dy: number): void;
    type ShaderUniformValue = number | number[] | lyte.Image;
    type ShaderUniforms = {[key: string]: lyte.ShaderUniformValue};
    interface Canvas {
        image: lyte.Image;
        height: number;
        width: number;
    };
    interface Font {
    };
    interface Image {
        height: number;
        width: number;
    };
    interface Music {
        playing: boolean;
        length_played: number;
        pan: number;
        pitch: number;
        volume: number;
        pause: (self) => void;
        play: (self, loop: boolean) => void;
        resume: (self) => void;
        seek: (self, secs: number) => void;
        stop: (self) => void;
    };
    interface Shader {
        send: (self, uniforms: lyte.ShaderUniforms) => void;
    };
    interface ShaderDef {
        frag: string;
        vert: string;
        uniforms: {[key: string]: lyte.UniformType};
    };
    interface Sound {
        pan: number;
        pitch: number;
        volume: number;
        pause: (self) => void;
        play: (self, loop: boolean) => void;
        resume: (self) => void;
        stop: (self) => void;
    };
    interface SoundData {
        pan: number;
        pitch: number;
        volume: number;
    };
    type BlendMode = 
        'blend' | 'add' | 'mod' | 'mul' | 'none';
    type FilterMode = 
        'nearest' | 'linear';
    type GamepadAxis = 
        'left_x' | 'left_y' | 'right_x' | 'right_y' | 'left_trigger' | 'right_trigger';
    type GamepadButton = 
        'pad_a' | 'pad_b' | 'pad_x' | 'pad_y' | 'left_bumper' | 'right_bumper' | 
        'back' | 'start' | 'guide' | 'left_thumb' | 'right_thumb' | 'dpad_up' | 
        'dpad_right' | 'dpad_down' | 'dpad_left';
    type KeyboardKey = 
        'space' | "'" | ',' | '-' | '.' | '/' | 
        '0' | '1' | '2' | '3' | '4' | '5' | 
        '6' | '7' | '8' | '9' | ';' | '=' | 
        'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 
        'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 
        'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 
        's' | 't' | 'u' | 'v' | 'w' | 'x' | 
        'y' | 'z' | '[' | '\\' | ']' | '`' | 
        'world_1' | 'world_2' | 'escape' | 'enter' | 'tab' | 'backspace' | 
        'insert' | 'delete' | 'right' | 'left' | 'down' | 'up' | 
        'page_up' | 'page_down' | 'home' | 'end' | 'caps_lock' | 'scroll_lock' | 
        'num_lock' | 'print_screen' | 'pause' | 'f1' | 'f2' | 'f3' | 
        'f4' | 'f5' | 'f6' | 'f7' | 'f8' | 'f9' | 
        'f10' | 'f11' | 'f12' | 'f13' | 'f14' | 'f15' | 
        'f16' | 'f17' | 'f18' | 'f19' | 'f20' | 'f21' | 
        'f22' | 'f23' | 'f24' | 'f25' | 'kp_0' | 'kp_1' | 
        'kp_2' | 'kp_3' | 'kp_4' | 'kp_5' | 'kp_6' | 'kp_7' | 
        'kp_8' | 'kp_9' | 'kp_decimal' | 'kp_divide' | 'kp_multiply' | 'kp_subtract' | 
        'kp_add' | 'kp_enter' | 'kp_equal' | 'left_shift' | 'left_control' | 'left_alt' | 
        'left_super' | 'right_shift' | 'right_control' | 'right_alt' | 'right_super' | 'menu';
    type MouseButton = 
        'mb1' | 'mb2' | 'mb3' | 'mb4' | 'mb5' | 'mb6' | 
        'mb7' | 'mb8';
    type UniformType = 
        'float' | 'vec2' | 'vec3' | 'vec4' | 'int' | 'ivec2' | 
        'ivec3' | 'ivec4' | 'mat4' | 'sampler2D';
};

