-- generated

--- @meta
--- @class lyte
--- Tick function. Should be created by the user. 
--- @field tick fun(delta_time: number, window_width: int, window_height: int, window_resized: boolean, is_fullscreen: boolean)
    lyte = lyte or {}

-- functions

--- Quit the application by closing the window. 
--- @type fun()
    lyte.quit = lyte.quit and lyte.quit or function() end
--- Clear the screen or current canvas if one is used. 
--- @type fun(r: number, g: number, b: number, a: number)
    lyte.cls = lyte.cls and lyte.cls or function() end
--- Set the foreground color to be used in the drawing operations. 
--- @type fun(r: number, g: number, b: number, a: number)
    lyte.set_color = lyte.set_color and lyte.set_color or function() end
--- Reset the foreground color to its default value. 
--- @type fun()
    lyte.reset_color = lyte.reset_color and lyte.reset_color or function() end
--- Draw a point. 
--- @type fun(x: number, y: number)
    lyte.draw_point = lyte.draw_point and lyte.draw_point or function() end
--- Draw a line 
--- @type fun(x1: number, y1: number, x2: number, y2: number)
    lyte.draw_line = lyte.draw_line and lyte.draw_line or function() end
--- Draw a filled triangle 
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    lyte.draw_triangle = lyte.draw_triangle and lyte.draw_triangle or function() end
--- Draw a triangle border 
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    lyte.draw_triangle_line = lyte.draw_triangle_line and lyte.draw_triangle_line or function() end
--- Draw a filled rectangle. 
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    lyte.draw_rect = lyte.draw_rect and lyte.draw_rect or function() end
--- Draw a rectangle border. 
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    lyte.draw_rect_line = lyte.draw_rect_line and lyte.draw_rect_line or function() end
--- Draw a filled circle. 
--- @type fun(dest_x: number, dest_y: number, radius: number)
    lyte.draw_circle = lyte.draw_circle and lyte.draw_circle or function() end
--- Draw a circle border. 
--- @type fun(dest_x: number, dest_y: number, radius: number)
    lyte.draw_circle_line = lyte.draw_circle_line and lyte.draw_circle_line or function() end
