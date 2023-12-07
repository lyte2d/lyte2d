local lyte = {}


-- functions

--- @type  fun(delta_time: number, window_width: number, window_height: number, window_resized: boolean)
function lyte.tick() end
--- @type  fun()
function lyte.quit() end
--- @type  fun(r: number, g: number, b: number, a: number)
function lyte.cls() end
--- @type  fun(r: number, g: number, b: number, a: number)
function lyte.set_color() end
--- @type  fun()
function lyte.reset_color() end
--- @type  fun(x: number, y: number)
function lyte.draw_point() end
--- @type  fun(x1: number, y1: number, x2: number, y2: number)
function lyte.draw_line() end
--- @type  fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
function lyte.draw_rect() end
--- @type  fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
function lyte.draw_rect_line() end
--- @type  fun(dest_x: number, dest_y: number, radius: number)
function lyte.draw_circle() end
--- @type  fun(dest_x: number, dest_y: number, radius: number)
function lyte.draw_circle_line() end
--- @type  fun(image_path: string): lyte.Image
function lyte.load_image() end
--- @type  fun(image: lyte.Image, dest_x: number, dest_y: number)
function lyte.draw_image() end
--- @type  fun(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number)
function lyte.draw_image_rect() end
--- @type  fun(image: lyte.Image): number
function lyte.get_image_width() end
--- @type  fun(image: lyte.Image): number
function lyte.get_image_height() end
--- @type  fun(width: number, height: number): lyte.Image
function lyte.new_canvas() end
--- @type  fun(canvas_image: lyte.Image)
function lyte.set_canvas() end
--- @type  fun()
function lyte.reset_canvas() end
--- @type  fun(image: lyte.Image): boolean
function lyte.is_image_canvas() end
--- @type  fun(font_path: string, size: number): lyte.Font
function lyte.load_font() end
--- @type  fun(font: lyte.Font)
function lyte.set_font() end
--- @type  fun()
function lyte.reset_font() end
--- @type  fun(text: string, dest_x: number, dest_y: number)
function lyte.draw_text() end
--- @type  fun(text: string): number
function lyte.get_text_width() end
--- @type  fun(text: string): number
function lyte.get_text_height() end
--- @type  fun(): number
function lyte.get_monitor_count() end
--- @type  fun(index: number): string
function lyte.get_monitor_name() end
--- @type  fun(index: number): number
function lyte.get_monitor_width() end
--- @type  fun(index: number): number
function lyte.get_monitor_height() end
--- @type  fun(index: number)
function lyte.set_window_monitor() end
--- @type  fun(resizable: boolean)
function lyte.set_window_resizable() end
--- @type  fun(width: number, height: number)
function lyte.set_window_minsize() end
--- @type  fun(width: number, height: number)
function lyte.set_window_size() end
--- @type  fun(): number
function lyte.get_window_width() end
--- @type  fun(): number
function lyte.get_window_height() end
--- @type  fun(x: number, y: number)
function lyte.set_window_position() end
--- @type  fun(fullscreen: boolean)
function lyte.set_fullscreen() end
--- @type  fun(): boolean
function lyte.is_fullscreen() end
--- @type  fun(title: string)
function lyte.set_window_title() end
--- @type  fun(vsync: boolean)
function lyte.set_window_vsync() end
--- @type  fun(): boolean
function lyte.is_window_vsync() end
--- @type  fun(icon_path: string)
function lyte.set_window_icon_file() end
--- @type  fun(left: number, right: number, top: number, bottom: number)
function lyte.set_window_margins() end
--- @type  fun(left: number, right: number, top: number, bottom: number)
function lyte.set_window_paddings() end
--- @type  fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_down() end
--- @type  fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_pressed() end
--- @type  fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_released() end
--- @type  fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_repeat() end
--- @type  fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_down() end
--- @type  fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_pressed() end
--- @type  fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_released() end
--- @type  fun(): number
function lyte.get_mouse_x() end
--- @type  fun(): number
function lyte.get_mouse_y() end
--- @type  fun(): number
function lyte.get_gamepad_count() end
--- @type  fun(index: number): string
function lyte.get_gamepad_name() end
--- @type  fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_down() end
--- @type  fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_pressed() end
--- @type  fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_released() end
--- @type  fun(index: number, gamepad_axis: lyte.GamepadAxis): number
function lyte.get_gamepad_axis() end
--- @type  fun(mastervolume: number)
function lyte.set_mastervolume() end
--- @type  fun(): number
function lyte.get_mastervolume() end
--- @type  fun(music_path: string): lyte.Music
function lyte.load_music() end
--- @type  fun(music: lyte.Music)
function lyte.play_music() end
--- @type  fun(music: lyte.Music)
function lyte.pause_music() end
--- @type  fun(music: lyte.Music)
function lyte.resume_music() end
--- @type  fun(music: lyte.Music)
function lyte.stop_music() end
--- @type  fun(music: lyte.Music): boolean
function lyte.is_music_playing() end
--- @type  fun(music: lyte.Music): number
function lyte.get_music_length() end
--- @type  fun(music: lyte.Music): number
function lyte.get_music_length_played() end
--- @type  fun(music: lyte.Music, secs: number)
function lyte.seek_music() end
--- @type  fun(music: lyte.Music, volume: number)
function lyte.set_music_volume() end
--- @type  fun(music: lyte.Music, pan: number)
function lyte.set_music_pan() end
--- @type  fun(music: lyte.Music, pitch: number)
function lyte.set_music_pitch() end
--- @type  fun(music: lyte.Music): number
function lyte.get_music_volume() end
--- @type  fun(music: lyte.Music): number
function lyte.get_music_pan() end
--- @type  fun(music: lyte.Music): number
function lyte.get_music_pitch() end
--- @type  fun(sound_path: string): lyte.Sound
function lyte.load_sound() end
--- @type  fun(orig: lyte.Sound): lyte.Sound
function lyte.clone_sound() end
--- @type  fun(sound: lyte.Sound)
function lyte.play_sound() end
--- @type  fun(sound: lyte.Sound)
function lyte.pause_sound() end
--- @type  fun(sound: lyte.Sound)
function lyte.resume_sound() end
--- @type  fun(sound: lyte.Sound)
function lyte.stop_sound() end
--- @type  fun(sound: lyte.Sound): boolean
function lyte.is_sound_playing() end
--- @type  fun(sound: lyte.Sound, volume: number)
function lyte.set_sound_volume() end
--- @type  fun(sound: lyte.Sound, pan: number)
function lyte.set_sound_pan() end
--- @type  fun(sound: lyte.Sound, pitch: number)
function lyte.set_sound_pitch() end
--- @type  fun(sound: lyte.Sound): number
function lyte.get_sound_volume() end
--- @type  fun(sound: lyte.Sound): number
function lyte.get_sound_pan() end
--- @type  fun(sound: lyte.Sound): number
function lyte.get_sound_pitch() end
--- @type  fun(file_path: string): string
function lyte.load_textfile() end
--- @type  fun(file_path: string, data: string)
function lyte.save_textfile() end
--- @type  fun(file_path: string, data: string)
function lyte.save_textfile_append() end
--- @type  fun()
function lyte.push_matrix() end
--- @type  fun()
function lyte.pop_matrix() end
--- @type  fun()
function lyte.reset_matrix() end
--- @type  fun(delta_x: number, delta_y: number)
function lyte.translate() end
--- @type  fun(angle: number)
function lyte.rotate() end
--- @type  fun(angle: number, x: number, y: number)
function lyte.rotate_at() end
--- @type  fun(scale_x: number, scale_y: number)
function lyte.scale() end
--- @type  fun(scale_x: number, scale_y: number, x: number, y: number)
function lyte.scale_at() end
--- @type  fun(blendmode: lyte.BlendMode)
function lyte.set_default_blendmode() end
--- @type  fun(blendmode: lyte.BlendMode)
function lyte.set_blendmode() end
--- @type  fun()
function lyte.reset_blendmode() end
--- @type  fun(filtermode: lyte.FilterMode)
function lyte.set_default_filtermode() end
--- @type  fun(filtermode: lyte.FilterMode)
function lyte.set_filtermode() end
--- @type  fun()
function lyte.reset_filtermode() end
--- @type  fun(shaderdef: lyte.ShaderDef): lyte.Shader
function lyte.new_shader() end
--- @type  fun(shader: lyte.Shader)
function lyte.set_shader() end
--- @type  fun()
function lyte.reset_shader() end
--- @type  fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
function lyte.set_shader_uniform() end
--- @type  fun(shader: lyte.Shader, uniform_name: string)
function lyte.reset_shader_uniform() end
--- @type  fun(): lyte.ShaderBuilder
function lyte.new_shaderbuilder() end
--- @type  fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
function lyte.shaderbuilder_uniform() end
--- @type  fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
function lyte.shaderbuilder_vertex() end
--- @type  fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
function lyte.shaderbuilder_fragment() end
--- @type  fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
function lyte.shaderbuilder_build() end


