// generated
declare namespace lyte {

    // functions

    // Tick function. Should be created by the user. 
    function tick(delta_time: number, window_width: number, window_height: number, window_resized: boolean, is_fullscreen: boolean): void
    // Quit the application by closing the window. 
    function quit(): void
    // Clear the screen or current canvas if one is used. 
    function cls(r: number, g: number, b: number, a: number): void
    // Set the foreground color to be used in the drawing operations. 
    function set_color(r: number, g: number, b: number, a: number): void
    // Reset the foreground color to its default value. 
    function reset_color(): void
    // Draw a point. 
    function draw_point(x: number, y: number): void
    // Draw a line 
    function draw_line(x1: number, y1: number, x2: number, y2: number): void
    // Draw a filled triangle 
    function draw_triangle(ax: number, ay: number, bx: number, by: number, cx: number, cy: number): void
    // Draw a triangle border 
    function draw_triangle_line(ax: number, ay: number, bx: number, by: number, cx: number, cy: number): void
    // Draw a filled rectangle. 
    function draw_rect(dest_x: number, dest_y: number, rect_width: number, rect_height: number): void
    // Draw a rectangle border. 
    function draw_rect_line(dest_x: number, dest_y: number, rect_width: number, rect_height: number): void
    // Draw a filled circle. 
    function draw_circle(dest_x: number, dest_y: number, radius: number): void
    // Draw a circle border. 
    function draw_circle_line(dest_x: number, dest_y: number, radius: number): void
    // Draw a filled ellipse. 
    function draw_ellipse(dest_x: number, dest_y: number, radius_x: number, radius_y: number): void
    // Draw an ellipse border. 
    function draw_ellipse_line(dest_x: number, dest_y: number, radius_x: number, radius_y: number): void
    // Free Image resources 
    function cleanup_image(image: lyte.Image): void
    // Load the image specified in the path. 
    function load_image(image_path: string): lyte.Image
    // Draw an image. Angle, scale and origin values are all optional. 
    function draw_image(image: lyte.Image, dest_x: number, dest_y: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number): void
    // Draw a rectangular area from the image. Angle, scale and origin values are all optional. 
    function draw_image_rect(image: lyte.Image, dest_x: number, dest_y: number, src_x: number, src_y: number, rect_width: number, rect_height: number, angle: number, origin_x: number, origin_y: number, scale_x: number, scale_y: number): void
    // Get the width of the image. 
    function get_image_width(image: lyte.Image): number
    // Get the height of the image. 
    function get_image_height(image: lyte.Image): number
    // Create a canvas image with given width and height. 
    function new_canvas(width: number, height: number): lyte.Image
    // Set the effective canvas image. All draw operations will go to this canvas until it's reset. 
    function set_canvas(canvas_image: lyte.Image): void
    // Reset the drawing target, back to screen. 
    function reset_canvas(): void
    // Check if the image was created as a canvas. 
    function is_image_canvas(image: lyte.Image): boolean
    // Free ImageBatch resources 
    function cleanup_imagebatch(imagebatch: lyte.ImageBatch): void
    // Create an image batch 
    function new_imagebatch(image: lyte.Image): lyte.ImageBatch
    // Reset the image batch, remove all added rects. 
    function reset_imagebatch(imagebatch: lyte.ImageBatch): void
    // Add a recta to the image batch (from it's initial image). `src_width` and `src_height` are optional and will default to the corresponding `dest_` values. 
    function add_imagebatch_rect(imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number): void
    // Get the number of rects in the image batch. 
    function get_imagebatch_rect_count(imagebatch: lyte.ImageBatch): number
    // Draw the image batch. 
    function draw_imagebatch(imagebatch: lyte.ImageBatch): void
    // Free Font resources 
    function cleanup_font(font: lyte.Font): void
    // Load the font specified in the path, and set the initial size. 
    function load_font(font_path: string, size: number): lyte.Font
    // Set the effective font to be used in the drawing operations. 
    function set_font(font: lyte.Font): void
    // Reset the font to its default value. 
    function reset_font(): void
    // Draw a text line. 
    function draw_text(text: string, dest_x: number, dest_y: number): void
    // Get the width of the given text line. 
    function get_text_width(text: string): number
    // Get the height of the given text line. 
    function get_text_height(text: string): number
    // Get the number of currently connected monitors. 
    function get_monitor_count(): number
    // Get the name of the monitor at the index 
    function get_monitor_name(index: number): string
    // Get the width of the monitor at the index 
    function get_monitor_width(index: number): number
    // Get the height of the monitor at the index 
    function get_monitor_height(index: number): number
    //  Set the window's initial monitor to the indexed value. Must be set before the window is opened. 
    function set_window_monitor(index: number): void
    //  Set the window resizable flag to the given value. Must be set before the window is opened. 
    function set_window_resizable(resizable: boolean): void
    // Set the window's minimum possible size. 
    function set_window_minsize(width: number, height: number): void
    // Set the window's size. 
    function set_window_size(width: number, height: number): void
    // Get the width of the window. 
    function get_window_width(): number
    // Get the height of the window. 
    function get_window_height(): number
    // Set the window's position. 
    function set_window_position(x: number, y: number): void
    // Set the window to fullscreen, or windowed mode. 
    function set_fullscreen(fullscreen: boolean): void
    // Check if the window is set to fullscreen. 
    function is_fullscreen(): boolean
    // Set the window's title. 
    function set_window_title(title: string): void
    // Set the window vsync flag to the given value. 
    function set_window_vsync(vsync: boolean): void
    // Check if the window vsync flag is set. 
    function is_window_vsync(): boolean
    // Set the window icon. 
    function set_window_icon_file(icon_path: string): void
    // Set the window margins. Margins are ignored and no drawing can be made there.. 
    function set_window_margins(left: number, right: number, top: number, bottom: number): void
    // Set the window paddings. Paddings are can be drawn on. 
    function set_window_paddings(left: number, right: number, top: number, bottom: number): void
    // Check if the given key is down. 
    function is_key_down(key: lyte.KeyboardKey): boolean
    // Check if the given key is pressed. 
    function is_key_pressed(key: lyte.KeyboardKey): boolean
    // Check if the given key is released. 
    function is_key_released(key: lyte.KeyboardKey): boolean
    // Check if the given key is repeated. 
    function is_key_repeat(key: lyte.KeyboardKey): boolean
    // Get the list of pressed keys. 
    function get_pressed_keys(): lyte.KeyList
    // Get all keyboard text input from last frame. Output is utf8 encoded. 
    function get_textinput(): string
    // Check if the given mouse button is down. 
    function is_mouse_down(mouse_button: lyte.MouseButton): boolean
    // Check if the given mouse button is pressed. 
    function is_mouse_pressed(mouse_button: lyte.MouseButton): boolean
    // Check if the given mouse button is released. 
    function is_mouse_released(mouse_button: lyte.MouseButton): boolean
    // Get the mouse x position. 
    function get_mouse_x(): number
    // Get the mouse y position. 
    function get_mouse_y(): number
    // Get the number of gamepads. 
    function get_gamepad_count(): number
    // Get the name of the gamepad at the given index. 
    function get_gamepad_name(index: number): string
    // Check if the given button of the gamepad at the given index is down. 
    function is_gamepad_down(index: number, gamepad_button: lyte.GamepadButton): boolean
    // Check if the given button of the gamepad at the given index is pressed. 
    function is_gamepad_pressed(index: number, gamepad_button: lyte.GamepadButton): boolean
    // Check if the given button of the gamepad at the given index is released. 
    function is_gamepad_released(index: number, gamepad_button: lyte.GamepadButton): boolean
    // Get the given axis of the gamepad at the given index. 
    function get_gamepad_axis(index: number, gamepad_axis: lyte.GamepadAxis): number
    // Set the master volume. 
    function set_mastervolume(mastervolume: number): void
    // Get the master volume. 
    function get_mastervolume(): number
    // Free Music resources 
    function cleanup_music(music: lyte.Music): void
    // Load the music specified in the path. 
    function load_music(music_path: string): lyte.Music
    // Play the music. 
    function play_music(music: lyte.Music): void
    // Pause the music. 
    function pause_music(music: lyte.Music): void
    // Resume the music. 
    function resume_music(music: lyte.Music): void
    // Stop the music. 
    function stop_music(music: lyte.Music): void
    // Check if the given music is playing. 
    function is_music_playing(music: lyte.Music): boolean
    // Get the length of the given music object in seconds. 
    function get_music_length(music: lyte.Music): number
    // Get the already played length of the given music object in seconds. 
    function get_music_length_played(music: lyte.Music): number
    // Move the music time played to the given value. 
    function seek_music(music: lyte.Music, secs: number): void
    // Set the volume of the given music object. 
    function set_music_volume(music: lyte.Music, volume: number): void
    // Set the pan of the given music object. 
    function set_music_pan(music: lyte.Music, pan: number): void
    // Set the pitch of the given music object. 
    function set_music_pitch(music: lyte.Music, pitch: number): void
    // Get the volume of the given music object. 
    function get_music_volume(music: lyte.Music): number
    // Get the pan of the given music object. 
    function get_music_pan(music: lyte.Music): number
    // Get the pitch of the given music object. 
    function get_music_pitch(music: lyte.Music): number
    // Free Sound resources 
    function cleanup_sound(sound: lyte.Sound): void
    // Load the sound specified in the path. 
    function load_sound(sound_path: string): lyte.Sound
    // Clone the sound specified in the path. 
    function clone_sound(orig: lyte.Sound): lyte.Sound
    // Play the sound. 
    function play_sound(sound: lyte.Sound): void
    // Pause the sound. 
    function pause_sound(sound: lyte.Sound): void
    // Resume the sound. 
    function resume_sound(sound: lyte.Sound): void
    // Stop the sound. 
    function stop_sound(sound: lyte.Sound): void
    // Check if the given sound is playing. 
    function is_sound_playing(sound: lyte.Sound): boolean
    // Set the volume of the given sound object. 
    function set_sound_volume(sound: lyte.Sound, volume: number): void
    // Set the pan of the given sound object. 
    function set_sound_pan(sound: lyte.Sound, pan: number): void
    // Set the pitch of the given sound object. 
    function set_sound_pitch(sound: lyte.Sound, pitch: number): void
    // Get the volume of the given sound object. 
    function get_sound_volume(sound: lyte.Sound): number
    // Get the pan of the given sound object. 
    function get_sound_pan(sound: lyte.Sound): number
    // Get the pitch of the given sound object. 
    function get_sound_pitch(sound: lyte.Sound): number
    // Load the file in the path. 
    function load_textfile(file_path: string): string
    // Append the text to the file in the path. Override if the file exists. Create if it doesn't exist. 
    function save_textfile(file_path: string, data: string): void
    // Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist. 
    function save_textfile_append(file_path: string, data: string): void
    // Push the transform matrix. 
    function push_matrix(): void
    // Pop the transform matrix. 
    function pop_matrix(): void
    // Reset the transformation matrix (load identity matrix.) 
    function reset_matrix(): void
    // Apply translation (changes transform matrix.) 
    function translate(delta_x: number, delta_y: number): void
    // Apply rotation (changes transform matrix.) 
    function rotate(angle: number): void
    // Apply rotation at the given location (changes transform matrix.) 
    function rotate_at(angle: number, x: number, y: number): void
    // Apply scaling (changes transform matrix.) 
    function scale(scale_x: number, scale_y: number): void
    // Apply scaling at the given location (changes transform matrix.) 
    function scale_at(scale_x: number, scale_y: number, x: number, y: number): void
    // Set the default blendmode. 
    function set_default_blendmode(blendmode: lyte.BlendMode): void
    // Set the effective blendmode. 
    function set_blendmode(blendmode: lyte.BlendMode): void
    // Reset the blendmode value to its default value. 
    function reset_blendmode(): void
    // Set the default filtermode. 
    function set_default_filtermode(filtermode: lyte.FilterMode): void
    // Set the effective filtermode. 
    function set_filtermode(filtermode: lyte.FilterMode): void
    // Reset the filtermode value to its default value. 
    function reset_filtermode(): void
    // Free ShaderBuilder resources 
    function cleanup_shaderbuilder(shaderbuilder: lyte.ShaderBuilder): void
    // Create a ShaderBuilder object. 
    function new_shaderbuilder(): lyte.ShaderBuilder
    // Add uniform definition to the shaderbuilder 
    function shaderbuilder_uniform(shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType): void
    // Add vertex code to the shaderbuilder 
    function shaderbuilder_vertex(shaderbuilder: lyte.ShaderBuilder, vertex_code: string): void
    // Add fragment to the shaderbuilder 
    function shaderbuilder_fragment(shaderbuilder: lyte.ShaderBuilder, fragment_code: string): void
    // Add fragment to the shaderbuilder 
    function shaderbuilder_build(shaderbuilder: lyte.ShaderBuilder): lyte.Shader
    // Free Shader resources 
    function cleanup_shader(shader: lyte.Shader): void
    // Create a shader with given specification. 
    function new_shader(shaderdef: lyte.ShaderDef): lyte.Shader
    // Set the custom shader and use it for consequent calls. 
    function set_shader(shader: lyte.Shader): void
    // Reset the shader, back to framework defaults. 
    function reset_shader(): void
    // Set the specified uniform. 
    function set_shader_uniform(shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue): void
    // Reset the specified uniform. 
    function reset_shader_uniform(shader: lyte.Shader, uniform_name: string): void
    // Cleanup the physics world (dynamics + collision). 
    function cleanup_world(world: lyte.World): void
    // Create a new physics world 
    function new_world(): lyte.World
    // Update the physics world (dynamics + collision). 
    function update_world(world: lyte.World, step_size: number): void
    // Update the physics world gravity. 
    function set_world_gravity(world: lyte.World, x: number, y: number): void
    // Cleanup the physics collider. 
    function cleanup_collider(collider: lyte.Collider): void
    // Refresh the physics collider position (x, y) and angle 
    function refresh_collider(collider: lyte.Collider): void
    // Create new circle collider (body + geom) in the given physics world. 
    function new_circle_collider(world: lyte.World, radius: number, x: number, y: number, angle: number): void
    // Create new rectangle collider (body + geom) in the given physics world. 
    function new_rect_collider(world: lyte.World, width: number, height: number, x: number, y: number, angle: number): void
    // Set collider position. 
    function set_collider_position(collider: lyte.Collider, x: number, y: number): void
    // Set collider rotation. 
    function set_collider_rotation(collider: lyte.Collider, angle: number): void
    // Add force to collider. 
    function add_force_to_collider(collider: lyte.Collider, fx: number, fy: number): void
    // Add torque to collider. 
    function add_torque_to_collider(collider: lyte.Collider, fz: number): void
    // Set the collider's linear velocity 
    function set_collider_linear_velocity(collider: lyte.Collider, vx: number, vy: number): void
    // Set the collider's angular velocity 
    function set_collider_angular_velocity(collider: lyte.Collider, vz: number): void
    // Set the collider as 'kinematic'. By default, it's not kinematic. 
    function set_collider_kinematic(collider: lyte.Collider, val: boolean): void
    // Is the collider set as 'kinematic'? By default, it's not. 
    function is_collider_kinematic(collider: lyte.Collider): boolean
    // Get the number of collisions in the current frame 
    function get_collider_collision_count(collider: lyte.Collider): number
    // Get the collision data in the current frame as a list 
    function get_collider_collisions(collider: lyte.Collider): lyte.CollisionList

