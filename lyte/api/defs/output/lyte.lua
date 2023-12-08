--- @meta

--- @class lyte
    --- Tick function. Should be created by the user.
--- @field tick fun(delta_time: number, window_width: number, window_height: number, window_resized: boolean)
lyte = {}


-- functions

--- Quit the application by closing the window.
--- @type fun()
function lyte.quit() end
--- Clear the screen or current canvas if one is used.
--- @type fun(r: number, g: number, b: number, a: number)
function lyte.cls() end
--- Set the foreground color to be used in the drawing operations.
--- @type fun(r: number, g: number, b: number, a: number)
function lyte.set_color() end
--- Reset the foreground color to its default value.
--- @type fun()
function lyte.reset_color() end
--- Draw a point.
--- @type fun(x: number, y: number)
function lyte.draw_point() end
--- Draw a line
--- @type fun(x1: number, y1: number, x2: number, y2: number)
function lyte.draw_line() end
--- Draw a filled triangle
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
function lyte.draw_triangle() end
--- Draw a triangle border
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
function lyte.draw_triangle_line() end
--- Draw a filled rectangle.
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
function lyte.draw_rect() end
--- Draw a rectangle border.
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
function lyte.draw_rect_line() end
--- Draw a filled circle.
--- @type fun(dest_x: number, dest_y: number, radius: number)
function lyte.draw_circle() end
--- Draw a circle border.
--- @type fun(dest_x: number, dest_y: number, radius: number)
function lyte.draw_circle_line() end
--- Load the image specified in the path.
--- @type fun(image_path: string): lyte.Image
function lyte.load_image() end
--- Draw an image.
--- @type fun(image: lyte.Image, dest_x: number, dest_y: number)
function lyte.draw_image() end
--- Draw a rectangular area from the image.
--- @type fun(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number)
function lyte.draw_image_rect() end
--- Get the width of the image.
--- @type fun(image: lyte.Image): number
function lyte.get_image_width() end
--- Get the height of the image.
--- @type fun(image: lyte.Image): number
function lyte.get_image_height() end
--- Create a canvas image with given width and height.
--- @type fun(width: number, height: number): lyte.Image
function lyte.new_canvas() end
--- Set the effective canvas image. All draw operations will go to this canvas until it's reset.
--- @type fun(canvas_image: lyte.Image)
function lyte.set_canvas() end
--- Reset the drawing target, back to screen.
--- @type fun()
function lyte.reset_canvas() end
--- Check if the image was created as a canvas.
--- @type fun(image: lyte.Image): boolean
function lyte.is_image_canvas() end
--- Create an image batch
--- @type fun(image: lyte.Image): lyte.ImageBatch
function lyte.new_imagebatch() end
--- Reset the image batch, remove all added rects.
--- @type fun(imagebatch: lyte.ImageBatch)
function lyte.reset_imagebatch() end
--- Add a recta to the image batch (from it's initial image).
--- @type fun(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
function lyte.add_imagebatch_rect() end
--- Get the number of rects in the image batch.
--- @type fun(imagebatch: lyte.ImageBatch): number
function lyte.get_imagebatch_rect_count() end
--- Draw the image batch.
--- @type fun(imagebatch: lyte.ImageBatch)
function lyte.draw_imagebatch() end
--- Load the font specified in the path, and set the initial size.
--- @type fun(font_path: string, size: number): lyte.Font
function lyte.load_font() end
--- Set the effective font to be used in the drawing operations.
--- @type fun(font: lyte.Font)
function lyte.set_font() end
--- Reset the font to its default value.
--- @type fun()
function lyte.reset_font() end
--- Draw a text line.
--- @type fun(text: string, dest_x: number, dest_y: number)
function lyte.draw_text() end
--- Get the width of the given text line.
--- @type fun(text: string): number
function lyte.get_text_width() end
--- Get the height of the given text line.
--- @type fun(text: string): number
function lyte.get_text_height() end
--- Get the number of currently connected monitors.
--- @type fun(): number
function lyte.get_monitor_count() end
--- Get the name of the monitor at the index
--- @type fun(index: number): string
function lyte.get_monitor_name() end
--- Get the width of the monitor at the index
--- @type fun(index: number): number
function lyte.get_monitor_width() end
--- Get the height of the monitor at the index
--- @type fun(index: number): number
function lyte.get_monitor_height() end
---  Set the window's initial monitor to the indexed value.
---  Must be set before the window is opened.
--- @type fun(index: number)
function lyte.set_window_monitor() end
---  Set the window resizable flag to the given value.
---  Must be set before the window is opened.
--- @type fun(resizable: boolean)
function lyte.set_window_resizable() end
--- Set the window's minimum possible size.
--- @type fun(width: number, height: number)
function lyte.set_window_minsize() end
--- Set the window's size.
--- @type fun(width: number, height: number)
function lyte.set_window_size() end
--- Get the width of the window.
--- @type fun(): number
function lyte.get_window_width() end
--- Get the height of the window.
--- @type fun(): number
function lyte.get_window_height() end
--- Set the window's position.
--- @type fun(x: number, y: number)
function lyte.set_window_position() end
--- Set the window to fullscreen, or windowed mode.
--- @type fun(fullscreen: boolean)
function lyte.set_fullscreen() end
--- Check if the window is set to fullscreen.
--- @type fun(): boolean
function lyte.is_fullscreen() end
--- Set the window's title.
--- @type fun(title: string)
function lyte.set_window_title() end
--- Set the window vsync flag to the given value.
--- @type fun(vsync: boolean)
function lyte.set_window_vsync() end
--- Check if the window vsync flag is set.
--- @type fun(): boolean
function lyte.is_window_vsync() end
--- Set the window icon.
--- @type fun(icon_path: string)
function lyte.set_window_icon_file() end
--- Set the window margins. Margins are ignored and no drawing can be made there..
--- @type fun(left: number, right: number, top: number, bottom: number)
function lyte.set_window_margins() end
--- Set the window paddings. Paddings are can be drawn on.
--- @type fun(left: number, right: number, top: number, bottom: number)
function lyte.set_window_paddings() end
--- Check if the given key is down.
--- @type fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_down() end
--- Check if the given key is pressed.
--- @type fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_pressed() end
--- Check if the given key is released.
--- @type fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_released() end
--- Check if the given key is repeated.
--- @type fun(key: lyte.KeyboardKey): boolean
function lyte.is_key_repeat() end
--- Check if the given mouse button is down.
--- @type fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_down() end
--- Check if the given mouse button is pressed.
--- @type fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_pressed() end
--- Check if the given mouse button is released.
--- @type fun(mouse_button: lyte.MouseButton): boolean
function lyte.is_mouse_released() end
--- Get the mouse x position.
--- @type fun(): number
function lyte.get_mouse_x() end
--- Get the mouse y position.
--- @type fun(): number
function lyte.get_mouse_y() end
--- Get the number of gamepads.
--- @type fun(): number
function lyte.get_gamepad_count() end
--- Get the name of the gamepad at the given index.
--- @type fun(index: number): string
function lyte.get_gamepad_name() end
--- Check if the given button of the gamepad at the given index is down.
--- @type fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_down() end
--- Check if the given button of the gamepad at the given index is pressed.
--- @type fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_pressed() end
--- Check if the given button of the gamepad at the given index is released.
--- @type fun(index: number, gamepad_button: lyte.GamepadButton): boolean
function lyte.is_gamepad_released() end
--- Get the given axis of the gamepad at the given index.
--- @type fun(index: number, gamepad_axis: lyte.GamepadAxis): number
function lyte.get_gamepad_axis() end
--- Set the master volume.
--- @type fun(mastervolume: number)
function lyte.set_mastervolume() end
--- Get the master volume.
--- @type fun(): number
function lyte.get_mastervolume() end
--- Load the music specified in the path.
--- @type fun(music_path: string): lyte.Music
function lyte.load_music() end
--- Play the music.
--- @type fun(music: lyte.Music)
function lyte.play_music() end
--- Pause the music.
--- @type fun(music: lyte.Music)
function lyte.pause_music() end
--- Resume the music.
--- @type fun(music: lyte.Music)
function lyte.resume_music() end
--- Stop the music.
--- @type fun(music: lyte.Music)
function lyte.stop_music() end
--- Check if the given music is playing.
--- @type fun(music: lyte.Music): boolean
function lyte.is_music_playing() end
--- Get the length of the given music object in seconds.
--- @type fun(music: lyte.Music): number
function lyte.get_music_length() end
--- Get the already played length of the given music object in seconds.
--- @type fun(music: lyte.Music): number
function lyte.get_music_length_played() end
--- Move the music time played to the given value.
--- @type fun(music: lyte.Music, secs: number)
function lyte.seek_music() end
--- Set the volume of the given music object.
--- @type fun(music: lyte.Music, volume: number)
function lyte.set_music_volume() end
--- Set the pan of the given music object.
--- @type fun(music: lyte.Music, pan: number)
function lyte.set_music_pan() end
--- Set the pitch of the given music object.
--- @type fun(music: lyte.Music, pitch: number)
function lyte.set_music_pitch() end
--- Get the volume of the given music object.
--- @type fun(music: lyte.Music): number
function lyte.get_music_volume() end
--- Get the pan of the given music object.
--- @type fun(music: lyte.Music): number
function lyte.get_music_pan() end
--- Get the pitch of the given music object.
--- @type fun(music: lyte.Music): number
function lyte.get_music_pitch() end
--- Load the sound specified in the path.
--- @type fun(sound_path: string): lyte.Sound
function lyte.load_sound() end
--- Clone the sound specified in the path.
--- @type fun(orig: lyte.Sound): lyte.Sound
function lyte.clone_sound() end
--- Play the sound.
--- @type fun(sound: lyte.Sound)
function lyte.play_sound() end
--- Pause the sound.
--- @type fun(sound: lyte.Sound)
function lyte.pause_sound() end
--- Resume the sound.
--- @type fun(sound: lyte.Sound)
function lyte.resume_sound() end
--- Stop the sound.
--- @type fun(sound: lyte.Sound)
function lyte.stop_sound() end
--- Check if the given sound is playing.
--- @type fun(sound: lyte.Sound): boolean
function lyte.is_sound_playing() end
--- Set the volume of the given sound object.
--- @type fun(sound: lyte.Sound, volume: number)
function lyte.set_sound_volume() end
--- Set the pan of the given sound object.
--- @type fun(sound: lyte.Sound, pan: number)
function lyte.set_sound_pan() end
--- Set the pitch of the given sound object.
--- @type fun(sound: lyte.Sound, pitch: number)
function lyte.set_sound_pitch() end
--- Get the volume of the given sound object.
--- @type fun(sound: lyte.Sound): number
function lyte.get_sound_volume() end
--- Get the pan of the given sound object.
--- @type fun(sound: lyte.Sound): number
function lyte.get_sound_pan() end
--- Get the pitch of the given sound object.
--- @type fun(sound: lyte.Sound): number
function lyte.get_sound_pitch() end
--- Load the file in the path.
--- @type fun(file_path: string): string
function lyte.load_textfile() end
--- Append the text to the file in the path. Override if the file exists. Create if it doesn't exist.
--- @type fun(file_path: string, data: string)
function lyte.save_textfile() end
--- Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist.
--- @type fun(file_path: string, data: string)
function lyte.save_textfile_append() end
--- Push the transform matrix.
--- @type fun()
function lyte.push_matrix() end
--- Pop the transform matrix.
--- @type fun()
function lyte.pop_matrix() end
--- Reset the transformation matrix (load identity matrix.)
--- @type fun()
function lyte.reset_matrix() end
--- Apply translation (changes transform matrix.)
--- @type fun(delta_x: number, delta_y: number)
function lyte.translate() end
--- Apply rotation (changes transform matrix.)
--- @type fun(angle: number)
function lyte.rotate() end
--- Apply rotation at the given location (changes transform matrix.)
--- @type fun(angle: number, x: number, y: number)
function lyte.rotate_at() end
--- Apply scaling (changes transform matrix.)
--- @type fun(scale_x: number, scale_y: number)
function lyte.scale() end
--- Apply scaling at the given location (changes transform matrix.)
--- @type fun(scale_x: number, scale_y: number, x: number, y: number)
function lyte.scale_at() end
--- Set the default blendmode.
--- @type fun(blendmode: lyte.BlendMode)
function lyte.set_default_blendmode() end
--- Set the effective blendmode.
--- @type fun(blendmode: lyte.BlendMode)
function lyte.set_blendmode() end
--- Reset the blendmode value to its default value.
--- @type fun()
function lyte.reset_blendmode() end
--- Set the default filtermode.
--- @type fun(filtermode: lyte.FilterMode)
function lyte.set_default_filtermode() end
--- Set the effective filtermode.
--- @type fun(filtermode: lyte.FilterMode)
function lyte.set_filtermode() end
--- Reset the filtermode value to its default value.
--- @type fun()
function lyte.reset_filtermode() end
--- Create a shader with given specification.
--- @type fun(shaderdef: lyte.ShaderDef): lyte.Shader
function lyte.new_shader() end
--- Set the custom shader and use it for consequent calls.
--- @type fun(shader: lyte.Shader)
function lyte.set_shader() end
--- Reset the shader, back to framework defaults.
--- @type fun()
function lyte.reset_shader() end
--- Set the specified uniform.
--- @type fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
function lyte.set_shader_uniform() end
--- Reset the specified uniform.
--- @type fun(shader: lyte.Shader, uniform_name: string)
function lyte.reset_shader_uniform() end
--- Create a ShaderBuilder object.
--- @type fun(): lyte.ShaderBuilder
function lyte.new_shaderbuilder() end
--- Add uniform definition to the shaderbuilder
--- @type fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
function lyte.shaderbuilder_uniform() end
--- Add vertex code to the shaderbuilder
--- @type fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
function lyte.shaderbuilder_vertex() end
--- Add fragment to the shaderbuilder
--- @type fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
function lyte.shaderbuilder_fragment() end
--- Add fragment to the shaderbuilder
--- @type fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
function lyte.shaderbuilder_build() end


-- lists



-- tuples

--- Tuple of floats
--- @alias lyte.FloatVec4 number[]


-- dicts

--- @alias lyte.UniformNamesToTypes {[string]: lyte.UniformType}


-- variants

--- Shader uniform value
--- @alias lyte.ShaderUniformValue number | lyte.FloatVec4 | lyte.Image


-- records

--- Image type
--- @class lyte.Image
        --- @field width number
        --- @field height number
        --- @field is_canvas boolean
lyte.Image = {}

--- ImageBatch type.
--- @class lyte.ImageBatch
        --- @field rect_count number
        --- @field add_rect fun(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
        --- @field draw fun(imagebatch: lyte.ImageBatch)
        --- @field reset fun(imagebatch: lyte.ImageBatch)
lyte.ImageBatch = {}

--- Font type.
--- @class lyte.Font
lyte.Font = {}

--- Music type.
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

--- Sound type.
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

--- Shader type
--- @class lyte.Shader
        --- @field set fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
        --- @field reset fun(shader: lyte.Shader, uniform_name: string)
lyte.Shader = {}

--- Shader definition: uniforms declaration, vertex and fragment shader code.
--- @class lyte.ShaderDef
        --- @field frag string
        --- @field vert string
        --- @field uniforms lyte.UniformNamesToTypes
lyte.ShaderDef = {}

--- ShaderBuilder type
--- @class lyte.ShaderBuilder
        --- @field uniform fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
        --- @field vertex fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
        --- @field fragment fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
        --- @field build fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
lyte.ShaderBuilder = {}



-- enums

--- Acceptable uniformtype values.
---@alias lyte.UniformType    "_invalid" |  "float" |  "vec2" |  "vec3" | "vec4" | "int" | "ivec2" | "ivec3" | "ivec4" | "mat4" | "sampler2D"
--- Acceptable blendmode values.
---@alias lyte.BlendMode    "none" |  "blend" |  "add" |  "mod" |  "mul"
--- Acceptable filtermode values.
---@alias lyte.FilterMode    "_invalid" |  "nearest" |  "linear" 
--- Acceptable gamepadaxis values.
---@alias lyte.GamepadAxis    "left_x" |  "left_y" |  "right_x" | "right_y" | "left_trigger" | "right_trigger"
--- Acceptable gamepadbutton values.
---@alias lyte.GamepadButton    "pad_a" |  "pad_b" |  "pad_x" | "pad_y" | "left_bumper" | "right_bumper" | "back" | "start" | "guide" | "left_thumb" | "right_thumb" | "dpad_up" | "dpad_right" | "dpad_down" | "dpad_left"
--- Acceptable mousebutton values.
---@alias lyte.MouseButton    "mb1" |  "mb2" |  "mb3" |  "mb4" |  "mb5" | "mb6" | "mb7" | "mb8"
--- Acceptable keyboardkey values.
---@alias lyte.KeyboardKey    "space" |  "'" |  "," |  "-" |  "." | "/" | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | ";" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "[" | "\\" | "]" | "`" | "world_1" | "world_2" | "escape" | "enter" | "tab" | "backspace" | "insert" | "delete" | "right" | "left" | "down" | "up" | "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" | "num_lock" | "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" | "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" | "f21" | "f22" | "f23" | "f24" | "f25" | "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" | "kp_6" | "kp_7" | "kp_8" | "kp_9" | "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" | "kp_add" | "kp_enter" | "kp_equal" | "left_shift" | "left_control" | "left_alt" | "left_super" | "right_shift" | "right_control" | "right_alt" | "right_super" | "menu"


return lyte

