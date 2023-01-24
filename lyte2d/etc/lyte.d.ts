/*
**  Lyte2D API
**
** (Using typescript syntax because Lua does not have static types)
*/
declare namespace lyte {

    // 'lyte.frame' function type. Should be defined by the user
    function frame(delta_time: number, width: number, height: number, resized: boolean): Nil;

    function quit(): Nil;

    function get_windowwidth(): number;
    function get_windowheight(): number;
    function set_windowsize(w: number, h: number);
    function set_windowminsize(w: number, h: number);
    function set_fullscreen(fullscreen: boolean);
    function get_fullscreen(): boolean;
    function set_windowtitle(title: string);
    function set_windowicon(path: string);
    function set_vsync(vsync: boolean): Nil;
    function get_vsync(): boolean;
    function set_margins(left: number, right: number, top: number, bottom: number);
    function set_paddings(left: number, right: number, top: number, bottom: number);

    function push_matrix();
    function pop_matrix();
    function identity_matrix();
    function translate(dx: number, dy: number);
    function rotate(r: number);
    function rotate_at(r: number, x: number, y: number);
    function scale(sx: number, sy: number);
    function scale_at(sx: number, sy: number, x: number, y: number);
    function clear(r: number,g: number,b: number,a: number);
    function set_color(r: number,g: number,b: number,a: number);
    function reset_color();
    function set_defaultblendmode(defaultblendmode: BlendMode);
    function set_blendmode(blendmode: BlendMode);
    function reset_blendmode();
    function set_defaultfiltermode(defaultfiltermode: FilterMode);
    function set_filtermode(filtermode: FilterMode);
    function reset_filtermode();
    function set_canvas(canvas: Canvas);
    function reset_canvas();

    function get_mastervolume(): number;
    function set_mastervolume(vol: number): number;

    function file_read(path: string): string;
    function file_write(path: string, data: string);
    function file_append(path: string, data: string);

    function load_font(path: string, size: number): Font;
    function set_font(font: Font);
    function reset_font();
    function draw_text(str: string, x: number, y: number): Tuple2<number, number>;
    function measure_text(str: string): Tuple2<number, number>;

    function draw_image(img: Image, x: number, y: number);
    function draw_imagerect(img: Image, x: number, y: number, im_x: number, im_y: number, im_w: number, im_h:number);
    function draw_point(x: number, y: number);
    function draw_points(pts: Point[]);
    function draw_line(x1: number, y1: number, x2: number, y2: number);
    function draw_lines(lines: Line[]);
    function draw_rect(x: number, y: number, w: number, h: number);
    function draw_rect_filled(x: number, y: number, w: number, h: number);
    function draw_circle(x: number, y: number, r: number);
    function draw_circle_filled(x: number, y: number, r: number);

    function draw_rects_filled(rects: Rect[]);
    function draw_triangles_filled(triangles: Triangle[]);
    function draw_striplines(pts: Point[]);
    function draw_striptriangles_filled(pts: Point[]);


    function is_keydown(keyboardkey: KeyboardKey): boolean;
    function is_keyrepeat(keyboardkey: KeyboardKey): boolean;
    function is_keypressed(keyboardkey: KeyboardKey): boolean;
    function is_keyreleased(keyboardkey: KeyboardKey): boolean;
    function is_mousedown(mousebut: MouseButton ): boolean;
    function is_mousepressed(mousebut: MouseButton ): boolean;
    function is_mousereleased(mousebut: MouseButton ): boolean;
    function get_mouse(): Tuple2<number, number>;
    function get_gamepadname(idx: number): string;
    function num_gamepads(): number;
    function is_gamepaddown(idx: number, gamepadkey: GamepadButton ): boolean;
    function is_gamepadpressed(idx: number, gamepadkey: GamepadButton ): boolean;
    function is_gamepadreleased(idx: number, gamepadkey: GamepadButton ): boolean;
    function get_gamepadaxis(idx: number, gamepadaxis: GamepadAxis): number;

    function get_musicvolume(mus: Music): number;
    function set_musicvolume(mus: Music, vol: number): number;
    function get_musicpitch(mus: Music): number;
    function set_musicpitch(mus: Music, pitch: number): number;
    function get_musicpan(mus: Music): number;
    function set_musicpan(vol: number, pan: number): number;
    function play_music(mus: Music);
    function pause_music(mus: Music);
    function resume_music(mus: Music);
    function stop_music(mus: Music);
    function seek_music(mus: Music,secs: number);
    function get_musiclength(mus: Music): number;
    function get_musiclength_played(mus: Music): number;
    function is_musicplaying(mus: Music): boolean;

    function get_sounddatavolume(sounddata: SoundData): number;
    function set_sounddatavolume(sounddata: SoundData, volume: number): number;
    function get_sounddatapitch(sounddata: SoundData): number;
    function set_sounddatapitch(sounddata: SoundData, volume: number): number;
    function get_sounddatapan(sounddata: SoundData): number;
    function set_sounddatapan(sounddata: SoundData, volume: number): number;

    function get_soundvolume(sound: Sound): number;
    function set_soundvolume(sound: Sound, volume: number): number;
    function get_soundpitch(sound: Sound): number;
    function set_soundpitch(sound: Sound, volume: number): number;
    function get_soundpan(sound: Sound): number;
    function set_soundpan(sound: Sound, volume: number): number;
    function play_sound(sound: Sound);
    function pause_sound(sound: Sound);
    function resume_sound(sound: Sound);
    function stop_sound(sound: Sound);
    function is_soundplaying(sound: Sound): boolean;