-- lists



-- tuples

--- @alias lyte.FloatVec4 number[]


-- dicts

--- @alias lyte.UniformNamesToTypes {[string]: lyte.UniformType}


-- variants

--- @alias lyte.ShaderUniformValue number | lyte.FloatVec4 | lyte.Image


-- records

--- @class lyte.Image
    --- @field width number
    --- @field height number
    --- @field is_canvas boolean
lyte.Image = {}

--- @class lyte.Font
lyte.Font = {}

--- @class lyte.Music
    --- @field playing boolean
    --- @field length number
    --- @field length_played number
    --- @field pan number
    --- @field pitch number
    --- @field volume number
    --- @field play fun(music: lyte.Music)
    --- @field pause fun(music: lyte.Music)
    --- @field resume fun(music: lyte.Music)
    --- @field stop fun(music: lyte.Music)
    --- @field seek fun(music: lyte.Music, secs: number)
lyte.Music = {}

--- @class lyte.Sound
    --- @field pan number
    --- @field pitch number
    --- @field volume number
    --- @field clone fun(orig: lyte.Sound): lyte.Sound
    --- @field pause fun(sound: lyte.Sound)
    --- @field play fun(sound: lyte.Sound)
    --- @field resume fun(sound: lyte.Sound)
    --- @field stop fun(sound: lyte.Sound)