    // records

    // Shader definition: uniforms declaration, vertex and fragment shader code. 
    type ShaderDef = {
        frag: string
        vert: string
        uniforms: lyte.UniformNamesToTypes
    }
    // Image type 
    type Image = {
        width: number
        height: number
        is_canvas: boolean
        __gc: (image: lyte.Image) => void
    }
    // ImageBatch type. 
    type ImageBatch = {
        rect_count: number
        add_rect: (imagebatch: lyte.ImageBatch, dest_x: number, dest_y: number, dest_width: number, dest_height: number, src_x: number, src_y: number, src_width: number, src_height: number) => void
        draw: (imagebatch: lyte.ImageBatch) => void
        reset: (imagebatch: lyte.ImageBatch) => void
        __gc: (imagebatch: lyte.ImageBatch) => void
    }
    // Font type. 
    type Font = {
        __gc: (font: lyte.Font) => void
    }
    // Music type. 
    type Music = {
        playing: boolean
        length: number
        length_played: number
        pan: number
        pitch: number
        volume: number
        play: (music: lyte.Music) => void
        pause: (music: lyte.Music) => void
        resume: (music: lyte.Music) => void
        stop: (music: lyte.Music) => void
        seek: (music: lyte.Music, secs: number) => void
        __gc: (music: lyte.Music) => void
    }
    // Sound type. 
    type Sound = {
        pan: number
        pitch: number
        volume: number
        clone: (orig: lyte.Sound) => lyte.Sound
        pause: (sound: lyte.Sound) => void
        play: (sound: lyte.Sound) => void
        resume: (sound: lyte.Sound) => void
        stop: (sound: lyte.Sound) => void
        __gc: (sound: lyte.Sound) => void
    }
    // Shader type 
    type Shader = {
        set: (shader: lyte.Shader, uniform_name: string, uniform_value: lyte.ShaderUniformValue) => void
        reset: (shader: lyte.Shader, uniform_name: string) => void
        __gc: (shader: lyte.Shader) => void
    }
    // ShaderBuilder type 
    type ShaderBuilder = {
        uniform: (shaderbuilder: lyte.ShaderBuilder, uniform_name: string, uniform_type: lyte.UniformType) => void
        vertex: (shaderbuilder: lyte.ShaderBuilder, vertex_code: string) => void
        fragment: (shaderbuilder: lyte.ShaderBuilder, fragment_code: string) => void
        build: (shaderbuilder: lyte.ShaderBuilder) => lyte.Shader
        __gc: (shaderbuilder: lyte.ShaderBuilder) => void
    }
    // Physics dynamics world + collision space. 
    type World = {
        update: (world: lyte.World, step_size: number) => void
        set_gravity: (world: lyte.World, x: number, y: number) => void
        new_circle_collider: (world: lyte.World, radius: number, x: number, y: number, angle: number) => void
        new_rect_collider: (world: lyte.World, width: number, height: number, x: number, y: number, angle: number) => void
        __gc: (world: lyte.World) => void
    }
    // Physics body + mass + colliding geometry. 
    type Collider = {
        x: number
        y: number
        angle: number
        refresh: (collider: lyte.Collider) => void
        set_position: (collider: lyte.Collider, x: number, y: number) => void
        set_rotation: (collider: lyte.Collider, angle: number) => void
        set_linear_velocity: (collider: lyte.Collider, vx: number, vy: number) => void
        set_angular_velocity: (collider: lyte.Collider, vz: number) => void
        add_force: (collider: lyte.Collider, fx: number, fy: number) => void
        add_torque: (collider: lyte.Collider, fz: number) => void
        is_kinematic: (collider: lyte.Collider) => boolean
        set_kinematic: (collider: lyte.Collider, val: boolean) => void
        get_collision_count: (collider: lyte.Collider) => number
        get_collisions: (collider: lyte.Collider) => lyte.CollisionList
        __gc: (collider: lyte.Collider) => void
    }
    // Collision information between two colliders 
    type Collision = {
        c1: lyte.Collider
        c2: lyte.Collider
        pos_x: number
        pos_y: number
        depth: number
    }
    // Physics joints (constraints). 
    type Joint = {
    }