    // Data Types/Constructors

    function Image(path: string): Image;
    interface Image {
        width: number;
        height: number;
    }

    function Canvas(w: number, h: number): Canvas
    interface Canvas {
        image: Image;
        width: number;
        height: number;
    }

    function Music(path: string): Music;
    interface Music {
        // get/set
        volume: number;
        pitch: number;
        pan: number;
        // get only
        playing: boolean;
        length: number;
        length_played: number;
        // methods
        play(self: Music, loop: boolean);
        pause(self: Music);
        stop(self: Music);
        resume(self: Music);
        seek(self: Music, secs: number);
    }

    function SoundData(path: string): SoundData;
    interface SoundData {
        // get/set
        volume: number;
        pitch: number;
        pan: number;
    }

    function Sound(sounddata: SoundData): Sound;
    interface Sound {
        // get/set
        volume: number;
        pitch: number;
        pan: number;
        // get only
        playing: boolean;
        // methods
        play(self: Music, loop: boolean);
        pause(self: Music);
        stop(self: Music);
        resume(self: Music);
    }

    interface Font { }
    interface Point { x: number; y: number; }
    interface Line { x1: number; y1: number; x2: number; y2: number; }
    interface Rect { x: number; y: number; w: number; h: number }
    interface Triangle { x1: number; y1: number; x2: number; y2: number; }

    // enums (string values for various APIs)
    // TODO shorten some of these names
    type FilterMode = "nearest" | "linear";

    type BlendMode = "blend" | "add" | "add" | "mod" | "mul" | "none";

    type GamepadAxis = "axis_left_x" | "axis_left_y" | "axis_right_x" | "axis_right_y" |
        "axis_trigger_left" |  "axis_trigger_right";

    type MouseButton =  "m_1" | "m_2" | "m_3" | "m_4" | "m_5" | "m_6" | "m_7" | "m_8";

    type GamepadButton = "but_a" | "but_b" | "but_x" | "but_y" | "but_leftbumper" | "but_rightbumper" |
        "but_back" | "but_start" | "but_guide" | "but_leftthumb" | "but_righthumb" |
        "but_dpad_up" | "but_dpad_right" | "but_dpad_down" | "but_dpad_left" ;

    type KeyboardKey = "space" | "'" | "," | "-" | "." | "/" | "0" | "1" | "2" | "3" | "4" |
        "5" | "6" | "7" | "8" | "9" | ";" | "=" |
        "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" |
        "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" |
        "[" | "\\" | "]" | "`" |
        "world_1" | "world_2" | "escape" |
        "enter" | "tab" | "backspace" | "insert" | "delete" | "right" | "left" | "down" | "up" |
        "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" | "num_lock" |
        "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" |
        "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" |
        "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" | "f21" | "f22" | "f23" |
        "f24" | "f25" |
        "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" | "kp_6" | "kp_7" | "kp_8" | "kp_9" |
        "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" | "kp_add" | "kp_enter" | "kp_equal" |
        "left_shift" | "left_control" | "left_alt" | "left_super" |
        "right_shift" | "right_control" | "right_alt" | "right_super" |
        "menu" ;

    //--------------------------------------------------------------------
    //--------------------------------------------------------------------

    // Internal / Design / WIP

    // multi return types (TODO: remove these)
    type Tuple2<T1, T2> = { _1: T1, _2: T2};
    type Nil = null;

    // function class(base: any);

    // alternative to the OO constructors
    function load_image(path: string): Image;
    function new_canvas(w: number, h: number): Canvas;
    function load_music(path: string): Music;
    function load_sounddata(path: string): SoundData;
    function new_sound(sounddata: SoundData): Sound;

    // "In design" API
    namespace filesystem {
        function read(path: string): string;
        function write(path: string, content: string);
        function append(path: string, content: string);
    }
    let window: {
        vsync: boolean;
        fullscreen: boolean;
        size: { width: number; height: number; };
        minsize: { width: number; height: number; };
        title: string;
        icon: string;
        margin: {left: number, right: number, top: number, bottom: number};
        padding: {left: number, right: number, top: number, bottom: number};
    }
    let audio: {
        volume: number;
    };
    namespace mathx {
        function round(num: number, numDecimalPlaces: number|Nil): number;
    }
    namespace tween {
        // tween.new
        function _new(duration: number, subject: any, target: any, easingfunc: Nil|EasingFunc): Tween;
    }
    interface Tween {
        update(Tween, dt: number): boolean;
        set(self: Tween, clock: number): boolean;
        reset(self: Tween);
    }
    type EasingFunc = "" | "linear" | "inQuad" | "outQuad" | "inOutQuad" | "outInQuad" | "inCubic" |
        "outCubic" | "inOutCubic" | "outInCubic" | "inQuart" | "outQuart" | "inOutQuart" | "outInQuart" |
        "inQuint" | "outQuint" | "inOutQuint" | "outInQuint" | "inSine" | "outSine" | "inOutSine" |
        "outInSine" | "inExpo" | "outExpo" | "inOutExpo" | "outInExpo" | "inCirc" | "outCirc" |
        "inOutCirc" | "outInCirc" | "inElastic" | "outElastic" | "inOutElastic" | "outInElastic" | "inBack" |
        "outBack" | "inOutBack" | "outInBack" | "inBounce" | "outBounce" | "inOutBounce" | "outInBounce";

    //--------------------------------------------------------------------
    //--------------------------------------------------------------------
}