-- generated
global record lyte

    -- functions

    -- Tick function. Should be created by the user. 
    tick: function(delta_time: number, window_width: int, window_height: int, window_resized: boolean, is_fullscreen: boolean)
    -- Quit the application by closing the window. 
    quit: function()
    -- Clear the screen or current canvas if one is used. 
    cls: function(r: number, g: number, b: number, a: number)
    -- Set the foreground color to be used in the drawing operations. 
    set_color: function(r: number, g: number, b: number, a: number)
    -- Reset the foreground color to its default value. 
    reset_color: function()
    -- Draw a point. 
    draw_point: function(x: number, y: number)
    -- Draw a line 
    draw_line: function(x1: number, y1: number, x2: number, y2: number)
    -- Draw a filled triangle 
    draw_triangle: function(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    -- Draw a triangle border 
    draw_triangle_line: function(ax: number, ay: number, bx: number, by: number, cx: number, cy: number)
    -- Draw a filled rectangle. 
    draw_rect: function(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    -- Draw a rectangle border. 
    draw_rect_line: function(dest_x: number, dest_y: number, rect_width: number, rect_height: number)
    -- Draw a filled circle. 
    draw_circle: function(dest_x: number, dest_y: number, radius: number)
    -- Draw a circle border. 
    draw_circle_line: function(dest_x: number, dest_y: number, radius: number)
    -- Draw a filled ellipse. 
    draw_ellipse: function(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    -- Draw an ellipse border. 
    draw_ellipse_line: function(dest_x: number, dest_y: number, radius_x: number, radius_y: number)
    -- Free Image resources 
    cleanup_image: function(image: lyte.Image)
    -- Load the image specified in the path. 
    load_image: function(image_path: string): lyte.Image
    -- Draw an image. Angle, scale and origin values are all optional. 
    draw_image: function(image: lyte.Image, dest_x: number, dest_y: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    -- Draw a rectangular area from the image. Angle, scale and origin values are all optional. 
    draw_image_rect: function(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number)
    -- Get the width of the image. 
    get_image_width: function(image: lyte.Image): int
    -- Get the height of the image. 
    get_image_height: function(image: lyte.Image): int
    -- Create a canvas image with given width and height. 
    new_canvas: function(width: int, height: int): lyte.Image
    -- Set the effective canvas image. All draw operations will go to this canvas until it's reset. 
    set_canvas: function(canvas_image: lyte.Image)
    -- Reset the drawing target, back to screen. 
    reset_canvas: function()
    -- Check if the image was created as a canvas. 
    is_image_canvas: function(image: lyte.Image): boolean
    -- Free ImageBatch resources 
    cleanup_imagebatch: function(imagebatch: lyte.ImageBatch)
    -- Create an image batch 
    new_imagebatch: function(image: lyte.Image): lyte.ImageBatch
    -- Reset the image batch, remove all added rects. 
    reset_imagebatch: function(imagebatch: lyte.ImageBatch)
    -- Add a recta to the image batch (from it's initial image). `src_width` and `src_height` are optional and will default to the corresponding `dest_` values. 
    add_imagebatch_rect: function(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
    -- Get the number of rects in the image batch. 
    get_imagebatch_rect_count: function(imagebatch: lyte.ImageBatch): int
    -- Draw the image batch. 
    draw_imagebatch: function(imagebatch: lyte.ImageBatch)
    -- Free Font resources 
    cleanup_font: function(font: lyte.Font)
    -- Load the font specified in the path, and set the initial size. 
    load_font: function(font_path: string, size: number): lyte.Font
    -- Set the effective font to be used in the drawing operations. 
    set_font: function(font: lyte.Font)
    -- Reset the font to its default value. 
    reset_font: function()
    -- Draw a text line. 
    draw_text: function(text: string, dest_x: number, dest_y: number)
    -- Get the width of the given text line. 
    get_text_width: function(text: string): int
    -- Get the height of the given text line. 
    get_text_height: function(text: string): int
    -- Get the number of currently connected monitors. 
    get_monitor_count: function(): int
    -- Get the name of the monitor at the index 
    get_monitor_name: function(index: int): string
    -- Get the width of the monitor at the index 
    get_monitor_width: function(index: int): int
    -- Get the height of the monitor at the index 
    get_monitor_height: function(index: int): int
    --  Set the window's initial monitor to the indexed value. Must be set before the window is opened. 
    set_window_monitor: function(index: int)
    --  Set the window resizable flag to the given value. Must be set before the window is opened. 
    set_window_resizable: function(resizable: boolean)
    -- Set the window's minimum possible size. 
    set_window_minsize: function(width: int, height: int)
    -- Set the window's size. 
    set_window_size: function(width: int, height: int)
    -- Get the width of the window. 
    get_window_width: function(): int
    -- Get the height of the window. 
    get_window_height: function(): int
    -- Set the window's position. 
    set_window_position: function(x: int, y: int)
    -- Set the window to fullscreen, or windowed mode. 
    set_fullscreen: function(fullscreen: boolean)
    -- Check if the window is set to fullscreen. 
    is_fullscreen: function(): boolean
    -- Set the window's title. 
    set_window_title: function(title: string)
    -- Set the window vsync flag to the given value. 
    set_window_vsync: function(vsync: boolean)
    -- Check if the window vsync flag is set. 
    is_window_vsync: function(): boolean
    -- Set the window icon. 
    set_window_icon_file: function(icon_path: string)
    -- Set the window margins. Margins are ignored and no drawing can be made there.. 
    set_window_margins: function(left: int, right: int, top: int, bottom: int)
    -- Set the window paddings. Paddings are can be drawn on. 
    set_window_paddings: function(left: int, right: int, top: int, bottom: int)
    -- Check if the given key is down. 
    is_key_down: function(key: lyte.KeyboardKey): boolean
    -- Check if the given key is pressed. 
    is_key_pressed: function(key: lyte.KeyboardKey): boolean
    -- Check if the given key is released. 
    is_key_released: function(key: lyte.KeyboardKey): boolean
    -- Check if the given key is repeated. 
    is_key_repeat: function(key: lyte.KeyboardKey): boolean
    -- Get the list of pressed keys. 
    get_pressed_keys: function(): lyte.KeyList
    -- Get all keyboard text input from last frame. Output is utf8 encoded. 
    get_textinput: function(): string
    -- Check if the given mouse button is down. 
    is_mouse_down: function(mouse_button: lyte.MouseButton): boolean
    -- Check if the given mouse button is pressed. 
    is_mouse_pressed: function(mouse_button: lyte.MouseButton): boolean
    -- Check if the given mouse button is released. 
    is_mouse_released: function(mouse_button: lyte.MouseButton): boolean
    -- Get the mouse x position. 
    get_mouse_x: function(): int
    -- Get the mouse y position. 
    get_mouse_y: function(): int
    -- Get the number of gamepads. 
    get_gamepad_count: function(): int
    -- Get the name of the gamepad at the given index. 
    get_gamepad_name: function(index: int): string
    -- Check if the given button of the gamepad at the given index is down. 
    is_gamepad_down: function(index: int, gamepad_button: lyte.GamepadButton): boolean
    -- Check if the given button of the gamepad at the given index is pressed. 
    is_gamepad_pressed: function(index: int, gamepad_button: lyte.GamepadButton): boolean
    -- Check if the given button of the gamepad at the given index is released. 
    is_gamepad_released: function(index: int, gamepad_button: lyte.GamepadButton): boolean
    -- Get the given axis of the gamepad at the given index. 
    get_gamepad_axis: function(index: int, gamepad_axis: lyte.GamepadAxis): number
    -- Set the master volume. 
    set_mastervolume: function(mastervolume: number)
    -- Get the master volume. 
    get_mastervolume: function(): number
    -- Free Music resources 
    cleanup_music: function(music: lyte.Music)
    -- Load the music specified in the path. 
    load_music: function(music_path: string): lyte.Music
    -- Play the music. 
    play_music: function(music: lyte.Music)
    -- Pause the music. 
    pause_music: function(music: lyte.Music)
    -- Resume the music. 
    resume_music: function(music: lyte.Music)
    -- Stop the music. 
    stop_music: function(music: lyte.Music)
    -- Check if the given music is playing. 
    is_music_playing: function(music: lyte.Music): boolean
    -- Get the length of the given music object in seconds. 
    get_music_length: function(music: lyte.Music): number
    -- Get the already played length of the given music object in seconds. 
    get_music_length_played: function(music: lyte.Music): number
    -- Move the music time played to the given value. 
    seek_music: function(music: lyte.Music, secs: number)
    -- Set the volume of the given music object. 
    set_music_volume: function(music: lyte.Music, volume: number)
    -- Set the pan of the given music object. 
    set_music_pan: function(music: lyte.Music, pan: number)
    -- Set the pitch of the given music object. 
    set_music_pitch: function(music: lyte.Music, pitch: number)
    -- Get the volume of the given music object. 
    get_music_volume: function(music: lyte.Music): number
    -- Get the pan of the given music object. 
    get_music_pan: function(music: lyte.Music): number
    -- Get the pitch of the given music object. 
    get_music_pitch: function(music: lyte.Music): number
    -- Free Sound resources 
    cleanup_sound: function(sound: lyte.Sound)
    -- Load the sound specified in the path. 
    load_sound: function(sound_path: string): lyte.Sound
    -- Clone the sound specified in the path. 
    clone_sound: function(orig: lyte.Sound): lyte.Sound
    -- Play the sound. 
    play_sound: function(sound: lyte.Sound)
    -- Pause the sound. 
    pause_sound: function(sound: lyte.Sound)
    -- Resume the sound. 
    resume_sound: function(sound: lyte.Sound)
    -- Stop the sound. 
    stop_sound: function(sound: lyte.Sound)
    -- Check if the given sound is playing. 
    is_sound_playing: function(sound: lyte.Sound): boolean
    -- Set the volume of the given sound object. 
    set_sound_volume: function(sound: lyte.Sound, volume: number)
    -- Set the pan of the given sound object. 
    set_sound_pan: function(sound: lyte.Sound, pan: number)
    -- Set the pitch of the given sound object. 
    set_sound_pitch: function(sound: lyte.Sound, pitch: number)
    -- Get the volume of the given sound object. 
    get_sound_volume: function(sound: lyte.Sound): number
    -- Get the pan of the given sound object. 
    get_sound_pan: function(sound: lyte.Sound): number
    -- Get the pitch of the given sound object. 
    get_sound_pitch: function(sound: lyte.Sound): number
    -- Load the file in the path. 
    load_textfile: function(file_path: string): string
    -- Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. 
    save_textfile: function(file_path: string, data: string)
    -- Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. 
    save_textfile_append: function(file_path: string, data: string)
    -- Push the transform matrix. 
    push_matrix: function()
    -- Pop the transform matrix. 
    pop_matrix: function()
    -- Reset the transformation matrix (load identity matrix.) 
    reset_matrix: function()
    -- Apply translation (changes transform matrix.) 
    translate: function(delta_x: number, delta_y: number)
    -- Apply rotation (changes transform matrix.) 
    rotate: function(angle: number)
    -- Apply rotation at the given location (changes transform matrix.) 
    rotate_at: function(angle: number, x: number, y: number)
    -- Apply scaling (changes transform matrix.) 
    scale: function(scale_x: number, scale_y: number)
    -- Apply scaling at the given location (changes transform matrix.) 
    scale_at: function(scale_x: number, scale_y: number, x: number, y: number)
    -- Set the default blendmode. 
    set_default_blendmode: function(blendmode: lyte.BlendMode)
    -- Set the effective blendmode. 
    set_blendmode: function(blendmode: lyte.BlendMode)
    -- Reset the blendmode value to its default value. 
    reset_blendmode: function()
    -- Set the default filtermode. 
    set_default_filtermode: function(filtermode: lyte.FilterMode)
    -- Set the effective filtermode. 
    set_filtermode: function(filtermode: lyte.FilterMode)
    -- Reset the filtermode value to its default value. 
    reset_filtermode: function()
    -- Free ShaderBuilder resources 
    cleanup_shaderbuilder: function(shaderbuilder: lyte.ShaderBuilder)
    -- Create a ShaderBuilder object. 
    new_shaderbuilder: function(): lyte.ShaderBuilder
    -- Add uniform definition to the shaderbuilder 
    shaderbuilder_uniform: function(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
    -- Add vertex code to the shaderbuilder 
    shaderbuilder_vertex: function(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
    -- Add fragment to the shaderbuilder 
    shaderbuilder_fragment: function(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
    -- Add fragment to the shaderbuilder 
    shaderbuilder_build: function(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
    -- Free Shader resources 
    cleanup_shader: function(shader: lyte.Shader)
    -- Create a shader with given specification. 
    new_shader: function(shaderdef: lyte.ShaderDef): lyte.Shader
    -- Set the custom shader and use it for consequent calls. 
    set_shader: function(shader: lyte.Shader)
    -- Reset the shader, back to framework defaults. 
    reset_shader: function()
    -- Set the specified uniform. 
    set_shader_uniform: function(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
    -- Reset the specified uniform. 
    reset_shader_uniform: function(shader: lyte.Shader, uniform_name: string)
    -- Cleanup the physics world (dynamics + collision). 
    cleanup_world: function(world: lyte.World)
    -- Create a new physics world 
    new_world: function(): lyte.World
    -- Update the physics world (dynamics + collision). 
    update_world: function(world: lyte.World, step_size: number)
    -- Update the physics world gravity. 
    set_world_gravity: function(world: lyte.World, x: number, y: number)
    -- Cleanup the physics collider. 
    cleanup_collider: function(collider: lyte.Collider)
    -- Refresh the physics collider position (x, y) and angle 
    refresh_collider: function(collider: lyte.Collider)
    -- Create new circle collider (body + geom) in the given physics world. 
    new_circle_collider: function(world: lyte.World, radius: number, x: number, y: number, angle: number)
    -- Create new rectangle collider (body + geom) in the given physics world. 
    new_rect_collider: function(world: lyte.World, width: number, height: number, x: number, y: number, angle: number)
    -- Set collider position. 
    set_collider_position: function(collider: lyte.Collider, x: number, y: number)
    -- Set collider rotation. 
    set_collider_rotation: function(collider: lyte.Collider, angle: number)
    -- Add force to collider. 
    add_force_to_collider: function(collider: lyte.Collider, fx: number, fy: number)
    -- Add torque to collider. 
    add_torque_to_collider: function(collider: lyte.Collider, fz: number)
    -- Set the collider's linear velocity 
    set_collider_linear_velocity: function(collider: lyte.Collider, vx: number, vy: number)
    -- Set the collider's angular velocity 
    set_collider_angular_velocity: function(collider: lyte.Collider, vz: number)
    -- Set the collider as 'kinematic'. By default, it's not kinematic. 
    set_collider_kinematic: function(collider: lyte.Collider, val: boolean)
    -- Is the collider set as 'kinematic'? By default, it's not. 
    is_collider_kinematic: function(collider: lyte.Collider): boolean
    -- Get the number of collisions in the current frame 
    get_collider_collision_count: function(collider: lyte.Collider): int
    -- Get the collision data in the current frame as a list 
    get_collider_collisions: function(collider: lyte.Collider): lyte.CollisionList

    -- records

    -- Shader definition: uniforms declaration, vertex and fragment shader code. 
    record ShaderDef
        frag: string
        vert: string
        uniforms: lyte.UniformNamesToTypes
    end
    -- Image type 
    record Image
        width: int
        height: int
        is_canvas: boolean
        __gc: function(image: lyte.Image)
    end
    -- ImageBatch type. 
    record ImageBatch
        rect_count: int
        add_rect: function(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number)
        draw: function(imagebatch: lyte.ImageBatch)
        reset: function(imagebatch: lyte.ImageBatch)
        __gc: function(imagebatch: lyte.ImageBatch)
    end
    -- Font type. 
    record Font
        __gc: function(font: lyte.Font)
    end
    -- Music type. 
    record Music
        playing: boolean
        length: number
        length_played: number
        pan: number
        pitch: number
        volume: number
        play: function(music: lyte.Music)
        pause: function(music: lyte.Music)
        resume: function(music: lyte.Music)
        stop: function(music: lyte.Music)
        seek: function(music: lyte.Music, secs: number)
        __gc: function(music: lyte.Music)
    end
    -- Sound type. 
    record Sound
        pan: number
        pitch: number
        volume: number
        clone: function(orig: lyte.Sound): lyte.Sound
        pause: function(sound: lyte.Sound)
        play: function(sound: lyte.Sound)
        resume: function(sound: lyte.Sound)
        stop: function(sound: lyte.Sound)
        __gc: function(sound: lyte.Sound)
    end
    -- Shader type 
    record Shader
        set: function(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue)
        reset: function(shader: lyte.Shader, uniform_name: string)
        __gc: function(shader: lyte.Shader)
    end
    -- ShaderBuilder type 
    record ShaderBuilder
        uniform: function(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType)
        vertex: function(shaderbuilder: lyte.ShaderBuilder, vertex_code: string)
        fragment: function(shaderbuilder: lyte.ShaderBuilder, fragment_code: string)
        build: function(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
        __gc: function(shaderbuilder: lyte.ShaderBuilder)
    end
    -- Physics dynamics world + collision space. 
    record World
        update: function(world: lyte.World, step_size: number)
        set_gravity: function(world: lyte.World, x: number, y: number)
        new_circle_collider: function(world: lyte.World, radius: number, x: number, y: number, angle: number)
        new_rect_collider: function(world: lyte.World, width: number, height: number, x: number, y: number, angle: number)
        __gc: function(world: lyte.World)
    end
    -- Physics body + mass + colliding geometry. 
    record Collider
        x: number
        y: number
        angle: number
        refresh: function(collider: lyte.Collider)
        set_position: function(collider: lyte.Collider, x: number, y: number)
        set_rotation: function(collider: lyte.Collider, angle: number)
        set_linear_velocity: function(collider: lyte.Collider, vx: number, vy: number)
        set_angular_velocity: function(collider: lyte.Collider, vz: number)
        add_force: function(collider: lyte.Collider, fx: number, fy: number)
        add_torque: function(collider: lyte.Collider, fz: number)
        is_kinematic: function(collider: lyte.Collider): boolean
        set_kinematic: function(collider: lyte.Collider, val: boolean)
        get_collision_count: function(collider: lyte.Collider): int
        get_collisions: function(collider: lyte.Collider): lyte.CollisionList
        __gc: function(collider: lyte.Collider)
    end
    -- Collision information between two colliders 
    record Collision
        c1: lyte.Collider
        c2: lyte.Collider
        pos_x: number
        pos_y: number
        depth: number
    end
    -- Physics joints (constraints). 
    record Joint
    end

    -- variants (unions)

    -- Shader uniform value 
    type ShaderUniformValue =
          number
        | lyte.FloatVec4
        | lyte.Image

    -- lists

    -- Float values
    type FloatVec4 = {number}
    -- Collision List
    type CollisionList = {userdata}

    -- dicts

    -- 
    type UniformNamesToTypes = {string: lyte.UniformType}

    -- enums

    -- Acceptable uniformtype values.
    enum UniformType
          "_invalid"
          "float"
          "vec2"
          "vec3"
          "vec4"
          "int"
          "ivec2"
          "ivec3"
          "ivec4"
          "mat4"
          "sampler2D"
    end
    -- Acceptable blendmode values.
    enum BlendMode
          "none"
          "blend"
          "add"
          "mod"
          "mul"
    end
    -- Acceptable filtermode values.
    enum FilterMode
          "_invalid"
          "nearest"
          "linear"
    end
    -- Acceptable gamepadaxis values.
    enum GamepadAxis
          "left_x"
          "left_y"
          "right_x"
          "right_y"
          "left_trigger"
          "right_trigger"
    end
    -- Acceptable gamepadbutton values.
    enum GamepadButton
          "pad_a"
          "pad_b"
          "pad_x"
          "pad_y"
          "left_bumper"
          "right_bumper"
          "back"
          "start"
          "guide"
          "left_thumb"
          "right_thumb"
          "dpad_up"
          "dpad_right"
          "dpad_down"
          "dpad_left"
    end
    -- Acceptable mousebutton values.
    enum MouseButton
          "mb1"
          "mb2"
          "mb3"
          "mb4"
          "mb5"
          "mb6"
          "mb7"
          "mb8"
          "scrollup"
          "scrolldown"
    end
    -- Acceptable keyboardkey values.
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
          "`"
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
end

