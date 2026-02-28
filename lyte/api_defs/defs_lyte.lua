---------------------------------------------------------------------------------------------
-- LYTE API -- source of truth for the API
---------------------------------------------------------------------------------------------

require "lib.apidef"

return process_def_tree(Namespace("lyte",
    Doc"lyte namespace.",
    Require("defs_lyte_core"),

    Function("tick",
        Arg("delta_time", Double),
        Arg("window_width", Int),
        Arg("window_height", Int),
        Arg("window_resized", Bool),
        Arg("is_fullscreen", Bool),
        Doc"Tick function. Should be created by the user.",
        UserImpl
    ),

    Function("quit", MapTo("lyte_core.quit")),

    Function("cls", MapTo("lyte_core.cls")),

    Function("set_color", MapTo("lyte_core.set_color")),

    Function("reset_color", MapTo("lyte_core.reset_color")),

    Function("draw_point", MapTo("lyte_core.draw_point")),

    Function("draw_line", MapTo("lyte_core.draw_line")),

    Function("draw_triangle", MapTo("lyte_core.draw_triangle")),

    Function("draw_triangle_line", MapTo("lyte_core.draw_triangle_line")),

    Function("draw_rect", MapTo("lyte_core.draw_rect")),

    Function("draw_rect_line", MapTo("lyte_core.draw_rect_line")),

    Function("draw_circle", MapTo("lyte_core.draw_circle")),

    Function("draw_circle_line", MapTo("lyte_core.draw_circle_line")),

    Function("draw_ellipse", MapTo("lyte_core.draw_ellipse")),

    Function("draw_ellipse_line", MapTo("lyte_core.draw_ellipse_line")),

    Function("cleanup_image",
        Arg("image", Wrap("Image")),
        Doc("Free Image resources"),
        -- dtor=true
        MapWrapTo("lyte_core.image_cleanup"),
        LuaImpl
    ),

    Function("load_image",
        Arg("image_path", String),
        Ret("val", Wrap("Image")),
        Doc"Load the image specified in the path.",
        -- ctor=true
        MapWrapTo("lyte_core.image_load"),
        LuaImpl
    ),

    Function("draw_image",
        Arg("image", Wrap("Image")),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("angle", Double),
        Arg("origin_x", Double),
        Arg("origin_y", Double),
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Doc"Draw an image. Angle, scale and origin values are all optional.",
        -- MapWrapTo("lyte_core.image_draw"),
        LuaImpl,
        Code[[function(image_wrapped, dest_x, dest_y, angle, origin_x, origin_y, scale_x, scale_y)
    local image = image_wrapped.id
    if not angle then
        lyte_core.image_draw(image, dest_x, dest_y)
    else
        angle = angle or 0
        scale_x = scale_x or 1
        scale_y = scale_y or 1
        origin_x = origin_x or 0
        origin_y = origin_y or 0
        lyte_core.image_draw_ex(image, dest_x, dest_y, angle, origin_x, origin_y, scale_x, scale_y)
    end
end
]]
    ),

    Function("draw_image_rect",
        Arg("image", Wrap("Image")),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("src_x", Double),
        Arg("src_y", Double),
        Arg("rect_width", Double),
        Arg("rect_height", Double),
        Arg("angle", Double),
        Arg("origin_x", Double),
        Arg("origin_y", Double),
        Arg("scale_x", Double),
        Arg("scale_y", Double),
        Doc"Draw a rectangular area from the image. Angle, scale and origin values are all optional.",
        -- MapWrapTo("lyte_core.image_draw_rect"),
        LuaImpl,
        Code[[function(image_wrapped, dest_x, dest_y, src_x, src_y, rect_width, rect_height, angle, origin_x, origin_y, scale_x, scale_y)
    local image = image_wrapped.id
    if not angle then
        lyte_core.image_draw_rect(image, dest_x, dest_y, src_x, src_y, rect_width, rect_height)
    else
        angle = angle or 0
        scale_x = scale_x or 1
        scale_y = scale_y or 1
        origin_x = origin_x or 0
        origin_y = origin_y or 0
        lyte_core.image_draw_rect_ex(image, dest_x, dest_y, src_x, src_y, rect_width, rect_height, angle, origin_x, origin_y, scale_x, scale_y)
    end
end
]]
    ),

    Function("get_image_width",
        Arg("image", Wrap("Image")),
        Ret("val", Int),
        Doc"Get the width of the image.",
        MapWrapTo("lyte_core.image_get_width"),
        LuaImpl
    ),

    Function("get_image_height",
        Arg("image", Wrap("Image")),
        Ret("val", Int),
        Doc"Get the height of the image.",
        MapWrapTo("lyte_core.image_get_height"),
        LuaImpl
    ),

    Function("new_canvas",
        Arg("width", Int),
        Arg("height", Int),
        Ret("val", Wrap("Image")),
        Doc"Create a canvas image with given width and height.",
        -- ctor=true
        MapWrapTo("lyte_core.image_new_canvas"),
        LuaImpl
    ),

    Function("set_canvas",
        Arg("canvas_image", Wrap("Image")),
        Doc"Set the effective canvas image. All draw operations will go to this canvas until it's reset.",
        -- MapWrapTo("lyte_core.image_set_canvas"),
        LuaImpl,
        Code[[function(canvas_image_wrapped)
    local canvas_image = canvas_image_wrapped.id
    lyte_core.image_set_canvas(canvas_image)
    lyte._current_canvas_save = canvas_image_wrapped
end
]]
    ),

    Function("reset_canvas", MapTo("lyte_core.reset_canvas")),

    Function("is_image_canvas",
        Arg("image", Wrap("Image")),
        Ret("val", Bool),
        Doc"Check if the image was created as a canvas.",
        MapWrapTo("lyte_core.image_is_canvas"),
        LuaImpl
    ),

    Function("cleanup_imagebatch",
        Arg("imagebatch", Wrap("ImageBatch")),
        Doc("Free ImageBatch resources"),
        -- dtor=true
        MapWrapTo("lyte_core.imagebatch_cleanup"),
        LuaImpl
    ),

    Function("new_imagebatch",
        Arg("image", Wrap("Image")),
        Ret("val", Wrap("ImageBatch")),
        Doc"Create an image batch",
        -- ctor=true
        MapWrapTo("lyte_core.imagebatch_new"),
        LuaImpl
    ),

    Function("reset_imagebatch",
        Arg("imagebatch", Wrap("ImageBatch")),
        Doc"Reset the image batch, remove all added rects.",
        MapWrapTo("lyte_core.imagebatch_reset"),
        LuaImpl
    ),

    Function("add_imagebatch_rect",
        Arg("imagebatch", Wrap("ImageBatch")),
        Arg("dest_x", Double),
        Arg("dest_y", Double),
        Arg("dest_width", Double),
        Arg("dest_height", Double),
        Arg("src_x", Double),
        Arg("src_y", Double),
        Arg("src_width", Double),
        Arg("src_height", Double),
        Doc"Add a recta to the image batch (from it's initial image). `src_width` and `src_height` are optional and will default to the corresponding `dest_` values.",
        -- MapWrapTo("lyte_core.imagebatch_add_rect"),
        LuaImpl,
        Code[[function(imagebatch_wrapped, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height)
    local imagebatch = imagebatch_wrapped.id
    src_width = src_width or dest_width
    src_height = src_height or dest_height
    lyte_core.imagebatch_add_rect(imagebatch, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height)
end
]]

    ),

    Function("get_imagebatch_rect_count",
        Arg("imagebatch", Wrap("ImageBatch")),
        Ret("val", Int),
        Doc"Get the number of rects in the image batch.",
        MapWrapTo("lyte_core.imagebatch_get_rect_count"),
        LuaImpl
    ),

    Function("draw_imagebatch",
        Arg("imagebatch", Wrap("ImageBatch")),
        Doc"Draw the image batch.",
        MapWrapTo("lyte_core.imagebatch_draw"),
        LuaImpl
    ),

    Function("cleanup_font",
        Arg("font", Wrap("Font")),
        Doc("Free Font resources"),
        -- dtor=true
        MapWrapTo("lyte_core.font_cleanup"),
        LuaImpl
    ),

    Function("load_font",
        Arg("font_path", String),
        Arg("size", Double),
        Ret("val", Wrap("Font")),
        Doc"Load the font specified in the path, and set the initial size.",
        -- ctor=true
        MapWrapTo("lyte_core.font_load"),
        LuaImpl
    ),

    Function("set_font",
        Arg("font", Wrap("Font")),
        Doc"Set the effective font to be used in the drawing operations.",
        -- MapWrapTo("lyte_core.font_set"),
        LuaImpl,
        Code[[function(font_wrapped)
    local font = font_wrapped.id
    lyte_core.font_set(font)
    lyte._current_font_save = font_wrapped
end
]]
    ),

    Function("reset_font",
        Doc"Reset the font to its default value.",
        LuaImpl,
        Code[[function()
    lyte.set_font(lyte._default_font) -- lyte._default_font set in lyte_boot
end
]]
    ),

    Function("draw_text", MapTo("lyte_core.draw_text")),

    Function("get_text_width", MapTo("lyte_core.get_text_width")),

    Function("get_text_height", MapTo("lyte_core.get_text_height")),

    Function("get_monitor_count", MapTo("lyte_core.get_monitor_count")),

    Function("get_monitor_name", MapTo("lyte_core.get_monitor_name")),

    Function("get_monitor_width", MapTo("lyte_core.get_monitor_width")),

    Function("get_monitor_height", MapTo("lyte_core.get_monitor_height")),

    Function("set_window_monitor", MapTo("lyte_core.set_window_monitor")),

    Function("set_window_resizable", MapTo("lyte_core.set_window_resizable")),

    Function("set_window_minsize", MapTo("lyte_core.set_window_minsize")),

    Function("set_window_size", MapTo("lyte_core.set_window_size")),

    Function("get_window_width", MapTo("lyte_core.get_window_width")),

    Function("get_window_height", MapTo("lyte_core.get_window_height")),

    Function("set_window_position", MapTo("lyte_core.set_window_position")),

    Function("set_fullscreen", MapTo("lyte_core.set_fullscreen")),

    Function("is_fullscreen", MapTo("lyte_core.is_fullscreen")),

    Function("set_window_title", MapTo("lyte_core.set_window_title")),

    Function("set_window_icon_file", MapTo("lyte_core.set_window_icon_file")),

    Function("set_window_margins", MapTo("lyte_core.set_window_margins")),

    Function("set_window_paddings", MapTo("lyte_core.set_window_paddings")),

    Function("is_key_down", MapTo("lyte_core.is_key_down")),

    Function("is_key_pressed", MapTo("lyte_core.is_key_pressed")),

    Function("is_key_released", MapTo("lyte_core.is_key_released")),

    Function("is_key_repeat", MapTo("lyte_core.is_key_repeat")),

    Function("get_pressed_keys", MapTo("lyte_core.get_pressed_keys")),

    Function("get_textinput", MapTo("lyte_core.get_textinput")),

    Function("is_mouse_down", MapTo("lyte_core.is_mouse_down")),

    Function("is_mouse_pressed", MapTo("lyte_core.is_mouse_pressed")),

    Function("is_mouse_released", MapTo("lyte_core.is_mouse_released")),

    Function("get_mouse_x", MapTo("lyte_core.get_mouse_x")),

    Function("get_mouse_y", MapTo("lyte_core.get_mouse_y")),

    Function("get_gamepad_count", MapTo("lyte_core.get_gamepad_count")),

    Function("get_gamepad_name", MapTo("lyte_core.get_gamepad_name")),

    Function("is_gamepad_down", MapTo("lyte_core.is_gamepad_down")),

    Function("is_gamepad_pressed", MapTo("lyte_core.is_gamepad_pressed")),

    Function("is_gamepad_released", MapTo("lyte_core.is_gamepad_released")),

    Function("get_gamepad_axis", MapTo("lyte_core.get_gamepad_axis")),

    Function("set_mastervolume", MapTo("lyte_core.set_mastervolume")),

    Function("get_mastervolume", MapTo("lyte_core.get_mastervolume")),

    Function("cleanup_music",
        Arg("music", Wrap("Music")),
        Doc("Free Music resources"),
        -- dtor=true
        MapWrapTo("lyte_core.music_cleanup"),
        LuaImpl
    ),

    Function("load_music",
        Arg("music_path", String),
        Ret("val", Wrap("Music")),
        Doc"Load the music specified in the path.",
        -- ctor=true
        MapWrapTo("lyte_core.music_load"),
        LuaImpl
    ),

    Function("play_music",
        Arg("music", Wrap("Music")),
        Doc"Play the music.",
        -- MapWrapTo("lyte_core.music_play"),
        LuaImpl,
        Code[[function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_play(music)
    lyte._current_music_save = music_wrapped
end
]]
    ),

    Function("pause_music",
        Arg("music", Wrap("Music")),
        Doc"Pause the music.",
        MapWrapTo("lyte_core.music_pause"),
        LuaImpl
    ),

    Function("resume_music",
        Arg("music", Wrap("Music")),
        Doc"Resume the music.",
        MapWrapTo("lyte_core.music_resume"),
        LuaImpl
    ),

    Function("stop_music",
        Arg("music", Wrap("Music")),
        Doc"Stop the music.",
        MapWrapTo("lyte_core.music_resume"),
        LuaImpl
    ),

    Function("is_music_playing",
        Arg("music", Wrap("Music")),
        Ret("val", Bool),
        Doc"Check if the given music is playing.",
        MapWrapTo("lyte_core.music_is_playing"),
        LuaImpl
    ),

    Function("get_music_length",
        Arg("music", Wrap("Music")),
        Ret("val", Double),
        Doc"Get the length of the given music object in seconds.",
        MapWrapTo("lyte_core.music_get_length"),
        LuaImpl
    ),

    Function("get_music_length_played",
        Arg("music", Wrap("Music")),
        Ret("val", Double),
        Doc"Get the already played length of the given music object in seconds.",
        MapWrapTo("lyte_core.music_get_length_played"),
        LuaImpl
    ),

    Function("seek_music",
        Arg("music", Wrap("Music")),
        Arg("secs", Double),
        Doc"Move the music time played to the given value.",
        MapWrapTo("lyte_core.music_seek"),
        LuaImpl
    ),

    Function("set_music_volume",
        Arg("music", Wrap("Music")),
        Arg("volume", Double),
        Doc"Set the volume of the given music object.",
        MapWrapTo("lyte_core.music_set_volume"),
        LuaImpl
    ),

    Function("set_music_pan",
        Arg("music", Wrap("Music")),
        Arg("pan", Double),
        Doc"Set the pan of the given music object.",
        MapWrapTo("lyte_core.music_set_pan"),
        LuaImpl
    ),

    Function("set_music_pitch",
        Arg("music", Wrap("Music")),
        Arg("pitch", Double),
        Doc"Set the pitch of the given music object.",
        MapWrapTo("lyte_core.music_set_pitch"),
        LuaImpl
    ),

    Function("get_music_volume",
        Arg("music", Wrap("Music")),
        Ret("val", Double),
        Doc"Get the volume of the given music object.",
        MapWrapTo("lyte_core.music_get_volume"),
        LuaImpl
    ),

    Function("get_music_pan",
        Arg("music", Wrap("Music")),
        Ret("val", Double),
        Doc"Get the pan of the given music object.",
        MapWrapTo("lyte_core.music_get_pan"),
        LuaImpl
    ),

    Function("get_music_pitch",
        Arg("music", Wrap("Music")),
        Ret("val", Double),
        Doc"Get the pitch of the given music object.",
        MapWrapTo("lyte_core.music_get_pitch"),
        LuaImpl
    ),

    Function("cleanup_sound",
        Arg("sound", Wrap("Sound")),
        Doc("Free Sound resources"),
        -- dtor=true
        MapWrapTo("lyte_core.sound_cleanup"),
        LuaImpl
    ),

    Function("load_sound",
        Arg("sound_path", String),
        Ret("val", Wrap("Sound")),
        Doc"Load the sound specified in the path.",
        -- ctor=true,
        MapWrapTo("lyte_core.sound_load"),
        LuaImpl
    ),

    Function("clone_sound",
        Arg("orig", Wrap("Sound")),
        Ret("val", Wrap("Sound")),
        Doc"Clone the sound specified in the path.",
        -- ctor=true,
        MapWrapTo("lyte_core.sound_clone"),
        LuaImpl
    ),

    Function("play_sound",
        Arg("sound", Wrap("Sound")),
        Doc"Play the sound.",
        MapWrapTo("lyte_core.sound_play"),
        LuaImpl
    ),

    Function("pause_sound",
        Arg("sound", Wrap("Sound")),
        Doc"Pause the sound.",
        MapWrapTo("lyte_core.sound_pause"),
        LuaImpl
    ),

    Function("resume_sound",
        Arg("sound", Wrap("Sound")),
        Doc"Resume the sound.",
        MapWrapTo("lyte_core.sound_resume"),
        LuaImpl
    ),

    Function("stop_sound",
        Arg("sound", Wrap("Sound")),
        Doc"Stop the sound.",
        MapWrapTo("lyte_core.sound_stop"),
        LuaImpl
    ),

    Function("is_sound_playing",
        Arg("sound", Wrap("Sound")),
        Ret("val", Bool),
        Doc"Check if the given sound is playing.",
        MapWrapTo("lyte_core.sound_is_playing"),
        LuaImpl
    ),

    Function("set_sound_volume",
        Arg("sound", Wrap("Sound")),
        Arg("volume", Double),
        Doc"Set the volume of the given sound object.",
        MapWrapTo("lyte_core.sound_set_volume"),
        LuaImpl
    ),

    Function("set_sound_pan",
        Arg("sound", Wrap("Sound")),
        Arg("pan", Double),
        Doc"Set the pan of the given sound object.",
        MapWrapTo("lyte_core.sound_set_pan"),
        LuaImpl
    ),

    Function("set_sound_pitch",
        Arg("sound", Wrap("Sound")),
        Arg("pitch", Double),
        Doc"Set the pitch of the given sound object.",
        MapWrapTo("lyte_core.sound_set_pitch"),
        LuaImpl
    ),

    Function("get_sound_volume",
        Arg("sound", Wrap("Sound")),
        Ret("val", Double),
        Doc"Get the volume of the given sound object.",
        MapWrapTo("lyte_core.sound_get_volume"),
        LuaImpl
    ),

    Function("get_sound_pan",
        Arg("sound", Wrap("Sound")),
        Ret("val", Double),
        Doc"Get the pan of the given sound object.",
        MapWrapTo("lyte_core.sound_get_pan"),
        LuaImpl
    ),

    Function("get_sound_pitch",
        Arg("sound", Wrap("Sound")),
        Ret("val", Double),
        Doc"Get the pitch of the given sound object.",
        MapWrapTo("lyte_core.sound_get_pitch"),
        LuaImpl
    ),

    Function("load_textfile", MapTo("lyte_core.load_textfile")),

    Function("save_textfile", MapTo("lyte_core.save_textfile")),

    Function("save_textfile_append", MapTo("lyte_core.save_textfile_append")),

    Function("push_matrix", MapTo("lyte_core.push_matrix")),

    Function("pop_matrix", MapTo("lyte_core.pop_matrix")),

    Function("reset_matrix", MapTo("lyte_core.reset_matrix")),

    Function("translate", MapTo("lyte_core.translate")),

    Function("rotate", MapTo("lyte_core.rotate")),

    Function("rotate_at", MapTo("lyte_core.rotate_at")),

    Function("scale", MapTo("lyte_core.scale")),

    Function("scale_at", MapTo("lyte_core.scale_at")),

    Function("set_default_blendmode", MapTo("lyte_core.set_default_blendmode")),

    Function("set_blendmode", MapTo("lyte_core.set_blendmode")),

    Function("reset_blendmode", MapTo("lyte_core.reset_blendmode")),

    Function("set_default_filtermode", MapTo("lyte_core.set_default_filtermode")),

    Function("set_filtermode", MapTo("lyte_core.set_filtermode")),

    Function("reset_filtermode", MapTo("lyte_core.reset_filtermode")),


    Dict("UniformNamesToTypes",
        String,
        T("UniformType")
        -- c_api_skip=true
    ),

    Function("cleanup_shaderbuilder",
        Arg("shaderbuilder", Wrap("ShaderBuilder")),
        Doc("Free ShaderBuilder resources"),
        -- dtor=true
        MapWrapTo("lyte_core.shaderbuilder_cleanup"),
        LuaImpl
    ),

    Function("new_shaderbuilder",
        Ret("val", Wrap("ShaderBuilder")),
        Doc"Create a ShaderBuilder object.",
        -- ctor=true,
        MapWrapTo("lyte_core.shaderbuilder_new"),
        LuaImpl
    ),

    -- wrapping a "enum" UniformType" is possibly an issue
    Function("shaderbuilder_uniform",
        Arg("shaderbuilder", Wrap("ShaderBuilder")),
        Arg("uniform_name", String),
        Arg("uniform_type", T("UniformType")),
        Doc"Add uniform definition to the shaderbuilder",
        MapWrapTo("lyte_core.shaderbuilder_uniform"),
        LuaImpl
    ),

    Function("shaderbuilder_vertex",
        Arg("shaderbuilder", Wrap("ShaderBuilder")),
        Arg("vertex_code", String),
        Doc"Add vertex code to the shaderbuilder",
        MapWrapTo("lyte_core.shaderbuilder_vertex"),
        LuaImpl
    ),

    Function("shaderbuilder_fragment",
        Arg("shaderbuilder", Wrap("ShaderBuilder")),
        Arg("fragment_code", String),
        Doc"Add fragment to the shaderbuilder",
        MapWrapTo("lyte_core.shaderbuilder_fragment"),
        LuaImpl
    ),

    Function("shaderbuilder_build",
        Arg("shaderbuilder", Wrap("ShaderBuilder")),
        Ret("shader", Wrap("Shader")),
        Doc"Add fragment to the shaderbuilder",
        -- ctor="true"
        MapWrapTo("lyte_core.shaderbuilder_build"),
        LuaImpl
    ),

    Function("cleanup_shader",
        Arg("shader", Wrap("Shader")),
        Doc("Free Shader resources"),
        -- dtor=true
        MapWrapTo("lyte_core.shader_cleanup"),
        LuaImpl
    ),

    Record("ShaderDef",
        Field("frag", String),
        Field("vert", String),
        Field("uniforms", T("UniformNamesToTypes")),
        Doc"Shader definition: uniforms declaration, vertex and fragment shader code."
    ),

    Function("new_shader",
        Arg("shaderdef", Wrap("ShaderDef")),
        Ret("val", Wrap("Shader")),
        Doc"Create a shader with given specification.",
        -- ctor=true,
        LuaImpl,
        Code[[function(def)
    assert(def.uniforms)
    assert(def.vert)
    assert(def.frag)
    local sb = lyte.new_shaderbuilder()
    for k,v in pairs(def.uniforms) do
        sb:uniform(k, v)
    end
    sb:vertex(def.vert)
    sb:fragment(def.frag)
    local shader = sb:build()
    return shader;
end
]]
    ),

    Function("set_shader",
        Arg("shader", Wrap("Shader")),
        Doc"Set the custom shader and use it for consequent calls.",
        -- MapWrapTo("lyte_core.shader_set"),
        LuaImpl,
        Code[[function(shader_wrapped)
    local shader = shader_wrapped.id
    lyte_core.shader_set(shader)
    lyte._current_shader_save = shader_wrapped
end
]]
    ),

    Function("reset_shader", MapTo("lyte_core.reset_shader")),

    Function("set_shader_uniform",
        Arg("shader", Wrap("Shader")),
        Arg("uniform_name", String),
        Arg("uniform_value", T("ShaderUniformValue")),
        Doc"Set the specified uniform.",
        -- MapWrapTo("lyte_core.shader_set_uniform"),
        LuaImpl,
        Code[[function (shader, uniform_name, uniform_value)
    -- check the value type for one of the following, and call the "right" func
      -- shader_set_uniform_float
      -- shader_set_uniform_floatvec4
      -- shader_set_uniform_image
    local vt = type(uniform_value)
    if vt == "number" then
        -- send float
        lyte_core.shader_set_uniform_float(shader.id, uniform_name, uniform_value)
    elseif vt == "table" then
        -- number table? or "data" table? check metatable for "Image" and also check count "#"
        if #uniform_value > 0 then
            lyte_core.shader_set_uniform_floatvec4(shader.id, uniform_name, uniform_value)
        elseif getmetatable(uniform_value) == lyte.Image then
            local img_id = uniform_value.id
            lyte_core.shader_set_uniform_image(shader.id, uniform_name, img_id)
        else
            error("Unknown type for uniform_value in set_shader_uniform. Expected: float, float list or lyte.Image")
        end
    else
        error("Unknown value type for uniform_value in set_shader_uniform")
    end
end
]]
    ),

    Function("reset_shader_uniform",
        Arg("shader", Wrap("Shader")),
        Arg("uniform_name", String),
        Doc"Reset the specified uniform.",
        MapWrapTo("lyte_core.shader_reset_uniform"),
        LuaImpl
    ),

    Record("Image",
        Field("width", Int, MapRead("get_image_width")),
        Field("height", Int, MapRead("get_image_height")),
        Field("is_canvas", Bool, MapRead("is_image_canvas")),
        Method("__gc", MapTo("cleanup_image")),
        Doc"Image type"
    ),

    Record("ImageBatch",
        Field("rect_count", Int, MapRead("get_imagebatch_rect_count")),
        Method("add_rect", MapTo("add_imagebatch_rect")),
        Method("draw", MapTo("draw_imagebatch")),
        Method("reset", MapTo("reset_imagebatch")),
        Method("__gc", MapTo("cleanup_imagebatch")),
        Doc"ImageBatch type."
    ),

    Record("Font",
        Method("__gc", MapTo("cleanup_font")),
        Doc"Font type."
    ),

    Record("Music",
        Field("playing", Bool, MapRead("is_music_playing")),
        Field("length", Double, MapRead("get_music_length")),
        Field("length_played", Double, MapRead("get_music_length_played")),
        Field("pan", Double, MapRead("get_music_pan"), MapWrite("set_music_pan")),
        Field("pitch", Double, MapRead("get_music_pitch"), MapWrite("set_music_pitch")),
        Field("volume", Double, MapRead("get_music_volume"), MapWrite("set_music_volume")),
        Method("play", MapTo("play_music")),
        Method("pause", MapTo("pause_music")),
        Method("resume", MapTo("resume_music")),
        Method("stop", MapTo("stop_music")),
        Method("seek", MapTo("seek_music")),
        Method("__gc", MapTo("cleanup_music")),
        Doc"Music type."
    ),

    Record("Sound",
        Field("pan", Double, MapRead("get_sound_pan"), MapWrite("set_sound_pan")),
        Field("pitch", Double, MapRead("get_sound_pitch"), MapWrite("set_sound_pitch")),
        Field("volume", Double, MapRead("get_sound_volume"), MapWrite("set_sound_volume")),
        Method("clone", MapTo("clone_sound")),
        Method("pause", MapTo("pause_sound")),
        Method("play", MapTo("play_sound")),
        Method("resume", MapTo("resume_sound")),
        Method("stop", MapTo("stop_sound")),
        Method("__gc", MapTo("cleanup_sound")),
        Doc"Sound type."
    ),

    List("FloatVec4",
        Float,
        MaxCount(4),
        Doc"Float values"
    ),

    Variant("ShaderUniformValue",
        Option("float_val", Float, Doc"Note: Used for single numbers, int or float"),
        Option("vec_val", T("FloatVec4")),
        Option("sampler2D_val", T("Image")),
        Doc"Shader uniform value"
    ),

    Record("Shader",
        Method("set", MapTo("set_shader_uniform")),
        Method("reset", MapTo("reset_shader_uniform")),
        Method("__gc", MapTo("cleanup_shader")),
        Doc"Shader type"
    ),

    Record("ShaderBuilder",
        Method("uniform", MapTo("shaderbuilder_uniform")),
        Method("vertex", MapTo("shaderbuilder_vertex")),
        Method("fragment", MapTo("shaderbuilder_fragment")),
        Method("build", MapTo("shaderbuilder_build")),
        Method("__gc", MapTo("cleanup_shaderbuilder")),
        Doc"ShaderBuilder type"
    )

--[==[
    ,

    Function("cleanup_world",
        Arg("world", Wrap("World")),
        Doc("Cleanup the physics world (dynamics + collision)."),
        LuaImpl,
        Code[[function(world)
    local world_id = world.id
    local space_id = world.space_id
    local contacts_jg_id = world.contacts_jg_id
    local other_jg_id = world.other_jg_id
    lyte_core.cleanup_jointgroup(other_jg_id)
    lyte_core.cleanup_jointgroup(contacts_jg_id)
    lyte_core.cleanup_space(space_id)
    lyte_core.cleanup_world(world_id)
    return world
end
]]
    ),

    Function("new_world",
        Ret("world", Wrap("World")),
        Doc("Create a new physics world"),
        LuaImpl,
        Code[[function()
    local world_id = lyte_core.world_new()
    local space_id = lyte_core.space_new()
    local contacts_jg_id = lyte_core.jointgroup_new()
    local other_jg_id = lyte_core.jointgroup_new()

    local world = classnew(lyte.World, world_id)
    world.space_id = space_id
    world.contacts_jg_id = contacts_jg_id
    world.other_jg_id = other_jg_id

    return world
end
]]
    ),

    Function("update_world",
        Arg("world", Wrap("World")),
        Arg("step_size", Double),
        Doc("Update the physics world (dynamics + collision)."),
        LuaImpl,
        Code[[function(world, step_size)
    local world_id = world.id
    local space_id = world.space_id
    local contacts_jg_id = world.contacts_jg_id

    lyte_core.world_update(world_id, step_size)
    lyte_core.coll_update_correct(space_id)
    lyte_core.coll_update_check(world_id, space_id, contacts_jg_id);
end
]]
    ),

    Function("set_world_gravity",
        Arg("world", Wrap("World")),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Update the physics world gravity."),
        LuaImpl,
        Code[[function(world, x, y)
    local world_id = world.id
    lyte_core.world_set_gravity(world_id, x, y)
end
]]
    ),

    Function("cleanup_collider",
        Arg("collider", Wrap("Collider")),
        Doc("Cleanup the physics collider."),
        LuaImpl,
        Code[[function(collider)
    local body_id = collider.id
    local geom_id = collider.geom_id
    lyte_core.cleanup_geom(geom_id)
    lyte_core.clean_body(body_id)
end
]]
    ),

    Function("refresh_collider",
        Arg("collider", Wrap("Collider")),
        Doc("Refresh the physics collider position (x, y) and angle"),
        LuaImpl,
        Code[[function(collider)
    local body_id = collider.id
    collider.x, collider.y = lyte_core.body_get_position(body_id)
    collider.angle = lyte_core.body_get_rotation(body_id)
end
]]
    ),



    Function("new_circle_collider",
        Arg("world", Wrap("World")),
        Arg("radius", Double),
        Arg("x", Double),
        Arg("y", Double),
        Arg("angle", Double),
        Doc("Create new circle collider (body + geom) in the given physics world."),
        LuaImpl,
        Code[[function(world, radius, x, y, angle)
    local world_id = world.id
    local space_id = world.space_id

    local body_id = lyte_core.body_new(world_id)
    local geom_id = lyte_core.geom_new_circle(space_id, radius)
    local collider = classnew(lyte.Collider, body_id)
    collider.geom_id = geom_id
    collider.x = x
    collider.y = src_y
    collider.angle = angle
    collider.radius = radius

    lyte_core.geom_set_body(geom_id, body_id)
    lyte_core.body_set_position(body_id, x, y)
    lyte_core.body_set_rotation(body_id, angle)

    -- lyte_core.body_set_mass_circle(body_id, 2*math.pi*radius, radius)

    return collider
end
]]
    ),

    Function("new_rect_collider",
        Arg("world", Wrap("World")),
        Arg("width", Double),
        Arg("height", Double),
        Arg("x", Double),
        Arg("y", Double),
        Arg("angle", Double),
        Doc("Create new rectangle collider (body + geom) in the given physics world."),
        LuaImpl,
        Code[[function(world, width, height, x, y, angle)
    local world_id = world.id
    local space_id = world.space_id

    local body_id = lyte_core.body_new(world_id)
    local geom_id = lyte_core.geom_new_rect(space_id, width, height)
    local collider = classnew(lyte.Collider, body_id)
    collider.geom_id = geom_id
    collider.x = x
    collider.y = src_y
    collider.angle = angle
    collider.width = width
    collider.height = height

    lyte_core.geom_set_body(geom_id, body_id)
    lyte_core.body_set_position(body_id, x, y)
    lyte_core.body_set_rotation(body_id, angle)

    -- lyte_core.body_set_mass_rect(body_id, width*height, width, height)

    return collider
end
]]
    ),

    Function("set_collider_position",
        Arg("collider", Wrap("Collider")),
        Arg("x", Double),
        Arg("y", Double),
        Doc("Set collider position."),
        MapWrapTo("lyte_core.body_set_position")
    ),

    Function("set_collider_rotation",
        Arg("collider", Wrap("Collider")),
        Arg("angle", Double),
        Doc("Set collider rotation."),
        MapWrapTo("lyte_core.body_set_rotation")
    ),

    Function("add_force_to_collider",
        Arg("collider", Wrap("Collider")),
        Arg("fx", Double),
        Arg("fy", Double),
        Doc("Add force to collider."),
        MapWrapTo("lyte_core.body_add_force")
    ),

    Function("add_torque_to_collider",
        Arg("collider", Wrap("Collider")),
        Arg("fz", Double),
        Doc("Add torque to collider."),
        MapWrapTo("lyte_core.body_add_torque")
    ),

    Function("set_collider_linear_velocity",
        Arg("collider", Wrap("Collider")),
        Arg("vx", Double),
        Arg("vy", Double),
        Doc("Set the collider's linear velocity"),
        MapWrapTo("lyte_core.body_set_linear_vel")
    ),

    Function("set_collider_angular_velocity",
        Arg("collider", Wrap("Collider")),
        Arg("vz", Double),
        Doc("Set the collider's angular velocity"),
        MapWrapTo("lyte_core.body_set_angular_vel")
    ),

    Function("set_collider_kinematic",
        Arg("collider", Wrap("Collider")),
        Arg("val", Bool),
        Doc("Set the collider as 'kinematic'. By default, it's not kinematic."),
        MapWrapTo("lyte_core.body_set_kinematic")
    ),

    Function("is_collider_kinematic",
        Arg("collider", Wrap("Collider")),
        Ret("val", Bool),
        Doc("Is the collider set as 'kinematic'? By default, it's not."),
        MapWrapTo("lyte_core.body_is_kinematic")
    ),


    Function("get_collider_collision_count",
        Arg("collider", Wrap("Collider")),
        Ret("val", Int),
        Doc("Get the number of collisions in the current frame"),
        MapWrapTo("lyte_core.body_get_collision_count")
    ),

    Function("get_collider_collisions",
        Arg("collider", Wrap("Collider")),
        Ret("colls", Wrap("CollisionList")),
        Doc("Get the collision data in the current frame as a list"),
        Code[[function(collider)
        local body_id = collider.id
        local colls = {}
        local cnt = lyte_core.body_get_collision_count(body_id)
        for i=0,cnt-1 do
            local b2_id, pos_x, pos_y, depth =  lyte_core.body_get_collision_data_at(body_id, i)
            local coll = {c1=body_id, c2=b2_id, pos_x=pos_x, pos_y=pos_y, depth=depth}
            colls[i+1] = coll
        end
        return colls
    end
]]
    ),

    Record("World",
        Method("update", MapTo("update_world")),
        Method("set_gravity", MapTo("set_world_gravity")),
        Method("new_circle_collider", MapTo("new_circle_collider")),
        Method("new_rect_collider", MapTo("new_rect_collider")),
        Method("__gc", MapTo("cleanup_world")),
        Doc("Physics dynamics world + collision space.")
    ),

    Record("Collider",
        Field("x", Double),
        Field("y", Double),
        Field("angle", Double),
        Method("refresh", MapTo("refresh_collider")),
        Method("set_position", MapTo("set_collider_position")),
        Method("set_rotation", MapTo("set_collider_rotation")),
        Method("set_linear_velocity", MapTo("set_collider_linear_velocity")),
        Method("set_angular_velocity", MapTo("set_collider_angular_velocity")),
        Method("add_force", MapTo("add_force_to_collider")),
        Method("add_torque", MapTo("add_torque_to_collider")),
        Method("is_kinematic", MapTo("is_collider_kinematic")),
        Method("set_kinematic", MapTo("set_collider_kinematic")),
        Method("get_collision_count", MapTo("get_collider_collision_count")),
        Method("get_collisions", MapTo("get_collider_collisions")),
        Method("__gc", MapTo("cleanup_collider")),
        Doc("Physics body + mass + colliding geometry.")
    ),

    -- Record("FixedCollider",
    --     Field("x", Double),
    --     Field("y", Double),
    --     Field("angle", Double),
    --     -- Method("refresh", MapTo("refresh_fixedcollider")),
    --     -- Method("set_position", MapTo("set_fixedcollider_position")),
    --     -- Method("set_rotation", MapTo("set_fixedcollider_rotation")),
    --     -- Method("get_collision_count", MapTo("get_fixedcollider_collision_count")),
    --     -- Method("get_collisions", MapTo("get_fixedcollider_collisions")),
    --     -- Method("__gc", MapTo("cleanup_fixedcollider")),
    --     Doc("Physics colliding geometry. Forces do not apply, but it can collide with other colliders.")
    -- ),

    Record("Collision",
        Field("c1", Wrap("Collider")),
        Field("c2", Wrap("Collider")),
        Field("pos_x", Double),
        Field("pos_y", Double),
        Field("depth", Double),
        Doc("Collision information between two colliders")
    ),

    List("CollisionList",
        Pointer,
        MaxCount(10),
        Doc"Collision List"
    ),

    Record("Joint",
        -- Method("__gc", MapTo("cleanup_joint")),
        Doc("Physics joints (constraints).")
    )
--]==]

))