--- Draw a filled ellipse. 
--- @type fun(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    lyte.draw_ellipse = lyte.draw_ellipse and lyte.draw_ellipse or function() end
--- Draw an ellipse border. 
--- @type fun(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    lyte.draw_ellipse_line = lyte.draw_ellipse_line and lyte.draw_ellipse_line or function() end
--- Free Image resources 
--- @type fun(image: lyte.Image)
    lyte.cleanup_image = lyte.cleanup_image and lyte.cleanup_image or function() end
--- Load the image specified in the path. 
--- @type fun(image_path: string): lyte.Image
    lyte.load_image = lyte.load_image and lyte.load_image or function() end
--- Draw an image. Angle, scale and origin values are all optional. 
--- @type fun(image: lyte.Image, dest_x: number, dest_y: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    lyte.draw_image = lyte.draw_image and lyte.draw_image or function() end
--- Draw a rectangular area from the image. Angle, scale and origin values are all optional. 
--- @type fun(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    lyte.draw_image_rect = lyte.draw_image_rect and lyte.draw_image_rect or function() end
--- Get the width of the image. 
--- @type fun(image: lyte.Image): int
    lyte.get_image_width = lyte.get_image_width and lyte.get_image_width or function() end
--- Get the height of the image. 
--- @type fun(image: lyte.Image): int
    lyte.get_image_height = lyte.get_image_height and lyte.get_image_height or function() end
--- Create a canvas image with given width and height. 
--- @type fun(width: int, height: int): lyte.Image
    lyte.new_canvas = lyte.new_canvas and lyte.new_canvas or function() end
--- Set the effective canvas image. All draw operations will go to this canvas until it's reset. 
--- @type fun(canvas_image: lyte.Image)
    lyte.set_canvas = lyte.set_canvas and lyte.set_canvas or function() end
--- Reset the drawing target, back to screen. 
--- @type fun()
    lyte.reset_canvas = lyte.reset_canvas and lyte.reset_canvas or function() end
--- Check if the image was created as a canvas. 
--- @type fun(image: lyte.Image): boolean
    lyte.is_image_canvas = lyte.is_image_canvas and lyte.is_image_canvas or function() end
--- Free ImageBatch resources 
--- @type fun(imagebatch: lyte.ImageBatch)
    lyte.cleanup_imagebatch = lyte.cleanup_imagebatch and lyte.cleanup_imagebatch or function() end
--- Create an image batch 
--- @type fun(image: lyte.Image): lyte.ImageBatch
    lyte.new_imagebatch = lyte.new_imagebatch and lyte.new_imagebatch or function() end
--- Reset the image batch, remove all added rects. 
--- @type fun(imagebatch: lyte.ImageBatch)
    lyte.reset_imagebatch = lyte.reset_imagebatch and lyte.reset_imagebatch or function() end
--- Add a recta to the image batch (from it's initial image). `src_width` and `src_height` are optional and will default to the corresponding `dest_` values. 
--- @type fun(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
    lyte.add_imagebatch_rect = lyte.add_imagebatch_rect and lyte.add_imagebatch_rect or function() end
--- Get the number of rects in the image batch. 
--- @type fun(imagebatch: lyte.ImageBatch): int
    lyte.get_imagebatch_rect_count = lyte.get_imagebatch_rect_count and lyte.get_imagebatch_rect_count or function() end
--- Draw the image batch. 
--- @type fun(imagebatch: lyte.ImageBatch)
    lyte.draw_imagebatch = lyte.draw_imagebatch and lyte.draw_imagebatch or function() end
--- Free Font resources 
--- @type fun(font: lyte.Font)
    lyte.cleanup_font = lyte.cleanup_font and lyte.cleanup_font or function() end
--- Load the font specified in the path, and set the initial size. 
--- @type fun(font_path: string, size: number): lyte.Font
    lyte.load_font = lyte.load_font and lyte.load_font or function() end
--- Set the effective font to be used in the drawing operations. 
--- @type fun(font: lyte.Font)
    lyte.set_font = lyte.set_font and lyte.set_font or function() end
--- Reset the font to its default value. 
--- @type fun()
    lyte.reset_font = lyte.reset_font and lyte.reset_font or function() end
--- Draw a text line. 
--- @type fun(text: string, dest_x: number, dest_y: number)
    lyte.draw_text = lyte.draw_text and lyte.draw_text or function() end
--- Get the width of the given text line. 
--- @type fun(text: string): int
    lyte.get_text_width = lyte.get_text_width and lyte.get_text_width or function() end
--- Get the height of the given text line. 
--- @type fun(text: string): int
    lyte.get_text_height = lyte.get_text_height and lyte.get_text_height or function() end
--- Get the number of currently connected monitors. 
--- @type fun(): int
    lyte.get_monitor_count = lyte.get_monitor_count and lyte.get_monitor_count or function() end
--- Get the name of the monitor at the index 
--- @type fun(index: int): string
    lyte.get_monitor_name = lyte.get_monitor_name and lyte.get_monitor_name or function() end
--- Get the width of the monitor at the index 
--- @type fun(index: int): int
    lyte.get_monitor_width = lyte.get_monitor_width and lyte.get_monitor_width or function() end
--- Get the height of the monitor at the index 
--- @type fun(index: int): int
    lyte.get_monitor_height = lyte.get_monitor_height and lyte.get_monitor_height or function() end
---  Set the window's initial monitor to the indexed value. Must be set before the window is opened. 
--- @type fun(index: int)
    lyte.set_window_monitor = lyte.set_window_monitor and lyte.set_window_monitor or function() end
---  Set the window resizable flag to the given value. Must be set before the window is opened. 
--- @type fun(resizable: boolean)
    lyte.set_window_resizable = lyte.set_window_resizable and lyte.set_window_resizable or function() end
--- Set the window's minimum possible size. 
--- @type fun(width: int, height: int)
    lyte.set_window_minsize = lyte.set_window_minsize and lyte.set_window_minsize or function() end
--- Set the window's size. 
--- @type fun(width: int, height: int)
    lyte.set_window_size = lyte.set_window_size and lyte.set_window_size or function() end
--- Get the width of the window. 
--- @type fun(): int
    lyte.get_window_width = lyte.get_window_width and lyte.get_window_width or function() end
--- Get the height of the window. 
--- @type fun(): int
    lyte.get_window_height = lyte.get_window_height and lyte.get_window_height or function() end
--- Set the window's position. 
--- @type fun(x: int, y: int)
    lyte.set_window_position = lyte.set_window_position and lyte.set_window_position or function() end
--- Set the window to fullscreen, or windowed mode. 
--- @type fun(fullscreen: boolean)
    lyte.set_fullscreen = lyte.set_fullscreen and lyte.set_fullscreen or function() end
--- Check if the window is set to fullscreen. 
--- @type fun(): boolean
    lyte.is_fullscreen = lyte.is_fullscreen and lyte.is_fullscreen or function() end
--- Set the window's title. 
--- @type fun(title: string)
    lyte.set_window_title = lyte.set_window_title and lyte.set_window_title or function() end
--- Set the window vsync flag to the given value. 
--- @type fun(vsync: boolean)
    lyte.set_window_vsync = lyte.set_window_vsync and lyte.set_window_vsync or function() end
--- Check if the window vsync flag is set. 
--- @type fun(): boolean
    lyte.is_window_vsync = lyte.is_window_vsync and lyte.is_window_vsync or function() end
--- Set the window icon. 
--- @type fun(icon_path: string)
    lyte.set_window_icon_file = lyte.set_window_icon_file and lyte.set_window_icon_file or function() end
--- Set the window margins. Margins are ignored and no drawing can be made there.. 
--- @type fun(left: int, right: int, top: int, bottom: int)
    lyte.set_window_margins = lyte.set_window_margins and lyte.set_window_margins or function() end
--- Set the window paddings. Paddings are can be drawn on. 
--- @type fun(left: int, right: int, top: int, bottom: int)
    lyte.set_window_paddings = lyte.set_window_paddings and lyte.set_window_paddings or function() end
--- Check if the given key is down. 
--- @type fun(key: lyte.KeyboardKey): boolean
    lyte.is_key_down = lyte.is_key_down and lyte.is_key_down or function() end
--- Check if the given key is pressed. 
--- @type fun(key: lyte.KeyboardKey): boolean
    lyte.is_key_pressed = lyte.is_key_pressed and lyte.is_key_pressed or function() end
--- Check if the given key is released. 
--- @type fun(key: lyte.KeyboardKey): boolean
    lyte.is_key_released = lyte.is_key_released and lyte.is_key_released or function() end
--- Check if the given key is repeated. 
--- @type fun(key: lyte.KeyboardKey): boolean
    lyte.is_key_repeat = lyte.is_key_repeat and lyte.is_key_repeat or function() end
--- Get the list of pressed keys. 
--- @type fun(): lyte.KeyList
    lyte.get_pressed_keys = lyte.get_pressed_keys and lyte.get_pressed_keys or function() end
--- Get all keyboard text input from last frame. Output is utf8 encoded. 
--- @type fun(): string
    lyte.get_textinput = lyte.get_textinput and lyte.get_textinput or function() end
--- Check if the given mouse button is down. 
--- @type fun(mouse_button: lyte.MouseButton): boolean
    lyte.is_mouse_down = lyte.is_mouse_down and lyte.is_mouse_down or function() end
--- Check if the given mouse button is pressed. 
--- @type fun(mouse_button: lyte.MouseButton): boolean
    lyte.is_mouse_pressed = lyte.is_mouse_pressed and lyte.is_mouse_pressed or function() end
--- Check if the given mouse button is released. 
--- @type fun(mouse_button: lyte.MouseButton): boolean
    lyte.is_mouse_released = lyte.is_mouse_released and lyte.is_mouse_released or function() end
--- Get the mouse x position. 
--- @type fun(): int
    lyte.get_mouse_x = lyte.get_mouse_x and lyte.get_mouse_x or function() end
--- Get the mouse y position. 
--- @type fun(): int
    lyte.get_mouse_y = lyte.get_mouse_y and lyte.get_mouse_y or function() end
--- Get the number of gamepads. 
--- @type fun(): int
    lyte.get_gamepad_count = lyte.get_gamepad_count and lyte.get_gamepad_count or function() end
--- Get the name of the gamepad at the given index. 
--- @type fun(index: int): string
    lyte.get_gamepad_name = lyte.get_gamepad_name and lyte.get_gamepad_name or function() end
--- Check if the given button of the gamepad at the given index is down. 
--- @type fun(index: int, gamepad_button: lyte.GamepadButton): boolean
    lyte.is_gamepad_down = lyte.is_gamepad_down and lyte.is_gamepad_down or function() end
--- Check if the given button of the gamepad at the given index is pressed. 
--- @type fun(index: int, gamepad_button: lyte.GamepadButton): boolean
    lyte.is_gamepad_pressed = lyte.is_gamepad_pressed and lyte.is_gamepad_pressed or function() end
--- Check if the given button of the gamepad at the given index is released. 
--- @type fun(index: int, gamepad_button: lyte.GamepadButton): boolean
    lyte.is_gamepad_released = lyte.is_gamepad_released and lyte.is_gamepad_released or function() end
--- Get the given axis of the gamepad at the given index. 
--- @type fun(index: int, gamepad_axis: lyte.GamepadAxis): number
    lyte.get_gamepad_axis = lyte.get_gamepad_axis and lyte.get_gamepad_axis or function() end
--- Set the master volume. 
--- @type fun(mastervolume: number)
    lyte.set_mastervolume = lyte.set_mastervolume and lyte.set_mastervolume or function() end
--- Get the master volume. 
--- @type fun(): number
    lyte.get_mastervolume = lyte.get_mastervolume and lyte.get_mastervolume or function() end
--- Free Music resources 
--- @type fun(music: lyte.Music)
    lyte.cleanup_music = lyte.cleanup_music and lyte.cleanup_music or function() end
--- Load the music specified in the path. 
--- @type fun(music_path: string): lyte.Music
    lyte.load_music = lyte.load_music and lyte.load_music or function() end
--- Play the music. 
--- @type fun(music: lyte.Music)
    lyte.play_music = lyte.play_music and lyte.play_music or function() end
--- Pause the music. 
--- @type fun(music: lyte.Music)
    lyte.pause_music = lyte.pause_music and lyte.pause_music or function() end
--- Resume the music. 
--- @type fun(music: lyte.Music)
    lyte.resume_music = lyte.resume_music and lyte.resume_music or function() end
--- Stop the music. 
--- @type fun(music: lyte.Music)
    lyte.stop_music = lyte.stop_music and lyte.stop_music or function() end
--- Check if the given music is playing. 
--- @type fun(music: lyte.Music): boolean
    lyte.is_music_playing = lyte.is_music_playing and lyte.is_music_playing or function() end
--- Get the length of the given music object in seconds. 
--- @type fun(music: lyte.Music): number
    lyte.get_music_length = lyte.get_music_length and lyte.get_music_length or function() end
--- Get the already played length of the given music object in seconds. 
--- @type fun(music: lyte.Music): number
    lyte.get_music_length_played = lyte.get_music_length_played and lyte.get_music_length_played or function() end
--- Move the music time played to the given value. 
--- @type fun(music: lyte.Music, secs: number)
    lyte.seek_music = lyte.seek_music and lyte.seek_music or function() end
--- Set the volume of the given music object. 
--- @type fun(music: lyte.Music, volume: number)
    lyte.set_music_volume = lyte.set_music_volume and lyte.set_music_volume or function() end
--- Set the pan of the given music object. 
--- @type fun(music: lyte.Music, pan: number)
    lyte.set_music_pan = lyte.set_music_pan and lyte.set_music_pan or function() end
--- Set the pitch of the given music object. 
--- @type fun(music: lyte.Music, pitch: number)
    lyte.set_music_pitch = lyte.set_music_pitch and lyte.set_music_pitch or function() end
--- Get the volume of the given music object. 
--- @type fun(music: lyte.Music): number
    lyte.get_music_volume = lyte.get_music_volume and lyte.get_music_volume or function() end
--- Get the pan of the given music object. 
--- @type fun(music: lyte.Music): number
    lyte.get_music_pan = lyte.get_music_pan and lyte.get_music_pan or function() end
--- Get the pitch of the given music object. 
--- @type fun(music: lyte.Music): number
    lyte.get_music_pitch = lyte.get_music_pitch and lyte.get_music_pitch or function() end
--- Free Sound resources 
--- @type fun(sound: lyte.Sound)
    lyte.cleanup_sound = lyte.cleanup_sound and lyte.cleanup_sound or function() end
--- Load the sound specified in the path. 
--- @type fun(sound_path: string): lyte.Sound
    lyte.load_sound = lyte.load_sound and lyte.load_sound or function() end
--- Clone the sound specified in the path. 
--- @type fun(orig: lyte.Sound): lyte.Sound
    lyte.clone_sound = lyte.clone_sound and lyte.clone_sound or function() end
--- Play the sound. 
--- @type fun(sound: lyte.Sound)
    lyte.play_sound = lyte.play_sound and lyte.play_sound or function() end
--- Pause the sound. 
--- @type fun(sound: lyte.Sound)
    lyte.pause_sound = lyte.pause_sound and lyte.pause_sound or function() end
--- Resume the sound. 
--- @type fun(sound: lyte.Sound)
    lyte.resume_sound = lyte.resume_sound and lyte.resume_sound or function() end
--- Stop the sound. 
--- @type fun(sound: lyte.Sound)
    lyte.stop_sound = lyte.stop_sound and lyte.stop_sound or function() end
--- Check if the given sound is playing. 
--- @type fun(sound: lyte.Sound): boolean
    lyte.is_sound_playing = lyte.is_sound_playing and lyte.is_sound_playing or function() end
--- Set the volume of the given sound object. 
--- @type fun(sound: lyte.Sound, volume: number)
    lyte.set_sound_volume = lyte.set_sound_volume and lyte.set_sound_volume or function() end
--- Set the pan of the given sound object. 
--- @type fun(sound: lyte.Sound, pan: number)
    lyte.set_sound_pan = lyte.set_sound_pan and lyte.set_sound_pan or function() end
--- Set the pitch of the given sound object. 
--- @type fun(sound: lyte.Sound, pitch: number)
    lyte.set_sound_pitch = lyte.set_sound_pitch and lyte.set_sound_pitch or function() end
--- Get the volume of the given sound object. 
--- @type fun(sound: lyte.Sound): number
    lyte.get_sound_volume = lyte.get_sound_volume and lyte.get_sound_volume or function() end
--- Get the pan of the given sound object. 
--- @type fun(sound: lyte.Sound): number
    lyte.get_sound_pan = lyte.get_sound_pan and lyte.get_sound_pan or function() end
--- Get the pitch of the given sound object. 
--- @type fun(sound: lyte.Sound): number
    lyte.get_sound_pitch = lyte.get_sound_pitch and lyte.get_sound_pitch or function() end
--- Load the file in the path. 
--- @type fun(file_path: string): string
    lyte.load_textfile = lyte.load_textfile and lyte.load_textfile or function() end
--- Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. 
--- @type fun(file_path: string, data: string)
    lyte.save_textfile = lyte.save_textfile and lyte.save_textfile or function() end
--- Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. 
--- @type fun(file_path: string, data: string)
    lyte.save_textfile_append = lyte.save_textfile_append and lyte.save_textfile_append or function() end
--- Push the transform matrix. 
--- @type fun()
    lyte.push_matrix = lyte.push_matrix and lyte.push_matrix or function() end
--- Pop the transform matrix. 
--- @type fun()
    lyte.pop_matrix = lyte.pop_matrix and lyte.pop_matrix or function() end
--- Reset the transformation matrix (load identity matrix.) 
--- @type fun()
    lyte.reset_matrix = lyte.reset_matrix and lyte.reset_matrix or function() end
--- Apply translation (changes transform matrix.) 
--- @type fun(delta_x: number, delta_y: number)
    lyte.translate = lyte.translate and lyte.translate or function() end
--- Apply rotation (changes transform matrix.) 
--- @type fun(angle: number)
    lyte.rotate = lyte.rotate and lyte.rotate or function() end
--- Apply rotation at the given location (changes transform matrix.) 
--- @type fun(angle: number, x: number, y: number)
    lyte.rotate_at = lyte.rotate_at and lyte.rotate_at or function() end
--- Apply scaling (changes transform matrix.) 
--- @type fun(scale_x: number, scale_y: number)
    lyte.scale = lyte.scale and lyte.scale or function() end
--- Apply scaling at the given location (changes transform matrix.) 
--- @type fun(scale_x: number, scale_y: number, x: number, y: number)
    lyte.scale_at = lyte.scale_at and lyte.scale_at or function() end
--- Set the default blendmode. 
--- @type fun(blendmode: lyte.BlendMode)
    lyte.set_default_blendmode = lyte.set_default_blendmode and lyte.set_default_blendmode or function() end
--- Set the effective blendmode. 
--- @type fun(blendmode: lyte.BlendMode)
    lyte.set_blendmode = lyte.set_blendmode and lyte.set_blendmode or function() end
--- Reset the blendmode value to its default value. 
--- @type fun()
    lyte.reset_blendmode = lyte.reset_blendmode and lyte.reset_blendmode or function() end
--- Set the default filtermode. 
--- @type fun(filtermode: lyte.FilterMode)
    lyte.set_default_filtermode = lyte.set_default_filtermode and lyte.set_default_filtermode or function() end
--- Set the effective filtermode. 
--- @type fun(filtermode: lyte.FilterMode)
    lyte.set_filtermode = lyte.set_filtermode and lyte.set_filtermode or function() end
--- Reset the filtermode value to its default value. 
--- @type fun()
    lyte.reset_filtermode = lyte.reset_filtermode and lyte.reset_filtermode or function() end
--- Free ShaderBuilder resources 
--- @type fun(shaderbuilder: lyte.ShaderBuilder)
    lyte.cleanup_shaderbuilder = lyte.cleanup_shaderbuilder and lyte.cleanup_shaderbuilder or function() end
--- Create a ShaderBuilder object. 
--- @type fun(): lyte.ShaderBuilder
    lyte.new_shaderbuilder = lyte.new_shaderbuilder and lyte.new_shaderbuilder or function() end
--- Add uniform definition to the shaderbuilder 
--- @type fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
    lyte.shaderbuilder_uniform = lyte.shaderbuilder_uniform and lyte.shaderbuilder_uniform or function() end
--- Add vertex code to the shaderbuilder 
--- @type fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
    lyte.shaderbuilder_vertex = lyte.shaderbuilder_vertex and lyte.shaderbuilder_vertex or function() end
--- Add fragment to the shaderbuilder 
--- @type fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
    lyte.shaderbuilder_fragment = lyte.shaderbuilder_fragment and lyte.shaderbuilder_fragment or function() end
--- Add fragment to the shaderbuilder 
--- @type fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
    lyte.shaderbuilder_build = lyte.shaderbuilder_build and lyte.shaderbuilder_build or function() end
--- Free Shader resources 
--- @type fun(shader: lyte.Shader)
    lyte.cleanup_shader = lyte.cleanup_shader and lyte.cleanup_shader or function() end
--- Create a shader with given specification. 
--- @type fun(shaderdef: lyte.ShaderDef): lyte.Shader
    lyte.new_shader = lyte.new_shader and lyte.new_shader or function() end
--- Set the custom shader and use it for consequent calls. 
--- @type fun(shader: lyte.Shader)
    lyte.set_shader = lyte.set_shader and lyte.set_shader or function() end
--- Reset the shader, back to framework defaults. 
--- @type fun()
    lyte.reset_shader = lyte.reset_shader and lyte.reset_shader or function() end
--- Set the specified uniform. 
--- @type fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
    lyte.set_shader_uniform = lyte.set_shader_uniform and lyte.set_shader_uniform or function() end
--- Reset the specified uniform. 
--- @type fun(shader: lyte.Shader, uniform_name: string)
    lyte.reset_shader_uniform = lyte.reset_shader_uniform and lyte.reset_shader_uniform or function() end
--- Cleanup the physics world (dynamics + collision). 
--- @type fun(world: lyte.World)
    lyte.cleanup_world = lyte.cleanup_world and lyte.cleanup_world or function() end
--- Create a new physics world 
--- @type fun(): lyte.World
    lyte.new_world = lyte.new_world and lyte.new_world or function() end
--- Update the physics world (dynamics + collision). 
--- @type fun(world: lyte.World, step_size: number)
    lyte.update_world = lyte.update_world and lyte.update_world or function() end
--- Update the physics world gravity. 
--- @type fun(world: lyte.World, x: number, y: number)
    lyte.set_world_gravity = lyte.set_world_gravity and lyte.set_world_gravity or function() end
--- Cleanup the physics collider. 
--- @type fun(collider: lyte.Collider)
    lyte.cleanup_collider = lyte.cleanup_collider and lyte.cleanup_collider or function() end
--- Refresh the physics collider position (x, y) and angle 
--- @type fun(collider: lyte.Collider)
    lyte.refresh_collider = lyte.refresh_collider and lyte.refresh_collider or function() end
--- Create new circle collider (body + geom) in the given physics world. 
--- @type fun(world: lyte.World, radius: number, x: number, y: number, angle: number)
    lyte.new_circle_collider = lyte.new_circle_collider and lyte.new_circle_collider or function() end
--- Create new rectangle collider (body + geom) in the given physics world. 
--- @type fun(world: lyte.World, width: number, height: number, x: number, y: number, angle: number)
    lyte.new_rect_collider = lyte.new_rect_collider and lyte.new_rect_collider or function() end
--- Set collider position. 
--- @type fun(collider: lyte.Collider, x: number, y: number)
    lyte.set_collider_position = lyte.set_collider_position and lyte.set_collider_position or function() end
--- Set collider rotation. 
--- @type fun(collider: lyte.Collider, angle: number)
    lyte.set_collider_rotation = lyte.set_collider_rotation and lyte.set_collider_rotation or function() end
--- Add force to collider. 
--- @type fun(collider: lyte.Collider, fx: number, fy: number)
    lyte.add_force_to_collider = lyte.add_force_to_collider and lyte.add_force_to_collider or function() end
--- Add torque to collider. 
--- @type fun(collider: lyte.Collider, fz: number)
    lyte.add_torque_to_collider = lyte.add_torque_to_collider and lyte.add_torque_to_collider or function() end
--- Set the collider's linear velocity 
--- @type fun(collider: lyte.Collider, vx: number, vy: number)
    lyte.set_collider_linear_velocity = lyte.set_collider_linear_velocity and lyte.set_collider_linear_velocity or function() end
--- Set the collider's angular velocity 
--- @type fun(collider: lyte.Collider, vz: number)
    lyte.set_collider_angular_velocity = lyte.set_collider_angular_velocity and lyte.set_collider_angular_velocity or function() end
--- Set the collider as 'kinematic'. By default, it's not kinematic. 
--- @type fun(collider: lyte.Collider, val: boolean)
    lyte.set_collider_kinematic = lyte.set_collider_kinematic and lyte.set_collider_kinematic or function() end
--- Is the collider set as 'kinematic'? By default, it's not. 
--- @type fun(collider: lyte.Collider): boolean
    lyte.is_collider_kinematic = lyte.is_collider_kinematic and lyte.is_collider_kinematic or function() end
--- Get the number of collisions in the current frame 
--- @type fun(collider: lyte.Collider): int
    lyte.get_collider_collision_count = lyte.get_collider_collision_count and lyte.get_collider_collision_count or function() end
--- Get the collision data in the current frame as a list 
--- @type fun(collider: lyte.Collider): lyte.CollisionList
    lyte.get_collider_collisions = lyte.get_collider_collisions and lyte.get_collider_collisions or function() end

-- records

-- Shader definition: uniforms declaration, vertex and fragment shader code. 
--- @class lyte.ShaderDef
    --- @field frag string
    --- @field vert string
    --- @field uniforms lyte.UniformNamesToTypes
    lyte.ShaderDef = lyte.ShaderDef and lyte.ShaderDef or {}
-- Image type 
--- @class lyte.Image
    --- @field width int
    --- @field height int
    --- @field is_canvas boolean
    --- @field __gc fun(image: lyte.Image)
    lyte.Image = lyte.Image and lyte.Image or {}
-- ImageBatch type. 
--- @class lyte.ImageBatch
    --- @field rect_count int
    --- @field add_rect fun(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
    --- @field draw fun(imagebatch: lyte.ImageBatch)
    --- @field reset fun(imagebatch: lyte.ImageBatch)
    --- @field __gc fun(imagebatch: lyte.ImageBatch)
    lyte.ImageBatch = lyte.ImageBatch and lyte.ImageBatch or {}
-- Font type. 
--- @class lyte.Font
    --- @field __gc fun(font: lyte.Font)
    lyte.Font = lyte.Font and lyte.Font or {}
-- Music type. 
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
    --- @field __gc fun(music: lyte.Music)
    lyte.Music = lyte.Music and lyte.Music or {}
-- Sound type. 
--- @class lyte.Sound
    --- @field pan number
    --- @field pitch number
    --- @field volume number
    --- @field clone fun(orig: lyte.Sound): lyte.Sound
    --- @field pause fun(sound: lyte.Sound)
    --- @field play fun(sound: lyte.Sound)
    --- @field resume fun(sound: lyte.Sound)
    --- @field stop fun(sound: lyte.Sound)
    --- @field __gc fun(sound: lyte.Sound)
    lyte.Sound = lyte.Sound and lyte.Sound or {}
-- Shader type 
--- @class lyte.Shader
    --- @field set fun(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
    --- @field reset fun(shader: lyte.Shader, uniform_name: string)
    --- @field __gc fun(shader: lyte.Shader)
    lyte.Shader = lyte.Shader and lyte.Shader or {}
-- ShaderBuilder type 
--- @class lyte.ShaderBuilder
    --- @field uniform fun(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
    --- @field vertex fun(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
    --- @field fragment fun(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
    --- @field build fun(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
    --- @field __gc fun(shaderbuilder: lyte.ShaderBuilder)
    lyte.ShaderBuilder = lyte.ShaderBuilder and lyte.ShaderBuilder or {}
-- Physics dynamics world + collision space. 
--- @class lyte.World
    --- @field update fun(world: lyte.World, step_size: number)
    --- @field set_gravity fun(world: lyte.World, x: number, y: number)
    --- @field new_circle_collider fun(world: lyte.World, radius: number, x: number, y: number, angle: number)
    --- @field new_rect_collider fun(world: lyte.World, width: number, height: number, x: number, y: number, angle: number)
    --- @field __gc fun(world: lyte.World)
    lyte.World = lyte.World and lyte.World or {}
-- Physics body + mass + colliding geometry. 
--- @class lyte.Collider
    --- @field x number
    --- @field y number
    --- @field angle number
    --- @field refresh fun(collider: lyte.Collider)
    --- @field set_position fun(collider: lyte.Collider, x: number, y: number)
    --- @field set_rotation fun(collider: lyte.Collider, angle: number)
    --- @field set_linear_velocity fun(collider: lyte.Collider, vx: number, vy: number)
    --- @field set_angular_velocity fun(collider: lyte.Collider, vz: number)
    --- @field add_force fun(collider: lyte.Collider, fx: number, fy: number)
    --- @field add_torque fun(collider: lyte.Collider, fz: number)
    --- @field is_kinematic fun(collider: lyte.Collider): boolean
    --- @field set_kinematic fun(collider: lyte.Collider, val: boolean)
    --- @field get_collision_count fun(collider: lyte.Collider): int
    --- @field get_collisions fun(collider: lyte.Collider): lyte.CollisionList
    --- @field __gc fun(collider: lyte.Collider)
    lyte.Collider = lyte.Collider and lyte.Collider or {}
-- Collision information between two colliders 
--- @class lyte.Collision
    --- @field c1 lyte.Collider
    --- @field c2 lyte.Collider
    --- @field pos_x number
    --- @field pos_y number
    --- @field depth number
    lyte.Collision = lyte.Collision and lyte.Collision or {}
-- Physics joints (constraints). 
--- @class lyte.Joint
    lyte.Joint = lyte.Joint and lyte.Joint or {}

-- variants (unions)

---Shader uniform value 
--- @alias lyte.ShaderUniformValue  number | lyte.FloatVec4 | lyte.Image

-- lists

--- Float values
--- @alias lyte.FloatVec4 number[]
--- Collision List
--- @alias lyte.CollisionList userdata[]

-- dicts

--- 
--- @alias lyte.UniformNamesToTypes {[string]: lyte.UniformType}

-- enums

--- Acceptable uniformtype values.
--- @alias lyte.UniformType "_invalid" | "float" | "vec2" | "vec3" | "vec4" | "int" | "ivec2" | "ivec3" | "ivec4" | "mat4" | "sampler2D"
--- Acceptable blendmode values.
--- @alias lyte.BlendMode "none" | "blend" | "add" | "mod" | "mul"
--- Acceptable filtermode values.
--- @alias lyte.FilterMode "_invalid" | "nearest" | "linear"
--- Acceptable gamepadaxis values.
--- @alias lyte.GamepadAxis "left_x" | "left_y" | "right_x" | "right_y" | "left_trigger" | "right_trigger"
--- Acceptable gamepadbutton values.
--- @alias lyte.GamepadButton "pad_a" | "pad_b" | "pad_x" | "pad_y" | "left_bumper" | "right_bumper" | "back" | "start" | "guide" | "left_thumb" | "right_thumb" | "dpad_up" | "dpad_right" | "dpad_down" | "dpad_left"
--- Acceptable mousebutton values.
--- @alias lyte.MouseButton "mb1" | "mb2" | "mb3" | "mb4" | "mb5" | "mb6" | "mb7" | "mb8" | "scrollup" | "scrolldown"
--- Acceptable keyboardkey values.
--- @alias lyte.KeyboardKey "space" | "'" | "," | "-" | "." | "/" | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | ";" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "[" | "\\" | "]" | "`" | "world_1" | "world_2" | "escape" | "enter" | "tab" | "backspace" | "insert" | "delete" | "right" | "left" | "down" | "up" | "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" | "num_lock" | "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" | "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" | "f21" | "f22" | "f23" | "f24" | "f25" | "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" | "kp_6" | "kp_7" | "kp_8" | "kp_9" | "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" | "kp_add" | "kp_enter" | "kp_equal" | "left_shift" | "left_control" | "left_alt" | "left_super" | "right_shift" | "right_control" | "right_alt" | "right_super" | "menu"

-- generated

--- @meta
--- @class lyte_core
    lyte_core = lyte_core or {}

-- functions

--- Quit the application by closing the window. 
--- @type fun()
    lyte_core.quit = lyte_core.quit and lyte_core.quit or function() end
--- Clear the screen or current canvas if one is used. 
--- @type fun(r: number, g: number, b: number, a: number)
    lyte_core.cls = lyte_core.cls and lyte_core.cls or function() end
--- Set the foreground color to be used in the drawing operations. 
--- @type fun(r: number, g: number, b: number, a: number)
    lyte_core.set_color = lyte_core.set_color and lyte_core.set_color or function() end
--- Reset the foreground color to its default value. 
--- @type fun()
    lyte_core.reset_color = lyte_core.reset_color and lyte_core.reset_color or function() end
--- Draw a point. 
--- @type fun(x: number, y: number)
    lyte_core.draw_point = lyte_core.draw_point and lyte_core.draw_point or function() end
--- Draw a line 
--- @type fun(x1: number, y1: number, x2: number, y2: number)
    lyte_core.draw_line = lyte_core.draw_line and lyte_core.draw_line or function() end
--- Draw a filled triangle 
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    lyte_core.draw_triangle = lyte_core.draw_triangle and lyte_core.draw_triangle or function() end
--- Draw a triangle border 
--- @type fun(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    lyte_core.draw_triangle_line = lyte_core.draw_triangle_line and lyte_core.draw_triangle_line or function() end
--- Draw a filled rectangle. 
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    lyte_core.draw_rect = lyte_core.draw_rect and lyte_core.draw_rect or function() end
--- Draw a rectangle border. 
--- @type fun(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    lyte_core.draw_rect_line = lyte_core.draw_rect_line and lyte_core.draw_rect_line or function() end
--- Draw a filled circle. 
--- @type fun(dest_x: number, dest_y: number, radius: number)
    lyte_core.draw_circle = lyte_core.draw_circle and lyte_core.draw_circle or function() end
--- Draw a circle border. 
--- @type fun(dest_x: number, dest_y: number, radius: number)
    lyte_core.draw_circle_line = lyte_core.draw_circle_line and lyte_core.draw_circle_line or function() end
--- Draw a filled ellipse. 
--- @type fun(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    lyte_core.draw_ellipse = lyte_core.draw_ellipse and lyte_core.draw_ellipse or function() end
--- Draw an ellipse border. 
--- @type fun(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    lyte_core.draw_ellipse_line = lyte_core.draw_ellipse_line and lyte_core.draw_ellipse_line or function() end
--- Free Image resources 
--- @type fun(image: userdata)
    lyte_core.image_cleanup = lyte_core.image_cleanup and lyte_core.image_cleanup or function() end
--- Load the image specified in the path. 
--- @type fun(image_path: string): userdata
    lyte_core.image_load = lyte_core.image_load and lyte_core.image_load or function() end
--- Draw an image. 
--- @type fun(image: userdata, dest_x: number, dest_y: number)
    lyte_core.image_draw = lyte_core.image_draw and lyte_core.image_draw or function() end
--- Draw an image. 
--- @type fun(image: userdata, dest_x: number, dest_y: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    lyte_core.image_draw_ex = lyte_core.image_draw_ex and lyte_core.image_draw_ex or function() end
--- Draw a rectangular area from the image. 
--- @type fun(image: userdata, dest_x: number, dest_y: number, src_x: number, src_y: number, src_width: number, src_height: number)
    lyte_core.image_draw_rect = lyte_core.image_draw_rect and lyte_core.image_draw_rect or function() end
--- Draw a rectangular area from the image. 
--- @type fun(image: userdata, dest_x: number, dest_y: number, src_x: number, src_y: number, src_width: number, src_height: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    lyte_core.image_draw_rect_ex = lyte_core.image_draw_rect_ex and lyte_core.image_draw_rect_ex or function() end
--- Get the width of the image. 
--- @type fun(image: userdata): int
    lyte_core.image_get_width = lyte_core.image_get_width and lyte_core.image_get_width or function() end
--- Get the height of the image. 
--- @type fun(image: userdata): int
    lyte_core.image_get_height = lyte_core.image_get_height and lyte_core.image_get_height or function() end
--- Create a canvas image with given width and height. 
--- @type fun(width: int, height: int): userdata
    lyte_core.image_new_canvas = lyte_core.image_new_canvas and lyte_core.image_new_canvas or function() end
--- Set the effective canvas image. All draw operations will go to this canvas until it's reset. 
--- @type fun(canvas_image: userdata)
    lyte_core.image_set_canvas = lyte_core.image_set_canvas and lyte_core.image_set_canvas or function() end
--- Reset the drawing target, back to screen. 
--- @type fun()
    lyte_core.reset_canvas = lyte_core.reset_canvas and lyte_core.reset_canvas or function() end
--- Check if the image was created as a canvas. 
--- @type fun(image: userdata): boolean
    lyte_core.image_is_canvas = lyte_core.image_is_canvas and lyte_core.image_is_canvas or function() end
--- Free ImageBatch resources 
--- @type fun(imagebatch: userdata)
    lyte_core.imagebatch_cleanup = lyte_core.imagebatch_cleanup and lyte_core.imagebatch_cleanup or function() end
--- Create an image batch 
--- @type fun(image: userdata): userdata
    lyte_core.imagebatch_new = lyte_core.imagebatch_new and lyte_core.imagebatch_new or function() end
--- Reset the image batch, remove all added rects. 
--- @type fun(imagebatch: userdata)
    lyte_core.imagebatch_reset = lyte_core.imagebatch_reset and lyte_core.imagebatch_reset or function() end
--- Add a recta to the image batch (from it's initial image). 
--- @type fun(imagebatch: userdata, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
    lyte_core.imagebatch_add_rect = lyte_core.imagebatch_add_rect and lyte_core.imagebatch_add_rect or function() end
--- Get the number of rects in the image batch. 
--- @type fun(imagebatch: userdata): int
    lyte_core.imagebatch_get_rect_count = lyte_core.imagebatch_get_rect_count and lyte_core.imagebatch_get_rect_count or function() end
--- Draw the image batch. 
--- @type fun(imagebatch: userdata)
    lyte_core.imagebatch_draw = lyte_core.imagebatch_draw and lyte_core.imagebatch_draw or function() end
--- Free Font resources 
--- @type fun(font: userdata)
    lyte_core.font_cleanup = lyte_core.font_cleanup and lyte_core.font_cleanup or function() end
--- Load the font specified in the path, and set the initial size. 
--- @type fun(font_path: string, size: number): userdata
    lyte_core.font_load = lyte_core.font_load and lyte_core.font_load or function() end
--- Set the effective font to be used in the drawing operations. 
--- @type fun(font: userdata)
    lyte_core.font_set = lyte_core.font_set and lyte_core.font_set or function() end
--- Draw a text line. 
--- @type fun(text: string, dest_x: number, dest_y: number)
    lyte_core.draw_text = lyte_core.draw_text and lyte_core.draw_text or function() end
--- Get the width of the given text line. 
--- @type fun(text: string): int
    lyte_core.get_text_width = lyte_core.get_text_width and lyte_core.get_text_width or function() end
--- Get the height of the given text line. 
--- @type fun(text: string): int
    lyte_core.get_text_height = lyte_core.get_text_height and lyte_core.get_text_height or function() end
--- Get the number of currently connected monitors. 
--- @type fun(): int
    lyte_core.get_monitor_count = lyte_core.get_monitor_count and lyte_core.get_monitor_count or function() end
--- Get the name of the monitor at the index 
--- @type fun(index: int): string
    lyte_core.get_monitor_name = lyte_core.get_monitor_name and lyte_core.get_monitor_name or function() end
--- Get the width of the monitor at the index 
--- @type fun(index: int): int
    lyte_core.get_monitor_width = lyte_core.get_monitor_width and lyte_core.get_monitor_width or function() end
--- Get the height of the monitor at the index 
--- @type fun(index: int): int
    lyte_core.get_monitor_height = lyte_core.get_monitor_height and lyte_core.get_monitor_height or function() end
---  Set the window's initial monitor to the indexed value. Must be set before the window is opened. 
--- @type fun(index: int)
    lyte_core.set_window_monitor = lyte_core.set_window_monitor and lyte_core.set_window_monitor or function() end
---  Set the window resizable flag to the given value. Must be set before the window is opened. 
--- @type fun(resizable: boolean)
    lyte_core.set_window_resizable = lyte_core.set_window_resizable and lyte_core.set_window_resizable or function() end
--- Set the window's minimum possible size. 
--- @type fun(width: int, height: int)
    lyte_core.set_window_minsize = lyte_core.set_window_minsize and lyte_core.set_window_minsize or function() end
--- Set the window's size. 
--- @type fun(width: int, height: int)
    lyte_core.set_window_size = lyte_core.set_window_size and lyte_core.set_window_size or function() end
--- Get the width of the window. 
--- @type fun(): int
    lyte_core.get_window_width = lyte_core.get_window_width and lyte_core.get_window_width or function() end
--- Get the height of the window. 
--- @type fun(): int
    lyte_core.get_window_height = lyte_core.get_window_height and lyte_core.get_window_height or function() end
--- Set the window's position. 
--- @type fun(x: int, y: int)
    lyte_core.set_window_position = lyte_core.set_window_position and lyte_core.set_window_position or function() end
--- Set the window to fullscreen, or windowed mode. 
--- @type fun(fullscreen: boolean)
    lyte_core.set_fullscreen = lyte_core.set_fullscreen and lyte_core.set_fullscreen or function() end
--- Check if the window is set to fullscreen. 
--- @type fun(): boolean
    lyte_core.is_fullscreen = lyte_core.is_fullscreen and lyte_core.is_fullscreen or function() end
--- Set the window's title. 
--- @type fun(title: string)
    lyte_core.set_window_title = lyte_core.set_window_title and lyte_core.set_window_title or function() end
--- Set the window vsync flag to the given value. 
--- @type fun(vsync: boolean)
    lyte_core.set_window_vsync = lyte_core.set_window_vsync and lyte_core.set_window_vsync or function() end
--- Check if the window vsync flag is set. 
--- @type fun(): boolean
    lyte_core.is_window_vsync = lyte_core.is_window_vsync and lyte_core.is_window_vsync or function() end
--- Set the window icon. 
--- @type fun(icon_path: string)
    lyte_core.set_window_icon_file = lyte_core.set_window_icon_file and lyte_core.set_window_icon_file or function() end
--- Set the window margins. Margins are ignored and no drawing can be made there.. 
--- @type fun(left: int, right: int, top: int, bottom: int)
    lyte_core.set_window_margins = lyte_core.set_window_margins and lyte_core.set_window_margins or function() end
--- Set the window paddings. Paddings are can be drawn on. 
--- @type fun(left: int, right: int, top: int, bottom: int)
    lyte_core.set_window_paddings = lyte_core.set_window_paddings and lyte_core.set_window_paddings or function() end
--- Check if the given key is down. 
--- @type fun(key: lyte_core.KeyboardKey): boolean
    lyte_core.is_key_down = lyte_core.is_key_down and lyte_core.is_key_down or function() end
--- Check if the given key is pressed. 
--- @type fun(key: lyte_core.KeyboardKey): boolean
    lyte_core.is_key_pressed = lyte_core.is_key_pressed and lyte_core.is_key_pressed or function() end
--- Check if the given key is released. 
--- @type fun(key: lyte_core.KeyboardKey): boolean
    lyte_core.is_key_released = lyte_core.is_key_released and lyte_core.is_key_released or function() end
--- Check if the given key is repeated. 
--- @type fun(key: lyte_core.KeyboardKey): boolean
    lyte_core.is_key_repeat = lyte_core.is_key_repeat and lyte_core.is_key_repeat or function() end
--- Get the list of pressed keys. 
--- @type fun(): lyte_core.KeyList
    lyte_core.get_pressed_keys = lyte_core.get_pressed_keys and lyte_core.get_pressed_keys or function() end
--- Get all keyboard text input from last frame. Output is utf8 encoded. 
--- @type fun(): string
    lyte_core.get_textinput = lyte_core.get_textinput and lyte_core.get_textinput or function() end
--- Check if the given mouse button is down. 
--- @type fun(mouse_button: lyte_core.MouseButton): boolean
    lyte_core.is_mouse_down = lyte_core.is_mouse_down and lyte_core.is_mouse_down or function() end
--- Check if the given mouse button is pressed. 
--- @type fun(mouse_button: lyte_core.MouseButton): boolean
    lyte_core.is_mouse_pressed = lyte_core.is_mouse_pressed and lyte_core.is_mouse_pressed or function() end
--- Check if the given mouse button is released. 
--- @type fun(mouse_button: lyte_core.MouseButton): boolean
    lyte_core.is_mouse_released = lyte_core.is_mouse_released and lyte_core.is_mouse_released or function() end
--- Get the mouse x position. 
--- @type fun(): int
    lyte_core.get_mouse_x = lyte_core.get_mouse_x and lyte_core.get_mouse_x or function() end
--- Get the mouse y position. 
--- @type fun(): int
    lyte_core.get_mouse_y = lyte_core.get_mouse_y and lyte_core.get_mouse_y or function() end
--- Get the number of gamepads. 
--- @type fun(): int
    lyte_core.get_gamepad_count = lyte_core.get_gamepad_count and lyte_core.get_gamepad_count or function() end
--- Get the name of the gamepad at the given index. 
--- @type fun(index: int): string
    lyte_core.get_gamepad_name = lyte_core.get_gamepad_name and lyte_core.get_gamepad_name or function() end
--- Check if the given button of the gamepad at the given index is down. 
--- @type fun(index: int, gamepad_button: lyte_core.GamepadButton): boolean
    lyte_core.is_gamepad_down = lyte_core.is_gamepad_down and lyte_core.is_gamepad_down or function() end
--- Check if the given button of the gamepad at the given index is pressed. 
--- @type fun(index: int, gamepad_button: lyte_core.GamepadButton): boolean
    lyte_core.is_gamepad_pressed = lyte_core.is_gamepad_pressed and lyte_core.is_gamepad_pressed or function() end
--- Check if the given button of the gamepad at the given index is released. 
--- @type fun(index: int, gamepad_button: lyte_core.GamepadButton): boolean
    lyte_core.is_gamepad_released = lyte_core.is_gamepad_released and lyte_core.is_gamepad_released or function() end
--- Get the given axis of the gamepad at the given index. 
--- @type fun(index: int, gamepad_axis: lyte_core.GamepadAxis): number
    lyte_core.get_gamepad_axis = lyte_core.get_gamepad_axis and lyte_core.get_gamepad_axis or function() end
--- Set the master volume. 
--- @type fun(mastervolume: number)
    lyte_core.set_mastervolume = lyte_core.set_mastervolume and lyte_core.set_mastervolume or function() end
--- Get the master volume. 
--- @type fun(): number
    lyte_core.get_mastervolume = lyte_core.get_mastervolume and lyte_core.get_mastervolume or function() end
--- Free Music resources 
--- @type fun(music: userdata)
    lyte_core.music_cleanup = lyte_core.music_cleanup and lyte_core.music_cleanup or function() end
--- Load the music specified in the path. 
--- @type fun(music_path: string): userdata
    lyte_core.music_load = lyte_core.music_load and lyte_core.music_load or function() end
--- Play the music. 
--- @type fun(music: userdata)
    lyte_core.music_play = lyte_core.music_play and lyte_core.music_play or function() end
--- Pause the music. 
--- @type fun(music: userdata)
    lyte_core.music_pause = lyte_core.music_pause and lyte_core.music_pause or function() end
--- Resume the music. 
--- @type fun(music: userdata)
    lyte_core.music_resume = lyte_core.music_resume and lyte_core.music_resume or function() end
--- Stop the music. 
--- @type fun(music: userdata)
    lyte_core.music_stop = lyte_core.music_stop and lyte_core.music_stop or function() end
--- Check if the given music is playing. 
--- @type fun(music: userdata): boolean
    lyte_core.music_is_playing = lyte_core.music_is_playing and lyte_core.music_is_playing or function() end
--- Get the length of the given music object in seconds. 
--- @type fun(music: userdata): number
    lyte_core.music_get_length = lyte_core.music_get_length and lyte_core.music_get_length or function() end
--- Get the already played length of the given music object in seconds. 
--- @type fun(music: userdata): number
    lyte_core.music_get_length_played = lyte_core.music_get_length_played and lyte_core.music_get_length_played or function() end
--- Move the music time played to the given value. 
--- @type fun(music: userdata, secs: number)
    lyte_core.music_seek = lyte_core.music_seek and lyte_core.music_seek or function() end
--- Set the volume of the given music object. 
--- @type fun(music: userdata, volume: number)
    lyte_core.music_set_volume = lyte_core.music_set_volume and lyte_core.music_set_volume or function() end
--- Set the pan of the given music object. 
--- @type fun(music: userdata, pan: number)
    lyte_core.music_set_pan = lyte_core.music_set_pan and lyte_core.music_set_pan or function() end
--- Set the pitch of the given music object. 
--- @type fun(music: userdata, pitch: number)
    lyte_core.music_set_pitch = lyte_core.music_set_pitch and lyte_core.music_set_pitch or function() end
--- Get the volume of the given music object. 
--- @type fun(music: userdata): number
    lyte_core.music_get_volume = lyte_core.music_get_volume and lyte_core.music_get_volume or function() end
--- Get the pan of the given music object. 
--- @type fun(music: userdata): number
    lyte_core.music_get_pan = lyte_core.music_get_pan and lyte_core.music_get_pan or function() end
--- Get the pitch of the given music object. 
--- @type fun(music: userdata): number
    lyte_core.music_get_pitch = lyte_core.music_get_pitch and lyte_core.music_get_pitch or function() end
--- Free Sound resources 
--- @type fun(sound: userdata)
    lyte_core.sound_cleanup = lyte_core.sound_cleanup and lyte_core.sound_cleanup or function() end
--- Load the sound specified in the path. 
--- @type fun(sound_path: string): userdata
    lyte_core.sound_load = lyte_core.sound_load and lyte_core.sound_load or function() end
--- Clone the sound specified in the path. 
--- @type fun(orig: userdata): userdata
    lyte_core.sound_clone = lyte_core.sound_clone and lyte_core.sound_clone or function() end
--- Play the sound. 
--- @type fun(sound: userdata)
    lyte_core.sound_play = lyte_core.sound_play and lyte_core.sound_play or function() end
--- Pause the sound. 
--- @type fun(sound: userdata)
    lyte_core.sound_pause = lyte_core.sound_pause and lyte_core.sound_pause or function() end
--- Resume the sound. 
--- @type fun(sound: userdata)
    lyte_core.sound_resume = lyte_core.sound_resume and lyte_core.sound_resume or function() end
--- Stop the sound. 
--- @type fun(sound: userdata)
    lyte_core.sound_stop = lyte_core.sound_stop and lyte_core.sound_stop or function() end
--- Check if the given sound is playing. 
--- @type fun(sound: userdata): boolean
    lyte_core.sound_is_playing = lyte_core.sound_is_playing and lyte_core.sound_is_playing or function() end
--- Set the volume of the given sound object. 
--- @type fun(sound: userdata, volume: number)
    lyte_core.sound_set_volume = lyte_core.sound_set_volume and lyte_core.sound_set_volume or function() end
--- Set the pan of the given sound object. 
--- @type fun(sound: userdata, pan: number)
    lyte_core.sound_set_pan = lyte_core.sound_set_pan and lyte_core.sound_set_pan or function() end
--- Set the pitch of the given sound object. 
--- @type fun(sound: userdata, pitch: number)
    lyte_core.sound_set_pitch = lyte_core.sound_set_pitch and lyte_core.sound_set_pitch or function() end
--- Get the volume of the given sound object. 
--- @type fun(sound: userdata): number
    lyte_core.sound_get_volume = lyte_core.sound_get_volume and lyte_core.sound_get_volume or function() end
--- Get the pan of the given sound object. 
--- @type fun(sound: userdata): number
    lyte_core.sound_get_pan = lyte_core.sound_get_pan and lyte_core.sound_get_pan or function() end
--- Get the pitch of the given sound object. 
--- @type fun(sound: userdata): number
    lyte_core.sound_get_pitch = lyte_core.sound_get_pitch and lyte_core.sound_get_pitch or function() end
--- Load the file in the path. 
--- @type fun(file_path: string): string
    lyte_core.load_textfile = lyte_core.load_textfile and lyte_core.load_textfile or function() end
--- Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. 
--- @type fun(file_path: string, data: string)
    lyte_core.save_textfile = lyte_core.save_textfile and lyte_core.save_textfile or function() end
--- Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. 
--- @type fun(file_path: string, data: string)
    lyte_core.save_textfile_append = lyte_core.save_textfile_append and lyte_core.save_textfile_append or function() end
--- Push the transform matrix. 
--- @type fun()
    lyte_core.push_matrix = lyte_core.push_matrix and lyte_core.push_matrix or function() end
--- Pop the transform matrix. 
--- @type fun()
    lyte_core.pop_matrix = lyte_core.pop_matrix and lyte_core.pop_matrix or function() end
--- Reset the transformation matrix (load identity matrix.) 
--- @type fun()
    lyte_core.reset_matrix = lyte_core.reset_matrix and lyte_core.reset_matrix or function() end
--- Apply translation (changes transform matrix.) 
--- @type fun(delta_x: number, delta_y: number)
    lyte_core.translate = lyte_core.translate and lyte_core.translate or function() end
--- Apply rotation (changes transform matrix.) 
--- @type fun(angle: number)
    lyte_core.rotate = lyte_core.rotate and lyte_core.rotate or function() end
--- Apply rotation at the given location (changes transform matrix.) 
--- @type fun(angle: number, x: number, y: number)
    lyte_core.rotate_at = lyte_core.rotate_at and lyte_core.rotate_at or function() end
--- Apply scaling (changes transform matrix.) 
--- @type fun(scale_x: number, scale_y: number)
    lyte_core.scale = lyte_core.scale and lyte_core.scale or function() end
--- Apply scaling at the given location (changes transform matrix.) 
--- @type fun(scale_x: number, scale_y: number, x: number, y: number)
    lyte_core.scale_at = lyte_core.scale_at and lyte_core.scale_at or function() end
--- Set the default blendmode. 
--- @type fun(blendmode: lyte_core.BlendMode)
    lyte_core.set_default_blendmode = lyte_core.set_default_blendmode and lyte_core.set_default_blendmode or function() end
--- Set the effective blendmode. 
--- @type fun(blendmode: lyte_core.BlendMode)
    lyte_core.set_blendmode = lyte_core.set_blendmode and lyte_core.set_blendmode or function() end
--- Reset the blendmode value to its default value. 
--- @type fun()
    lyte_core.reset_blendmode = lyte_core.reset_blendmode and lyte_core.reset_blendmode or function() end
--- Set the default filtermode. 
--- @type fun(filtermode: lyte_core.FilterMode)
    lyte_core.set_default_filtermode = lyte_core.set_default_filtermode and lyte_core.set_default_filtermode or function() end
--- Set the effective filtermode. 
--- @type fun(filtermode: lyte_core.FilterMode)
    lyte_core.set_filtermode = lyte_core.set_filtermode and lyte_core.set_filtermode or function() end
--- Reset the filtermode value to its default value. 
--- @type fun()
    lyte_core.reset_filtermode = lyte_core.reset_filtermode and lyte_core.reset_filtermode or function() end
--- Free ShaderBuilder resources 
--- @type fun(shaderbuilder: userdata)
    lyte_core.shaderbuilder_cleanup = lyte_core.shaderbuilder_cleanup and lyte_core.shaderbuilder_cleanup or function() end
--- Create a ShaderBuilder object. 
--- @type fun(): userdata
    lyte_core.shaderbuilder_new = lyte_core.shaderbuilder_new and lyte_core.shaderbuilder_new or function() end
--- Add uniform definition to the shaderbuilder 
--- @type fun(shaderbuilder: userdata, uniform_name: string, uniform_type: lyte_core.UniformType)
    lyte_core.shaderbuilder_uniform = lyte_core.shaderbuilder_uniform and lyte_core.shaderbuilder_uniform or function() end
--- Add vertex code to the shaderbuilder 
--- @type fun(shaderbuilder: userdata, vertex_code: string)
    lyte_core.shaderbuilder_vertex = lyte_core.shaderbuilder_vertex and lyte_core.shaderbuilder_vertex or function() end
--- Add fragment to the shaderbuilder 
--- @type fun(shaderbuilder: userdata, fragment_code: string)
    lyte_core.shaderbuilder_fragment = lyte_core.shaderbuilder_fragment and lyte_core.shaderbuilder_fragment or function() end
--- Add fragment to the shaderbuilder 
--- @type fun(shaderbuilder: userdata): userdata
    lyte_core.shaderbuilder_build = lyte_core.shaderbuilder_build and lyte_core.shaderbuilder_build or function() end
--- Free Shader resources 
--- @type fun(shader: userdata)
    lyte_core.shader_cleanup = lyte_core.shader_cleanup and lyte_core.shader_cleanup or function() end
--- Set the custom shader and use it for consequent calls. 
--- @type fun(shader: userdata)
    lyte_core.shader_set = lyte_core.shader_set and lyte_core.shader_set or function() end
--- Reset the shader, back to framework defaults. 
--- @type fun()
    lyte_core.reset_shader = lyte_core.reset_shader and lyte_core.reset_shader or function() end
--- Set the specified uniform. 
--- @type fun(shader: userdata, uniform_name: string, uniform_value: number)
    lyte_core.shader_set_uniform_float = lyte_core.shader_set_uniform_float and lyte_core.shader_set_uniform_float or function() end
--- Set the specified uniform. 
--- @type fun(shader: userdata, uniform_name: string, uniform_value: lyte_core.FloatVec4)
    lyte_core.shader_set_uniform_floatvec4 = lyte_core.shader_set_uniform_floatvec4 and lyte_core.shader_set_uniform_floatvec4 or function() end
--- Set the specified uniform. 
--- @type fun(shader: userdata, uniform_name: string, uniform_value: userdata)
    lyte_core.shader_set_uniform_image = lyte_core.shader_set_uniform_image and lyte_core.shader_set_uniform_image or function() end
--- Reset the specified uniform. 
--- @type fun(shader: userdata, uniform_name: string)
    lyte_core.shader_reset_uniform = lyte_core.shader_reset_uniform and lyte_core.shader_reset_uniform or function() end
--- Create a new physics world. 
--- @type fun(): userdata
    lyte_core.world_new = lyte_core.world_new and lyte_core.world_new or function() end
--- Cleanup (delete) world and all contained objects. 
--- @type fun(world: userdata)
    lyte_core.world_cleanup = lyte_core.world_cleanup and lyte_core.world_cleanup or function() end
--- Set worlds gravity values. By default, gravity is (0, 0). 
--- @type fun(world: userdata, x: number, y: number)
    lyte_core.world_set_gravity = lyte_core.world_set_gravity and lyte_core.world_set_gravity or function() end
--- Update world. 
--- @type fun(world: userdata, step_size: number)
    lyte_core.world_update = lyte_core.world_update and lyte_core.world_update or function() end
--- Create a new physics body. 
--- @type fun(world: userdata): userdata
    lyte_core.body_new = lyte_core.body_new and lyte_core.body_new or function() end
--- Cleanup (delete) a body. 
--- @type fun(body: userdata)
    lyte_core.body_cleanup = lyte_core.body_cleanup and lyte_core.body_cleanup or function() end
--- Set body's position. 
--- @type fun(body: userdata, x: number, y: number)
    lyte_core.body_set_position = lyte_core.body_set_position and lyte_core.body_set_position or function() end
--- Get body's position. 
--- @type fun(body: userdata): number, number
    lyte_core.body_get_position = lyte_core.body_get_position and lyte_core.body_get_position or function() end
--- Set body's rotation (angle). 
--- @type fun(body: userdata, angle: number)
    lyte_core.body_set_rotation = lyte_core.body_set_rotation and lyte_core.body_set_rotation or function() end
--- Get body's rotation (angle). 
--- @type fun(body: userdata): number
    lyte_core.body_get_rotation = lyte_core.body_get_rotation and lyte_core.body_get_rotation or function() end
--- Set body's linear velocity. 
--- @type fun(body: userdata, x: number, y: number)
    lyte_core.body_set_linear_vel = lyte_core.body_set_linear_vel and lyte_core.body_set_linear_vel or function() end
--- Get body's linear velocity. 
--- @type fun(body: userdata): number, number
    lyte_core.body_get_linear_vel = lyte_core.body_get_linear_vel and lyte_core.body_get_linear_vel or function() end
--- Set body's angular velocity. 
--- @type fun(body: userdata, z: number)
    lyte_core.body_set_angular_vel = lyte_core.body_set_angular_vel and lyte_core.body_set_angular_vel or function() end
--- Get body's angular velocity. 
--- @type fun(body: userdata): number
    lyte_core.body_get_angular_vel = lyte_core.body_get_angular_vel and lyte_core.body_get_angular_vel or function() end
--- Set body's (circular) mass. 
--- @type fun(body: userdata, mass: number, radius: number)
    lyte_core.body_set_mass_circle = lyte_core.body_set_mass_circle and lyte_core.body_set_mass_circle or function() end
--- Set body's (rectangular) mass. 
--- @type fun(body: userdata, mass: number, width: number, height: number)
    lyte_core.body_set_mass_rect = lyte_core.body_set_mass_rect and lyte_core.body_set_mass_rect or function() end
--- Add force to body. 
--- @type fun(body: userdata, fx: number, fy: number)
    lyte_core.body_add_force = lyte_core.body_add_force and lyte_core.body_add_force or function() end
--- Get body's linear . 
--- @type fun(body: userdata): number, number
    lyte_core.body_get_force = lyte_core.body_get_force and lyte_core.body_get_force or function() end
--- Add torque to body. 
--- @type fun(body: userdata, fz: number)
    lyte_core.body_add_torque = lyte_core.body_add_torque and lyte_core.body_add_torque or function() end
--- Get body's torque. 
--- @type fun(body: userdata): number
    lyte_core.body_get_torque = lyte_core.body_get_torque and lyte_core.body_get_torque or function() end
--- Set body as 'kinematic'. False by default. 
--- @type fun(body: userdata, val: boolean)
    lyte_core.body_set_kinematic = lyte_core.body_set_kinematic and lyte_core.body_set_kinematic or function() end
--- Is body set as 'kinematic'? False by default. 
--- @type fun(body: userdata): boolean
    lyte_core.body_is_kinematic = lyte_core.body_is_kinematic and lyte_core.body_is_kinematic or function() end
--- Create a new Space for collisions 
--- @type fun(): userdata
    lyte_core.space_new = lyte_core.space_new and lyte_core.space_new or function() end
--- Cleanup the Space (delete). 
--- @type fun(space: userdata)
    lyte_core.space_cleanup = lyte_core.space_cleanup and lyte_core.space_cleanup or function() end
--- Create a new JointGroup. 
--- @type fun(): userdata
    lyte_core.jointgroup_new = lyte_core.jointgroup_new and lyte_core.jointgroup_new or function() end
--- Cleanup the JointGroup (delete). 
--- @type fun(jointgroup: userdata)
    lyte_core.jointgroup_cleanup = lyte_core.jointgroup_cleanup and lyte_core.jointgroup_cleanup or function() end
--- Check collisions for current frame 
--- @type fun(world: userdata, space: userdata, jointgroup: userdata)
    lyte_core.coll_update_check = lyte_core.coll_update_check and lyte_core.coll_update_check or function() end
--- Correct angular drift for 2D 
--- @type fun(space: userdata)
    lyte_core.coll_update_correct = lyte_core.coll_update_correct and lyte_core.coll_update_correct or function() end
--- Get the number of collisions for this body. 
--- @type fun(body: userdata): int
    lyte_core.body_get_collision_count = lyte_core.body_get_collision_count and lyte_core.body_get_collision_count or function() end
--- Get the data of for collision for this body at given index. Indexes start with 0. 
--- @type fun(body: userdata, index: int): userdata, number, number, number
    lyte_core.body_get_collision_data_at = lyte_core.body_get_collision_data_at and lyte_core.body_get_collision_data_at or function() end
--- Cleanup (delete) given joint. 
--- @type fun(joint: userdata)
    lyte_core.joint_cleanup = lyte_core.joint_cleanup and lyte_core.joint_cleanup or function() end
--- Check if the Joint is of class 'hinge'. 
--- @type fun(joint: userdata): boolean
    lyte_core.joint_is_hinge = lyte_core.joint_is_hinge and lyte_core.joint_is_hinge or function() end
--- Check if the Joint is of class 'slider'. 
--- @type fun(joint: userdata): boolean
    lyte_core.joint_is_slider = lyte_core.joint_is_slider and lyte_core.joint_is_slider or function() end
--- Check if the Joint is of class 'fixed'. 
--- @type fun(joint: userdata): boolean
    lyte_core.joint_is_fixed = lyte_core.joint_is_fixed and lyte_core.joint_is_fixed or function() end
--- Get the body at 'index' for the given joint. 
--- @type fun(joint: userdata, index: int): userdata
    lyte_core.joint_get_body = lyte_core.joint_get_body and lyte_core.joint_get_body or function() end
--- Attach the given bodies with the joint. 
--- @type fun(joint: userdata, body1: userdata, body2: userdata)
    lyte_core.joint_attach = lyte_core.joint_attach and lyte_core.joint_attach or function() end
--- Create a new Joint of class 'hinge'. 
--- @type fun(world: userdata, jointgroup: userdata): userdata
    lyte_core.joint_new_hinge = lyte_core.joint_new_hinge and lyte_core.joint_new_hinge or function() end
--- Create a new Joint of class 'slider'. 
--- @type fun(world: userdata, jointgroup: userdata): userdata
    lyte_core.joint_new_slider = lyte_core.joint_new_slider and lyte_core.joint_new_slider or function() end
--- Create a new Joint of class 'fixed'. 
--- @type fun(world: userdata, jointgroup: userdata): userdata
    lyte_core.joint_new_fixed = lyte_core.joint_new_fixed and lyte_core.joint_new_fixed or function() end
--- Set the anchor location for the given hinge joint. 
--- @type fun(joint: userdata, x: number, y: number)
    lyte_core.joint_set_hinge_anchor = lyte_core.joint_set_hinge_anchor and lyte_core.joint_set_hinge_anchor or function() end
--- Get the anchor location for the given hinge joint. From body1. Should be the same for body2. 
--- @type fun(joint: userdata): number, number
    lyte_core.joint_get_hinge_anchor1 = lyte_core.joint_get_hinge_anchor1 and lyte_core.joint_get_hinge_anchor1 or function() end
--- Get the anchor location for the given hinge joint. From body2. Should be the same for body1. 
--- @type fun(joint: userdata): number, number
    lyte_core.joint_get_hinge_anchor2 = lyte_core.joint_get_hinge_anchor2 and lyte_core.joint_get_hinge_anchor2 or function() end
--- Get the angle or the given hinge joint. 
--- @type fun(joint: userdata): number
    lyte_core.joint_get_hinge_angle = lyte_core.joint_get_hinge_angle and lyte_core.joint_get_hinge_angle or function() end
--- Get the angle rate for the given hinge joint. 
--- @type fun(joint: userdata): number
    lyte_core.joint_get_hinge_angle_rate = lyte_core.joint_get_hinge_angle_rate and lyte_core.joint_get_hinge_angle_rate or function() end
--- Set the axis for the given slider joint. 
--- @type fun(joint: userdata, x: number, y: number)
    lyte_core.joint_set_slider_axis = lyte_core.joint_set_slider_axis and lyte_core.joint_set_slider_axis or function() end
--- Get the axis for the given slider joint. 
--- @type fun(joint: userdata): number, number
    lyte_core.joint_get_slider_axis = lyte_core.joint_get_slider_axis and lyte_core.joint_get_slider_axis or function() end
--- Get the slider position for the given slider joint. 
--- @type fun(joint: userdata): number
    lyte_core.joint_get_slider_position = lyte_core.joint_get_slider_position and lyte_core.joint_get_slider_position or function() end
--- Get the slider position rate for the given slider joint. 
--- @type fun(joint: userdata): number
    lyte_core.joint_get_slider_position_rate = lyte_core.joint_get_slider_position_rate and lyte_core.joint_get_slider_position_rate or function() end
--- Set the joint as 'fixed'. 
--- @type fun(joint: userdata)
    lyte_core.joint_set_fixed = lyte_core.joint_set_fixed and lyte_core.joint_set_fixed or function() end
--- Cleanup the Geom (delete). 
--- @type fun(geom: userdata)
    lyte_core.geom_cleanup = lyte_core.geom_cleanup and lyte_core.geom_cleanup or function() end
--- Create a new Geom (for collision). 
--- @type fun(space: userdata, radius: number): userdata
    lyte_core.geom_new_circle = lyte_core.geom_new_circle and lyte_core.geom_new_circle or function() end
--- Create a new Geom (for collision). 
--- @type fun(space: userdata, width: number, height: number): userdata
    lyte_core.geom_new_rect = lyte_core.geom_new_rect and lyte_core.geom_new_rect or function() end
--- Is the Geom a 'circle'? 
--- @type fun(geom: userdata): boolean
    lyte_core.geom_is_circle = lyte_core.geom_is_circle and lyte_core.geom_is_circle or function() end
--- Is the Geom a 'rect'? 
--- @type fun(geom: userdata): boolean
    lyte_core.geom_is_rect = lyte_core.geom_is_rect and lyte_core.geom_is_rect or function() end
--- Set the Geom's (circle) radius. 
--- @type fun(geom: userdata, radius: number)
    lyte_core.geom_set_circle_radius = lyte_core.geom_set_circle_radius and lyte_core.geom_set_circle_radius or function() end
--- Get the Geom's (circle) radius. 
--- @type fun(geom: userdata): number
    lyte_core.geom_get_circle_radius = lyte_core.geom_get_circle_radius and lyte_core.geom_get_circle_radius or function() end
--- Set the Geom's (rect) width and height. 
--- @type fun(geom: userdata, width: number, height: number)
    lyte_core.geom_set_rect_size = lyte_core.geom_set_rect_size and lyte_core.geom_set_rect_size or function() end
--- Get the Geom's (rect) width and height. 
--- @type fun(geom: userdata): number, number
    lyte_core.geom_get_rect_size = lyte_core.geom_get_rect_size and lyte_core.geom_get_rect_size or function() end
--- Get the depth of the point in Geom's (circle). Positive inside, Negative outside, Zero on the surface. 
--- @type fun(geom: userdata, x: number, y: number): number
    lyte_core.geom_get_circle_point_depth = lyte_core.geom_get_circle_point_depth and lyte_core.geom_get_circle_point_depth or function() end
--- Get the depth of the point in Geom's (rect). Positive inside, Negative outside, Zero on the surface. 
--- @type fun(geom: userdata, x: number, y: number): number
    lyte_core.geom_get_rect_point_depth = lyte_core.geom_get_rect_point_depth and lyte_core.geom_get_rect_point_depth or function() end
--- Get the AABB rectangle coord associated with the Geom. 
--- @type fun(geom: userdata): number, number, number, number
    lyte_core.geom_get_AABB = lyte_core.geom_get_AABB and lyte_core.geom_get_AABB or function() end
--- Set a Geom for the Body. 
--- @type fun(geom: userdata, body: userdata)
    lyte_core.geom_set_body = lyte_core.geom_set_body and lyte_core.geom_set_body or function() end
--- Get the Body associated with the Geom. 
--- @type fun(geom: userdata): userdata
    lyte_core.geom_get_body = lyte_core.geom_get_body and lyte_core.geom_get_body or function() end
--- Set the category bit for the Geom. Between 0 and 63. 
--- @type fun(geom: userdata, category_bit: int)
    lyte_core.geom_set_category_bit = lyte_core.geom_set_category_bit and lyte_core.geom_set_category_bit or function() end
--- Is the category bit associated with the Geom? (Between 0 and 63.) 
--- @type fun(geom: userdata, category_bit: int): boolean
    lyte_core.geom_is_category_bit_set = lyte_core.geom_is_category_bit_set and lyte_core.geom_is_category_bit_set or function() end
--- Set the collide bit for the Geom. Between 0 and 63. 
--- @type fun(geom: userdata, collide_bit: int)
    lyte_core.geom_set_collide_bit = lyte_core.geom_set_collide_bit and lyte_core.geom_set_collide_bit or function() end
--- Is the collide bit associated with the Geom? (Between 0 and 63.) 
--- @type fun(geom: userdata, collide_bit: int): boolean
    lyte_core.geom_is_collide_bit_set = lyte_core.geom_is_collide_bit_set and lyte_core.geom_is_collide_bit_set or function() end

-- records


-- variants (unions)


-- lists

--- Float values
--- @alias lyte_core.FloatVec4 number[]
--- List of keys
--- @alias lyte_core.KeyList lyte_core.KeyboardKey[]

-- dicts


-- enums

--- Acceptable uniformtype values.
--- @alias lyte_core.UniformType "_invalid" | "float" | "vec2" | "vec3" | "vec4" | "int" | "ivec2" | "ivec3" | "ivec4" | "mat4" | "sampler2D"
--- Acceptable blendmode values.
--- @alias lyte_core.BlendMode "none" | "blend" | "add" | "mod" | "mul"
--- Acceptable filtermode values.
--- @alias lyte_core.FilterMode "_invalid" | "nearest" | "linear"
--- Acceptable gamepadaxis values.
--- @alias lyte_core.GamepadAxis "left_x" | "left_y" | "right_x" | "right_y" | "left_trigger" | "right_trigger"
--- Acceptable gamepadbutton values.
--- @alias lyte_core.GamepadButton "pad_a" | "pad_b" | "pad_x" | "pad_y" | "left_bumper" | "right_bumper" | "back" | "start" | "guide" | "left_thumb" | "right_thumb" | "dpad_up" | "dpad_right" | "dpad_down" | "dpad_left"
--- Acceptable mousebutton values.
--- @alias lyte_core.MouseButton "mb1" | "mb2" | "mb3" | "mb4" | "mb5" | "mb6" | "mb7" | "mb8" | "scrollup" | "scrolldown"
--- Acceptable keyboardkey values.
--- @alias lyte_core.KeyboardKey "space" | "'" | "," | "-" | "." | "/" | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | ";" | "=" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "[" | "\\" | "]" | "`" | "world_1" | "world_2" | "escape" | "enter" | "tab" | "backspace" | "insert" | "delete" | "right" | "left" | "down" | "up" | "page_up" | "page_down" | "home" | "end" | "caps_lock" | "scroll_lock" | "num_lock" | "print_screen" | "pause" | "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" | "f13" | "f14" | "f15" | "f16" | "f17" | "f18" | "f19" | "f20" | "f21" | "f22" | "f23" | "f24" | "f25" | "kp_0" | "kp_1" | "kp_2" | "kp_3" | "kp_4" | "kp_5" | "kp_6" | "kp_7" | "kp_8" | "kp_9" | "kp_decimal" | "kp_divide" | "kp_multiply" | "kp_subtract" | "kp_add" | "kp_enter" | "kp_equal" | "left_shift" | "left_control" | "left_alt" | "left_super" | "right_shift" | "right_control" | "right_alt" | "right_super" | "menu"

