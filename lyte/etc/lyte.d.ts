
 declare namespace lyte {
    // frame function is expected to be implemented by the user
    function frame(dt: number, width: number, height: number, resized: boolean): void;
    function clear(r: number, g: number, b: number, a: number): void;
    function draw_circle(x: number, y: number, radius: number): void;
    function draw_circle_filled(x: number, y: number, radius: number): void;
    function draw_image(image: lyte.Image, x: number, y: number): void;
    function draw_imagerect(image: lyte.Image, x: number, y: number, rect_x: number, rect_y: number, rect_width: number, rect_height: number): void;
    function draw_line(x1: number, y1: number, x2: number, y2: number): void;
    function draw_lines(lines: lyte.Line[]): void;
    function draw_point(x: number, y: number): void;
    function draw_points(points: lyte.Point[]): void;
    function draw_rect(x: number, y: number, width: number, height: number): void;
    function draw_rect_filled(x: number, y: number, width: number, height: number): void;
    function draw_rects_filled(rects: lyte.Rect[]): void;
    function draw_striplines(points: lyte.Point[]): void;
    function draw_striptriangles_filled(triangles: lyte.Triangle[]): void;
    function draw_text(text: string, x: number, y: number): (number, number);
    function draw_triangles_filled(triangles: lyte.Triangle[]): void;
    function file_append(path: string, data: string): void;
    function file_read(path: string): (string);
    function file_write(path: string, data: string): void;
    function get_fullscreen(): (boolean);
    function get_gamepadaxis(index: number, gamepadaxis: lyte.GamepadAxis): (number);
    function get_gamepadname(index: number): (string);
    function get_mastervolume(): (number);
    function get_mouse(): (number, number);
    function get_musiclength(music: lyte.Music): (number);
    function get_musiclength_played(music: lyte.Music): (number);
    function get_musicpan(music: lyte.Music): (number);
    function get_musicpitch(music: lyte.Music): (number);
    function get_musicvolume(music: lyte.Music): (number);
    function get_sounddatapan(sounddata: lyte.SoundData): (number);
    function get_sounddatapitch(sounddata: lyte.SoundData): (number);
    function get_sounddatavolume(sounddata: lyte.SoundData): (number);
    function get_soundpan(sound: lyte.Sound): (number);
    function get_soundpitch(sound: lyte.Sound): (number);
    function get_soundvolume(sound: lyte.Sound): (number);
    function get_vsync(): (boolean);
    function get_windowheight(): (number);
    function get_windowwidth(): (number);
    function identity_matrix(): void;
    function is_gamepaddown(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_gamepadpressed(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_gamepadreleased(index: number, gamepadbutton: lyte.GamepadButton): (boolean);
    function is_keydown(key: lyte.KeyboardKey): (boolean);
    function is_keypressed(key: lyte.KeyboardKey): (boolean);
    function is_keyreleased(key: lyte.KeyboardKey): (boolean);
    function is_keyrepeat(key: lyte.KeyboardKey): (boolean);
    function is_mousedown(mousebutton: lyte.MouseButton): (boolean);
    function is_mousepressed(mousebutton: lyte.MouseButton): (boolean);
    function is_mousereleased(mousebutton: lyte.MouseButton): (boolean);
    function is_musicplaying(music: lyte.Music): (boolean);
    function is_soundplaying(sound: lyte.Sound): (boolean);
    function load_font(path: string, size: number): (lyte.Font);
    function load_image(path: string): (lyte.Image);
    function load_music(path: string): (lyte.Music);
    function load_sounddata(path: string): (lyte.SoundData);
    function measure_text(text: string): (number, number);
    function new_canvas(width: number, height: number): (lyte.Canvas);
    function new_shader(shaderdef: lyte.ShaderDef): (lyte.Shader);
    function new_sound(): (lyte.Sound);
    function num_gamepads(): (number);
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
    function reset_shader(): void;
    function resume_music(music: lyte.Music): void;
    function resume_sound(sound: lyte.Sound): void;
    function rotate(r: number): void;
    function rotate_at(r: number, x: number, y: number): void;
    function scale(sx: number, sy: number): void;
    function scale_at(sx: number, sy: number, x: number, y: number): void;
    function seek_music(music: lyte.Music, secs: number): void;
    function send_shader(shader: lyte.Shader, uniforms: lyte.ShaderUniforms): void;
    function set_blendmode(blendmode: lyte.BlendMode): void;
    function set_canvas(canvas: lyte.Canvas): void;
    function set_color(r: number, g: number, b: number, a: number): void;
    function set_defaultblendmode(blendmode: lyte.BlendMode): void;
    function set_defaultfiltermode(filtermode: lyte.FilterMode): void;
    function set_filtermode(filtermode: lyte.FilterMode): void;
    function set_font(font: lyte.Font): void;
    function set_fullscreen(fullscreen: boolean): void;
    function set_margins(left: number, right: number, top: number, bottom: number): void;
    function set_mastervolume(mastervolume: number): void;
    function set_musicpan(music: lyte.Music, pan: number): (number);
    function set_musicpitch(music: lyte.Music, pitch: number): (number);
    function set_musicvolume(music: lyte.Music, volume: number): (number);
    function set_paddings(left: number, right: number, top: number, bottom: number): void;
    function set_shader(shader: lyte.Shader): void;
    function set_sounddatapan(sounddata: lyte.SoundData, pan: number): (number);
    function set_sounddatapitch(sounddata: lyte.SoundData, pitch: number): (number);
    function set_sounddatavolume(sounddata: lyte.SoundData, volume: number): (number);
    function set_soundpan(sound: lyte.Sound, pan: number): (number);
    function set_soundpitch(sound: lyte.Sound, pitch: number): (number);
    function set_soundvolume(sound: lyte.Sound, volume: number): (number);
    function set_vsync(vsync: boolean): void;
    function set_windowicon(icon: string): void;
    function set_windowminsize(width: number, height: number): void;
    function set_windowsize(width: number, height: number): void;
    function set_windowtitle(title: string): void;
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
    interface Line {
        x1: number;
        x2: number;
        y1: number;
        y2: number;
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
    interface Point {
        x: number;
        y: number;
    };
    interface Rect {
        h: number;
        w: number;
        x: number;
        y: number;
    };
    interface Shader {
        send: (self, uniforms: lyte.ShaderUniforms) => void;
    };
    interface ShaderDef {
        frag: string;
        ver: string;
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
    interface Triangle {
        x1: number;
        x2: number;
        x3: number;
        y1: number;
        y2: number;
        y3: number;
    };
    type BlendMode =
        'blend' | 'add' | 'mod' | 'mul' | 'none';
    type FilterMode =
        'nearest' | 'linear';
    type GamepadAxis =
        'axis_left_x' | 'axis_left_y' | 'axis_right_x' | 'axis_right_y' | 'axis_trigger_left' | 'axis_trigger_right';
    type GamepadButton =
        'but_a' | 'but_b' | 'but_x' | 'but_y' | 'but_leftbumper' | 'but_rightbumper' |
        'but_back' | 'but_start' | 'but_guide' | 'but_leftthumb' | 'but_righthumb' | 'but_dpad_up' |
        'but_dpad_right' | 'but_dpad_down' | 'but_dpad_left';
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
        'm_1' | 'm_2' | 'm_3' | 'm_4' | 'm_5' | 'm_6' |
        'm_7' | 'm_8';
    type UniformType =
        'float' | 'vec2' | 'vec3' | 'vec4' | 'int' | 'ivec2' |
        'ivec3' | 'ivec4' | 'mat4' | 'sampler2D';
};