lyte.Sound = {}

--- @class lyte.Shader
    --- @field set fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
    --- @field reset fun(shader: lyte.Shader, uniform_name: string)
lyte.Shader = {}

--- @class lyte.ShaderDef
    --- @field frag string
    --- @field vert string
    --- @field uniforms lyte.UniformNamesToTypes
lyte.ShaderDef = {}

--- @class lyte.ShaderBuilder
    --- @field uniform fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
    --- @field vertex fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
    --- @field fragment fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
    --- @field build fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
lyte.ShaderBuilder = {}



-- enums

---@alias lyte.UniformType    "_invalid" |  "float" |  "vec2" |  "vec3" |  "vec4" |  "int" |  "ivec2" | "ivec3" | "ivec4" | "mat4" | "sampler2D"
---@alias lyte.BlendMode    "none" |  "blend" |  "add" |  "mod" |  "mul" 
---@alias lyte.FilterMode    "_invalid" |  "nearest" |  "linear" 
---@alias lyte.GamepadAxis    "left_x" |  "left_y" |  "right_x" |  "right_y" |  "left_trigger" |  "right_trigger"
---@alias lyte.GamepadButton    "pad_a" |  "pad_b" |  "pad_x" |  "pad_y" |  "left_bumper" |  "right_bumper" | "back" | "start" | "guide" | "left_thumb" | "right_thumb" | "dpad_up" | "dpad_right" | "dpad_down" | "dpad_left"
---@alias lyte.MouseButton    "mb1" |  "mb2" |  "mb3" |  "mb4" |  "mb5" |  "mb6" |  "mb7" |  "mb8" 
---@alias lyte.KeyboardKey    "space" |  "'" |  "," |  "-" |  "." |  "/" |  "0" |  "1" |  "2" |  "3" | "4" | "5" | "6" | "7" | "8" | "9" | ";" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "[" | "\\" | "]" | "`" | "world_1" | "world_2" | "escape" | "enter" | "tab" | "backspace" | "insert" | "delete" | "right" | "left" | "down" | "up" | "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" | "num_lock" | "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" | "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" | "f21" | "f22" | "f23" | "f24" | "f25" | "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" | "kp_6" | "kp_7" | "kp_8" | "kp_9" | "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" | "kp_add" | "kp_enter" | "kp_equal" | "left_shift" | "left_control" | "left_alt" | "left_super" | "right_shift" | "right_control" | "right_alt" | "right_super" | "menu"


return lyte