    // variants (unions)

    // Shader uniform value 
    type ShaderUniformValue =
          number
        | lyte.FloatVec4
        | lyte.Image

    // lists

    // Float values
    type FloatVec4 = number[]
    // Collision List
    type CollisionList = object[]

    // dicts

    // 
    type UniformNamesToTypes = {[key: string]: lyte.UniformType}

    // enums

    // Acceptable uniformtype values.
    type UniformType =
          "_invalid"
        | "float"
        | "vec2"
        | "vec3"
        | "vec4"
        | "int"
        | "ivec2"
        | "ivec3"
        | "ivec4"
        | "mat4"
        | "sampler2D"
    // Acceptable blendmode values.
    type BlendMode =
          "none"
        | "blend"
        | "add"
        | "mod"
        | "mul"
    // Acceptable filtermode values.
    type FilterMode =
          "_invalid"
        | "nearest"
        | "linear"
    // Acceptable gamepadaxis values.
    type GamepadAxis =
          "left_x"
        | "left_y"
        | "right_x"
        | "right_y"
        | "left_trigger"
        | "right_trigger"
    // Acceptable gamepadbutton values.
    type GamepadButton =
          "pad_a"
        | "pad_b"
        | "pad_x"
        | "pad_y"
        | "left_bumper"
        | "right_bumper"
        | "back"
        | "start"
        | "guide"
        | "left_thumb"
        | "right_thumb"
        | "dpad_up"
        | "dpad_right"
        | "dpad_down"
        | "dpad_left"
    // Acceptable mousebutton values.
    type MouseButton =
          "mb1"
        | "mb2"
        | "mb3"
        | "mb4"
        | "mb5"
        | "mb6"
        | "mb7"
        | "mb8"
        | "scrollup"
        | "scrolldown"
    // Acceptable keyboardkey values.
    type KeyboardKey =
          "space"
        | "'"
        | ","
        | "-"
        | "."
        | "/"
        | "0"
        | "1"
        | "2"
        | "3"
        | "4"
        | "5"
        | "6"
        | "7"
        | "8"
        | "9"
        | ";"
        | "="
        | "a"
        | "b"
        | "c"
        | "d"
        | "e"
        | "f"
        | "g"
        | "h"
        | "i"
        | "j"
        | "k"
        | "l"
        | "m"
        | "n"
        | "o"
        | "p"
        | "q"
        | "r"
        | "s"
        | "t"
        | "u"
        | "v"
        | "w"
        | "x"
        | "y"
        | "z"
        | "["
        | "\\"
        | "]"
        | "`"
        | "world_1"
        | "world_2"
        | "escape"
        | "enter"
        | "tab"
        | "backspace"
        | "insert"
        | "delete"
        | "right"
        | "left"
        | "down"
        | "up"
        | "page_up"
        | "page_down"
        | "home"
        | "end"
        | "caps_lock"
        | "scroll_lock"
        | "num_lock"
        | "print_screen"
        | "pause"
        | "f1"
        | "f2"
        | "f3"
        | "f4"
        | "f5"
        | "f6"
        | "f7"
        | "f8"
        | "f9"
        | "f10"
        | "f11"
        | "f12"
        | "f13"
        | "f14"
        | "f15"
        | "f16"
        | "f17"
        | "f18"
        | "f19"
        | "f20"
        | "f21"
        | "f22"
        | "f23"
        | "f24"
        | "f25"
        | "kp_0"
        | "kp_1"
        | "kp_2"
        | "kp_3"
        | "kp_4"
        | "kp_5"
        | "kp_6"
        | "kp_7"
        | "kp_8"
        | "kp_9"
        | "kp_decimal"
        | "kp_divide"
        | "kp_multiply"
        | "kp_subtract"
        | "kp_add"
        | "kp_enter"
        | "kp_equal"
        | "left_shift"
        | "left_control"
        | "left_alt"
        | "left_super"
        | "right_shift"
        | "right_control"
        | "right_alt"
        | "right_super"
        | "menu"
}

