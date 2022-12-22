api_text =
`

-- to be defined by user code
frame: function(delta_time: number, width: number, height: number,  resized: boolean, fullscreen: boolean)

-- API

quit: function()
set_fullscreen: function(fullscreen: boolean)
get_fullscreen: function(): boolean
set_margins: function(left: number, right: number, top: number, bottom: number)
set_paddings: function(left: number, right: number, top: number, bottom: number)
get_windowwidth: function(): number
get_windowheight: function(): number
set_windowsize: function(w: number, h: number)
set_windowminsize: function(w: number, h: number)
set_windowtitle: function(title: string)
set_windowicon: function(path: string)
set_vsync: function(vsync: boolean)
get_vsync: function(): boolean

is_keydown: function(keyboardkey: KeyboardKey): boolean
is_keyrepeat: function(keyboardkey: KeyboardKey): boolean
is_keypressed: function(keyboardkey: KeyboardKey): boolean
is_keyreleased: function(keyboardkey: KeyboardKey): boolean
is_mousedown: function(mousebut: MouseButton ): boolean
is_mousepressed: function(mousebut: MouseButton ): boolean
is_mousereleased: function(mousebut: MouseButton ): boolean
get_mouse: function(): number, number
get_gamepadname: function(idx: number): string
num_gamepads: function(): number
is_gamepaddown: function(idx: number, gamepadkey: GamepadButton ): boolean
is_gamepadpressed: function(idx: number, gamepadkey: GamepadButton ): boolean
is_gamepadreleased: function(idx: number, gamepadkey: GamepadButton ): boolean
get_gamepadaxis: function(idx: number, gamepadaxis: GamepadAxis): number

load_text: function(path: string): string
save_text: function(path: string, data: string)
save_text_append: function(path: string, data: string)

push_matrix: function()
pop_matrix: function()
identity_matrix: function()
translate: function(dx: number, dy: number)
rotate: function(r: number)
rotate_at: function(r: number, x: number, y: number)
scale: function(sx: number, sy: number)
scale_at: function(sx: number, sy: number, x: number, y: number)
clear: function(r: number,g: number,b: number,a: number)
set_color: function(r: number,g: number,b: number,a: number)
reset_color: function()
set_defaultblendmode: function(defaultblendmode: BlendMode)
set_blendmode: function(blendmode: BlendMode)
reset_blendmode: function()
set_defaultfiltermode: function(defaultfiltermode: FilterMode)
set_filtermode: function(filtermode: FilterMode)
reset_filtermode: function()

new_canvas: function(w: number, h: number): Canvas
set_canvas: function(canvas: Canvas)
reset_canvas: function()

load_image: function(path: string): Image
draw_image: function(img: Image, x: number, y: number)
draw_imagerect: function(img: Image, x: number, y: number, im_x: number, im_y: number, im_w: number, im_h:number)

load_font: function(path: string, size: number): Font
set_font: function(font: Font)
reset_font: function()
draw_text: function(str: string, x: number, y: number): number, number
measure_text: function(str: string): number, number

draw_point: function(x: number, y: number)
draw_line: function(x1: number, y1: number, x2: number, y2: number)
draw_rect: function(x: number, y: number, w: number, h: number)
draw_rect_filled: function(x: number, y: number, w: number, h: number)
draw_circle: function(x: number, y: number, r: number)
draw_circle_filled: function(x: number, y: number, r: number)
draw_points: function(pts: {Point})
draw_lines: function(lines: {Line})
draw_rects_filled: function(rects: {Rect})
draw_triangles_filled: function(triangles: {Triangle})
draw_striplines: function(pts: {Point})
draw_striptriangles_filled: function(pts: {Point})

get_mastervolume: function(): number -- 0..1
set_mastervolume: function(vol: number): number -- 0..1

load_music: function(path: string): Music
get_musicvolume: function(mus: Music): number -- 0..1
set_musicvolume: function(mus: Music, vol: number): number -- 0..1
get_musicpitch: function(mus: Music): number
set_musicpitch: function(mus: Music, pitch: number): number
get_musicpan: function(mus: Music): number
set_musicpan: function(vol: number, pan: number): number
play_music: function(mus: Music)
pause_music: function(mus: Music)
resume_music: function(mus: Music)
stop_music: function(mus: Music)
seek_music: function(mus: Music,secs: number)
get_musiclength: function(mus: Music): number
get_musiclength_played: function(mus: Music): number
is_musicplaying: function(mus: Music): boolean

load_sounddata: function(path: string): SoundData
get_sounddatavolume: function(sounddata: SoundData): number
set_sounddatavolume: function(sounddata: SoundData, volume: number): number
get_sounddatapitch: function(sounddata: SoundData): number
set_sounddatapitch: function(sounddata: SoundData, volume: number): number
get_sounddatapan: function(sounddata: SoundData): number
set_sounddatapan: function(sounddata: SoundData, volume: number): number

new_sound: function(sounddata: SoundData): Sound
get_soundvolume: function(sound: Sound): number
set_soundvolume: function(sound: Sound, volume: number): number
get_soundpitch: function(sound: Sound): number
set_soundpitch: function(sound: Sound, volume: number): number
get_soundpan: function(sound: Sound): number
set_soundpan: function(sound: Sound, volume: number): number
play_sound: function(sound: Sound)
pause_sound: function(sound: Sound)
resume_sound: function(sound: Sound)
stop_sound: function(sound: Sound)
is_soundplaying: function(sound: Sound): boolean



record Point
  x: number
  y: number
end

  record Line
  x1: number
  y1: number
  x2: number
  y2: number
end

record Rect
  x: number
  y: number
  w: number
  h: number
end

record Triangle
  x1: number
  y1: number
  x2: number
  y2: number
  x3: number
  y3: number
end

record Image
  width: number
  height: number
end

record Canvas
  image: Image
  width: number
  height: number
end

record Font end

record Music end

record SoundData end

record Sound end

enum FilterMode
  "nearest"
  "linear"
end

enum BlendMode
  "none"
  "blend"
  "add"
  "mod"
  "mul"
end

class: function(base:any|nil): any

record mathx
  round: function(num: number, numDecimalPlaces: number|nil): number
end

record tween
  new: function(duration: number, subject: any, target: {string|number:any}, easingfunc: nil|EasingFunc|function): Tween
end

record Tween
  update: function(Tween, dt: number): boolean
  set: function(Tween, clock: number): boolean
  reset: function(Tween)
end

enum EasingFunc
  "linear"

  "inQuad"
  "outQuad"
  "inOutQuad"
  "outInQuad"

  "inCubic"
  "outCubic"
  "inOutCubic"
  "outInCubic"

  "inQuart"
  "outQuart"
  "inOutQuart"
  "outInQuart"

  "inQuint"
  "outQuint"
  "inOutQuint"
  "outInQuint"

  "inSine"
  "outSine"
  "inOutSine"
  "outInSine"

  "inExpo"
  "outExpo"
  "inOutExpo"
  "outInExpo"

  "inCirc"
  "outCirc"
  "inOutCirc"
  "outInCirc"

  "inElastic"
  "outElastic"
  "inOutElastic"
  "outInElastic"

  "inBack"
  "outBack"
  "inOutBack"
  "outInBack"

  "inBounce"
  "outBounce"
  "inOutBounce"
  "outInBounce"
end


enum MouseButton
  "m_1"
  "m_2"
  "m_3"
  "m_4"
  "m_5"
  "m_6"
  "m_7"
  "m_8"
  -- "m_wh_up"
  -- "m_wh_down"
  -- "m_wh_left"
  -- "m_wh_right"
end

enum GamepadButton
  "but_a"
  "but_b"
  "but_x"
  "but_y"
  "but_leftbumper"
  "but_rightbumper"
  "but_back"
  "but_start"
  "but_guide"
  "but_leftthumb"
  "but_righthumb"
  "but_dpad_up"
  "but_dpad_right"
  "but_dpad_down"
  "but_dpad_left"
end

  enum GamepadAxis
  "axis_left_x"
  "axis_left_y"
  "axis_right_x"
  "axis_right_y"
  "axis_trigger_left"
  "axis_trigger_right"
end



enum KeyboardKey
  "space"
  "'"
  ","
  "-"
  "."
  "/"
  "0"
  "1"
  "2"
  "3"
  "4"
  "5"
  "6"
  "7"
  "8"
  "9"
  ";"
  "="
  "a"
  "b"
  "c"
  "d"
  "e"
  "f"
  "g"
  "h"
  "i"
  "j"
  "k"
  "l"
  "m"
  "n"
  "o"
  "p"
  "q"
  "r"
  "s"
  "t"
  "u"
  "v"
  "w"
  "x"
  "y"
  "z"
  "["
  "\\"
  "]"
  "\`"
  "world_1"
  "world_2"
  "escape"
  "enter"
  "tab"
  "backspace"
  "insert"
  "delete"
  "right"
  "left"
  "down"
  "up"
  "page_up"
  "page_down"
  "home"
  "end"
  "caps_lock"
  "scroll_lock"
  "num_lock"
  "print_screen"
  "pause"
  "f1"
  "f2"
  "f3"
  "f4"
  "f5"
  "f6"
  "f7"
  "f8"
  "f9"
  "f10"
  "f11"
  "f12"
  "f13"
  "f14"
  "f15"
  "f16"
  "f17"
  "f18"
  "f19"
  "f20"
  "f21"
  "f22"
  "f23"
  "f24"
  "f25"
  "kp_0"
  "kp_1"
  "kp_2"
  "kp_3"
  "kp_4"
  "kp_5"
  "kp_6"
  "kp_7"
  "kp_8"
  "kp_9"
  "kp_decimal"
  "kp_divide"
  "kp_multiply"
  "kp_subtract"
  "kp_add"
  "kp_enter"
  "kp_equal"
  "left_shift"
  "left_control"
  "left_alt"
  "left_super"
  "right_shift"
  "right_control"
  "right_alt"
  "right_super"
  "menu"
end


`;