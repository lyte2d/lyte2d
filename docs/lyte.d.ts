declare namespace lyte {
    function tick(delta_time: number, window_width: integer, window_height: integer, window_resized: boolean): void;
    function cls(r: number, g: number, b: number, a: number): void;
    function draw_circle(dest_x: integer, dest_y: integer, radius: integer): void;
    function draw_circle_line(dest_x: integer, dest_y: integer, radius: integer): void;
    function draw_image(image: Image, dest_x: integer, dest_y: integer): void;
    function draw_image_rect(image: Image, dest_x: integer, dest_y: integer, src_x: integer, src_y: integer, rect_width: integer, rect_height: integer): void;
    function draw_line(x1: integer, y1: integer, x2: integer, y2: integer): void;
    function draw_point(x: integer, y: integer): void;
    function draw_rect(dest_x: integer, dest_y: integer, rect_width: integer, rect_height: integer): void;
    function draw_rect_line(dest_x: integer, dest_y: integer, rect_width: integer, rect_height: integer): void;
    function draw_text(text: string, dest_x: integer, dest_y: integer): void;
    function get_gamepad_axis(index: integer, gamepad_axis: GamepadAxis): number;
    function get_gamepad_count(): integer;
    function get_gamepad_name(index: integer): string;
    function get_mastervolume(): number;
    function get_mouse_x(): integer;
    function get_mouse_y(): integer;
    function get_music_length(music: Music): number;
    function get_music_length_played(music: Music): number;
    function get_music_pan(music: Music): number;
    function get_music_pitch(music: Music): number;
    function get_music_volume(music: Music): number;
    function get_sound_pan(sound: Sound): number;
    function get_sound_pitch(sound: Sound): number;
    function get_sound_volume(sound: Sound): number;
    function get_sounddata_pan(sounddata: SoundData): number;
    function get_sounddata_pitch(sounddata: SoundData): number;
    function get_sounddata_volume(sounddata: SoundData): number;
    function get_text_width(text: string): integer;
    function get_text_height(text: string): integer;
    function get_window_width(): integer;
    function get_window_height(): integer;
    function is_fullscreen(): boolean;
    function is_gamepad_down(index: integer, gamepad_button: GamepadButton): boolean;
    function is_gamepad_pressed(index: integer, gamepad_button: GamepadButton): boolean;
    function is_gamepad_released(index: integer, gamepad_button: GamepadButton): boolean;
    function is_key_down(key: KeyboardKey): boolean;
    function is_key_pressed(key: KeyboardKey): boolean;
    function is_key_released(key: KeyboardKey): boolean;
    function is_key_repeat(key: KeyboardKey): boolean;
    function is_mouse_down(mouse_button: MouseButton): boolean;
    function is_mouse_pressed(mouse_button: MouseButton): boolean;
    function is_mouse_released(mouse_button: MouseButton): boolean;
    function is_music_playing(music: Music): boolean;
    function is_sound_playing(sound: Sound): boolean;
    function is_window_vsync(): boolean;
    function load_file(file_path: string): string;
    function load_font(font_path: string, size: number): Font;
    function load_image(image_path: string): Image;
    function load_music(music_path: string): Music;
    function load_sounddata(sounddata_path: string): SoundData;
    function new_canvas(width: integer, height: integer): Canvas;
    function new_shader(shaderdef: ShaderDef): Shader;
    function new_sound(sounddata: SoundData): Sound;
    function pause_music(music: Music): void;
    function pause_sound(sound: Sound): void;
    function play_music(music: Music): void;
    function play_sound(sound: Sound): void;
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
    function resume_music(music: Music): void;
    function resume_sound(sound: Sound): void;
    function rotate(angle: number): void;
    function rotate_at(angle: number, x: integer, y: integer): void;
    function save_file_append(file_path: string, data: string): void;
    function save_file_write(file_path: string, data: string): void;
    function scale(scale_x: number, scale_y: number): void;
    function scale_at(scale_x: integer, scale_y: integer, x: number, y: number): void;
    function seek_music(music: Music, secs: number): void;
    function send_shader_uniforms(shader: Shader, uniforms: ShaderUniforms): void;
    function set_blendmode(blendmode: BlendMode): void;
    function set_canvas(canvas: Canvas): void;
    function set_color(r: number, g: number, b: number, a: number): void;
    function set_default_blendmode(blendmode: BlendMode): void;
    function set_default_filtermode(filtermode: FilterMode): void;
    function set_filtermode(filtermode: FilterMode): void;
    function set_font(font: Font): void;
    function set_fullscreen(fullscreen: boolean): void;
    function set_mastervolume(mastervolume: number): void;
    function set_music_pan(music: Music, pan: number): void;
    function set_music_pitch(music: Music, pitch: number): void;
    function set_music_volume(music: Music, volume: number): void;
    function set_shader(shader: Shader): void;
    function set_sound_pan(sound: Sound, pan: number): void;
    function set_sound_pitch(sound: Sound, pitch: number): void;
    function set_sound_volume(sound: Sound, volume: number): void;
    function set_sounddata_pan(sounddata: SoundData, pan: number): void;
    function set_sounddata_pitch(sounddata: SoundData, pitch: number): void;
    function set_sounddata_volume(sounddata: SoundData, volume: number): void;
    function set_window_icon(icon_path: string): void;
    function set_window_margins(left: integer, right: integer, top: integer, bottom: integer): void;
    function set_window_minsize(width: integer, height: integer): void;
    function set_window_paddings(left: integer, right: integer, top: integer, bottom: integer): void;
    function set_window_size(width: integer, height: integer): void;
    function set_window_title(title: string): void;
    function set_window_vsync(vsync: boolean): void;
    function stop_music(music: Music): void;
    function stop_sound(sound: Sound): void;
    function translate(delta_x: integer, delta_y: integer): void;
    interface Canvas {
        image: Image;
        width: integer;
        height: integer;
    };
    interface Font {
    };
    interface Image {
        width: integer;
        height: integer;
    };
    interface Music {
        playing: boolean;
        length: number;
        length_played: number;
        pan: number;
        pitch: number;
        volume: number;
        play: () => (void);
        pause: () => (void);
        resume: () => (void);
        stop: () => (void);
        seek: (secs: number) => (void);
    };
    interface Sound {
        pan: number;
        pitch: number;
        volume: number;
        pause: () => (void);
        play: () => (void);
        resume: () => (void);
        stop: () => (void);
    };
    interface SoundData {
        pan: number;
        pitch: number;
        volume: number;
    };
    interface ShaderDef {
        frag: string;
        vert: string;
        uniforms: {[key: string]: UniformType};
    };
    interface Shader {
        send: (uniforms: ShaderUniforms) => (void);
    };
    type ShaderUniforms = {[key: string]: integer | number | integer[] | number[] | Image};
    type UniformType =
        'float'  | 'vec2'  | 'vec3'  | 'vec4'  | 'int'  | 'ivec2'  | 'ivec3'  | 'ivec4'  | 'mat4'  | 'sampler2D' ;
    type BlendMode =
        'blend'  | 'add'  | 'mod'  | 'mul'  | 'none' ;
    type FilterMode =
        'nearest'  | 'linear' ;
    type GamepadAxis =
        'left_x'  | 'left_y'  | 'right_x'  | 'right_y'  | 'left_trigger'  | 'right_trigger' ;
    type GamepadButton =
        'pad_a'  | 'pad_b'  | 'pad_x'  | 'pad_y'  | 'left_bumper'  | 'right_bumper'  | 'back'  | 'start'  |
        'guide'  | 'left_thumb'  | 'right_thumb'  | 'dpad_up'  | 'dpad_right'  | 'dpad_down'  | 'dpad_left' ;
    type MouseButton =
        'mb1'  | 'mb2'  | 'mb3'  | 'mb4'  | 'mb5'  | 'mb6'  | 'mb7'  | 'mb8' ;
    type KeyboardKey =
        'space'  | '\''  | ','  | '-'  | '.'  | '/'  | '0'  | '1'  | '2'  | '3'  | '4'  | '5'  | '6'  | '7'  | '8'  |
        '9'  | ', '  | '='  | 'a'  | 'b'  | 'c'  | 'd'  | 'e'  | 'f'  | 'g'  | 'h'  | 'i'  | 'j'  | 'k'  | 'l'  |
        'm'  | 'n'  | 'o'  | 'p'  | 'q'  | 'r'  | 's'  | 't'  | 'u'  | 'v'  | 'w'  | 'x'  | 'y'  | 'z'  | '['  | '\\'  |
        ']'  | '`'  | 'world_1'  | 'world_2'  | 'escape'  | 'enter'  | 'tab'  | 'backspace'  | 'insert'  | 'delete'  |
        'right'  | 'left'  | 'down'  | 'up'  | 'page_up'  | 'page_down'  | 'home'  | 'end'  | 'caps_lock'  | 'scroll_lock'  |
        'num_lock'  | 'print_screen'  | 'pause'  | 'f1'  | 'f2'  | 'f3'  | 'f4'  | 'f5'  | 'f6'  | 'f7'  | 'f8'  | 'f9'  |
        'f10'  | 'f11'  | 'f12'  | 'f13'  | 'f14'  | 'f15'  | 'f16'  | 'f17'  | 'f18'  | 'f19'  | 'f20'  | 'f21'  | 'f22'  |
        'f23'  | 'f24'  | 'f25'  | 'kp_0'  | 'kp_1'  | 'kp_2'  | 'kp_3'  | 'kp_4'  | 'kp_5'  | 'kp_6'  | 'kp_7'  | 'kp_8'  |
        'kp_9'  | 'kp_decimal'  | 'kp_divide'  | 'kp_multiply'  | 'kp_subtract'  | 'kp_add'  | 'kp_enter'  | 'kp_equal'  |
        'left_shift'  | 'left_control'  | 'left_alt'  | 'left_super'  | 'right_shift'  | 'right_control'  | 'right_alt'  |
        'right_super'  | 'menu' ;
}

