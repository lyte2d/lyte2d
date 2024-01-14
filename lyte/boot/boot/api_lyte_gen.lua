-- generated

-- Lua API: lyte
lyte = lyte or {}

-- mapped functions
lyte.quit =  lyte_core.quit
lyte.cls =  lyte_core.cls
lyte.set_color =  lyte_core.set_color
lyte.reset_color =  lyte_core.reset_color
lyte.draw_point =  lyte_core.draw_point
lyte.draw_line =  lyte_core.draw_line
lyte.draw_triangle =  lyte_core.draw_triangle
lyte.draw_triangle_line =  lyte_core.draw_triangle_line
lyte.draw_rect =  lyte_core.draw_rect
lyte.draw_rect_line =  lyte_core.draw_rect_line
lyte.draw_circle =  lyte_core.draw_circle
lyte.draw_circle_line =  lyte_core.draw_circle_line
lyte.draw_ellipse =  lyte_core.draw_ellipse
lyte.draw_ellipse_line =  lyte_core.draw_ellipse_line
lyte.reset_canvas =  lyte_core.reset_canvas
lyte.draw_text =  lyte_core.draw_text
lyte.get_text_width =  lyte_core.get_text_width
lyte.get_text_height =  lyte_core.get_text_height
lyte.get_monitor_count =  lyte_core.get_monitor_count
lyte.get_monitor_name =  lyte_core.get_monitor_name
lyte.get_monitor_width =  lyte_core.get_monitor_width
lyte.get_monitor_height =  lyte_core.get_monitor_height
lyte.set_window_monitor =  lyte_core.set_window_monitor
lyte.set_window_resizable =  lyte_core.set_window_resizable
lyte.set_window_minsize =  lyte_core.set_window_minsize
lyte.set_window_size =  lyte_core.set_window_size
lyte.get_window_width =  lyte_core.get_window_width
lyte.get_window_height =  lyte_core.get_window_height
lyte.set_window_position =  lyte_core.set_window_position
lyte.set_fullscreen =  lyte_core.set_fullscreen
lyte.is_fullscreen =  lyte_core.is_fullscreen
lyte.set_window_title =  lyte_core.set_window_title
lyte.set_window_vsync =  lyte_core.set_window_vsync
lyte.is_window_vsync =  lyte_core.is_window_vsync
lyte.set_window_icon_file =  lyte_core.set_window_icon_file
lyte.set_window_margins =  lyte_core.set_window_margins
lyte.set_window_paddings =  lyte_core.set_window_paddings
lyte.is_key_down =  lyte_core.is_key_down
lyte.is_key_pressed =  lyte_core.is_key_pressed
lyte.is_key_released =  lyte_core.is_key_released
lyte.is_key_repeat =  lyte_core.is_key_repeat
lyte.is_mouse_down =  lyte_core.is_mouse_down
lyte.is_mouse_pressed =  lyte_core.is_mouse_pressed
lyte.is_mouse_released =  lyte_core.is_mouse_released
lyte.get_mouse_x =  lyte_core.get_mouse_x
lyte.get_mouse_y =  lyte_core.get_mouse_y
lyte.get_gamepad_count =  lyte_core.get_gamepad_count
lyte.get_gamepad_name =  lyte_core.get_gamepad_name
lyte.is_gamepad_down =  lyte_core.is_gamepad_down
lyte.is_gamepad_pressed =  lyte_core.is_gamepad_pressed
lyte.is_gamepad_released =  lyte_core.is_gamepad_released
lyte.get_gamepad_axis =  lyte_core.get_gamepad_axis
lyte.set_mastervolume =  lyte_core.set_mastervolume
lyte.get_mastervolume =  lyte_core.get_mastervolume
lyte.load_textfile =  lyte_core.load_textfile
lyte.save_textfile =  lyte_core.save_textfile
lyte.save_textfile_append =  lyte_core.save_textfile_append
lyte.push_matrix =  lyte_core.push_matrix
lyte.pop_matrix =  lyte_core.pop_matrix
lyte.reset_matrix =  lyte_core.reset_matrix
lyte.translate =  lyte_core.translate
lyte.rotate =  lyte_core.rotate
lyte.rotate_at =  lyte_core.rotate_at
lyte.scale =  lyte_core.scale
lyte.scale_at =  lyte_core.scale_at
lyte.set_default_blendmode =  lyte_core.set_default_blendmode
lyte.set_blendmode =  lyte_core.set_blendmode
lyte.reset_blendmode =  lyte_core.reset_blendmode
lyte.set_default_filtermode =  lyte_core.set_default_filtermode
lyte.set_filtermode =  lyte_core.set_filtermode
lyte.reset_filtermode =  lyte_core.reset_filtermode
lyte.reset_shader =  lyte_core.reset_shader

-- records 
lyte.ShaderDef = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __tostring=function(self) return '(obj type = lyte.ShaderDef)' end;
}
lyte.Image = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='width' then return lyte.get_image_width(self, k) end
        if k=='height' then return lyte.get_image_height(self, k) end
        if k=='is_canvas' then return lyte.is_image_canvas(self, k) end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __gc=lyte.cleanup_image;
    __tostring=function(self) return '(obj type = lyte.Image)' end;
}
lyte.ImageBatch = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='rect_count' then return lyte.get_imagebatch_rect_count(self, k) end
        if k=='add_rect' then return lyte.add_imagebatch_rect end
        if k=='draw' then return lyte.draw_imagebatch end
        if k=='reset' then return lyte.reset_imagebatch end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __gc=lyte.cleanup_imagebatch;
    __tostring=function(self) return '(obj type = lyte.ImageBatch)' end;
}
lyte.Font = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __gc=lyte.cleanup_font;
    __tostring=function(self) return '(obj type = lyte.Font)' end;
}
lyte.Music = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='playing' then return lyte.is_music_playing(self, k) end
        if k=='length' then return lyte.get_music_length(self, k) end
        if k=='length_played' then return lyte.get_music_length_played(self, k) end
        if k=='pan' then return lyte.get_music_pan(self, k) end
        if k=='pitch' then return lyte.get_music_pitch(self, k) end
        if k=='volume' then return lyte.get_music_volume(self, k) end
        if k=='play' then return lyte.play_music end
        if k=='pause' then return lyte.pause_music end
        if k=='resume' then return lyte.resume_music end
        if k=='stop' then return lyte.stop_music end
        if k=='seek' then return lyte.seek_music end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
        if k=='pan' then lyte.set_music_pan(self, v)
        elseif k=='pitch' then lyte.set_music_pitch(self, v)
        elseif k=='volume' then lyte.set_music_volume(self, v)
        end
    end;
    __gc=lyte.cleanup_music;
    __tostring=function(self) return '(obj type = lyte.Music)' end;
}
lyte.Sound = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='pan' then return lyte.get_sound_pan(self, k) end
        if k=='pitch' then return lyte.get_sound_pitch(self, k) end
        if k=='volume' then return lyte.get_sound_volume(self, k) end
        if k=='clone' then return lyte.clone_sound end
        if k=='pause' then return lyte.pause_sound end
        if k=='play' then return lyte.play_sound end
        if k=='resume' then return lyte.resume_sound end
        if k=='stop' then return lyte.stop_sound end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
        if k=='pan' then lyte.set_sound_pan(self, v)
        elseif k=='pitch' then lyte.set_sound_pitch(self, v)
        elseif k=='volume' then lyte.set_sound_volume(self, v)
        end
    end;
    __gc=lyte.cleanup_sound;
    __tostring=function(self) return '(obj type = lyte.Sound)' end;
}
lyte.Shader = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='set' then return lyte.set_shader_uniform end
        if k=='reset' then return lyte.reset_shader_uniform end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __gc=lyte.cleanup_shader;
    __tostring=function(self) return '(obj type = lyte.Shader)' end;
}
lyte.ShaderBuilder = {
    id=nil;
    __new=function(self, id) rawset(self, 'id', id) end;
    __index=function(self, k)
        if k=='uniform' then return lyte.shaderbuilder_uniform end
        if k=='vertex' then return lyte.shaderbuilder_vertex end
        if k=='fragment' then return lyte.shaderbuilder_fragment end
        if k=='build' then return lyte.shaderbuilder_build end
        return rawget(self, k)
    end;
    __newindex=function(self, k, v)
    end;
    __gc=lyte.cleanup_shaderbuilder;
    __tostring=function(self) return '(obj type = lyte.ShaderBuilder)' end;
}

-- lua 'wrapping' functions
lyte.cleanup_image = function(image_wrapped)
    local image = image_wrapped.id
    lyte_core.image_cleanup(image)
end
lyte.load_image = function(image_path)
    local val = lyte_core.image_load(image_path)
    local _ret_val = classnew(lyte.Image, val)
    return _ret_val
end
lyte.draw_image = function(image_wrapped, dest_x, dest_y)
    local image = image_wrapped.id
    lyte_core.image_draw(image, dest_x, dest_y)
end
lyte.draw_image_rect = function(image_wrapped, dest_x, dest_y, src_x, src_y, rect_width, rect_height)
    local image = image_wrapped.id
    lyte_core.image_draw_rect(image, dest_x, dest_y, src_x, src_y, rect_width, rect_height)
end
lyte.get_image_width = function(image_wrapped)
    local image = image_wrapped.id
    local val = lyte_core.image_get_width(image)
    local _ret_val = val
    return _ret_val
end
lyte.get_image_height = function(image_wrapped)
    local image = image_wrapped.id
    local val = lyte_core.image_get_height(image)
    local _ret_val = val
    return _ret_val
end
lyte.new_canvas = function(width, height)
    local val = lyte_core.image_new_canvas(width, height)
    local _ret_val = classnew(lyte.Image, val)
    return _ret_val
end
lyte.set_canvas = function(canvas_image_wrapped)
    local canvas_image = canvas_image_wrapped.id
    lyte_core.image_set_canvas(canvas_image)
end
lyte.is_image_canvas = function(image_wrapped)
    local image = image_wrapped.id
    local val = lyte_core.image_is_canvas(image)
    local _ret_val = val
    return _ret_val
end
lyte.cleanup_imagebatch = function(imagebatch_wrapped)
    local imagebatch = imagebatch_wrapped.id
    lyte_core.imagebatch_cleanup(imagebatch)
end
lyte.new_imagebatch = function(image_wrapped)
    local image = image_wrapped.id
    local val = lyte_core.imagebatch_new(image)
    local _ret_val = classnew(lyte.ImageBatch, val)
    return _ret_val
end
lyte.reset_imagebatch = function(imagebatch_wrapped)
    local imagebatch = imagebatch_wrapped.id
    lyte_core.imagebatch_reset(imagebatch)
end
lyte.add_imagebatch_rect = function(imagebatch_wrapped, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height)
    local imagebatch = imagebatch_wrapped.id
    lyte_core.imagebatch_add_rect(imagebatch, dest_x, dest_y, dest_width, dest_height, src_x, src_y, src_width, src_height)
end
lyte.get_imagebatch_rect_count = function(imagebatch_wrapped)
    local imagebatch = imagebatch_wrapped.id
    local val = lyte_core.imagebatch_get_rect_count(imagebatch)
    local _ret_val = val
    return _ret_val
end
lyte.draw_imagebatch = function(imagebatch_wrapped)
    local imagebatch = imagebatch_wrapped.id
    lyte_core.imagebatch_draw(imagebatch)
end
lyte.cleanup_font = function(font_wrapped)
    local font = font_wrapped.id
    lyte_core.font_cleanup(font)
end
lyte.load_font = function(font_path, size)
    local val = lyte_core.font_load(font_path, size)
    local _ret_val = classnew(lyte.Font, val)
    return _ret_val
end
lyte.set_font = function(font_wrapped)
    local font = font_wrapped.id
    lyte_core.font_set(font)
end
lyte.cleanup_music = function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_cleanup(music)
end
lyte.load_music = function(music_path)
    local val = lyte_core.music_load(music_path)
    local _ret_val = classnew(lyte.Music, val)
    return _ret_val
end
lyte.play_music = function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_play(music)
end
lyte.pause_music = function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_pause(music)
end
lyte.resume_music = function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_resume(music)
end
lyte.stop_music = function(music_wrapped)
    local music = music_wrapped.id
    lyte_core.music_resume(music)
end
lyte.is_music_playing = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_is_playing(music)
    local _ret_val = val
    return _ret_val
end
lyte.get_music_length = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_get_length(music)
    local _ret_val = val
    return _ret_val
end
lyte.get_music_length_played = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_get_length_played(music)
    local _ret_val = val
    return _ret_val
end
lyte.seek_music = function(music_wrapped, secs)
    local music = music_wrapped.id
    lyte_core.music_seek(music, secs)
end
lyte.set_music_volume = function(music_wrapped, volume)
    local music = music_wrapped.id
    lyte_core.music_set_volume(music, volume)
end
lyte.set_music_pan = function(music_wrapped, pan)
    local music = music_wrapped.id
    lyte_core.music_set_pan(music, pan)
end
lyte.set_music_pitch = function(music_wrapped, pitch)
    local music = music_wrapped.id
    lyte_core.music_set_pitch(music, pitch)
end
lyte.get_music_volume = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_get_volume(music)
    local _ret_val = val
    return _ret_val
end
lyte.get_music_pan = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_get_pan(music)
    local _ret_val = val
    return _ret_val
end
lyte.get_music_pitch = function(music_wrapped)
    local music = music_wrapped.id
    local val = lyte_core.music_get_pitch(music)
    local _ret_val = val
    return _ret_val
end
lyte.cleanup_sound = function(sound_wrapped)
    local sound = sound_wrapped.id
    lyte_core.sound_cleanup(sound)
end
lyte.load_sound = function(sound_path)
    local val = lyte_core.sound_load(sound_path)
    local _ret_val = classnew(lyte.Sound, val)
    return _ret_val
end
lyte.clone_sound = function(orig_wrapped)
    local orig = orig_wrapped.id
    local val = lyte_core.sound_clone(orig)
    local _ret_val = classnew(lyte.Sound, val)
    return _ret_val
end
lyte.play_sound = function(sound_wrapped)
    local sound = sound_wrapped.id
    lyte_core.sound_play(sound)
end
lyte.pause_sound = function(sound_wrapped)
    local sound = sound_wrapped.id
    lyte_core.sound_pause(sound)
end
lyte.resume_sound = function(sound_wrapped)
    local sound = sound_wrapped.id
    lyte_core.sound_resume(sound)
end
lyte.stop_sound = function(sound_wrapped)
    local sound = sound_wrapped.id
    lyte_core.sound_stop(sound)
end
lyte.is_sound_playing = function(sound_wrapped)
    local sound = sound_wrapped.id
    local val = lyte_core.sound_is_playing(sound)
    local _ret_val = val
    return _ret_val
end
lyte.set_sound_volume = function(sound_wrapped, volume)
    local sound = sound_wrapped.id
    lyte_core.sound_set_volume(sound, volume)
end
lyte.set_sound_pan = function(sound_wrapped, pan)
    local sound = sound_wrapped.id
    lyte_core.sound_set_pan(sound, pan)
end
lyte.set_sound_pitch = function(sound_wrapped, pitch)
    local sound = sound_wrapped.id
    lyte_core.sound_set_pitch(sound, pitch)
end
lyte.get_sound_volume = function(sound_wrapped)
    local sound = sound_wrapped.id
    local val = lyte_core.sound_get_volume(sound)
    local _ret_val = val
    return _ret_val
end
lyte.get_sound_pan = function(sound_wrapped)
    local sound = sound_wrapped.id
    local val = lyte_core.sound_get_pan(sound)
    local _ret_val = val
    return _ret_val
end
lyte.get_sound_pitch = function(sound_wrapped)
    local sound = sound_wrapped.id
    local val = lyte_core.sound_get_pitch(sound)
    local _ret_val = val
    return _ret_val
end
lyte.cleanup_shaderbuilder = function(shaderbuilder_wrapped)
    local shaderbuilder = shaderbuilder_wrapped.id
    lyte_core.shaderbuilder_cleanup(shaderbuilder)
end
lyte.new_shaderbuilder = function()
    local val = lyte_core.shaderbuilder_new()
    local _ret_val = classnew(lyte.ShaderBuilder, val)
    return _ret_val
end
lyte.shaderbuilder_uniform = function(shaderbuilder_wrapped, uniform_name, uniform_type)
    local shaderbuilder = shaderbuilder_wrapped.id
    lyte_core.shaderbuilder_uniform(shaderbuilder, uniform_name, uniform_type)
end
lyte.shaderbuilder_vertex = function(shaderbuilder_wrapped, vertex_code)
    local shaderbuilder = shaderbuilder_wrapped.id
    lyte_core.shaderbuilder_vertex(shaderbuilder, vertex_code)
end
lyte.shaderbuilder_fragment = function(shaderbuilder_wrapped, fragment_code)
    local shaderbuilder = shaderbuilder_wrapped.id
    lyte_core.shaderbuilder_fragment(shaderbuilder, fragment_code)
end
lyte.shaderbuilder_build = function(shaderbuilder_wrapped)
    local shaderbuilder = shaderbuilder_wrapped.id
    local shader = lyte_core.shaderbuilder_build(shaderbuilder)
    local _ret_val = classnew(lyte.Shader, shader)
    return _ret_val
end
lyte.cleanup_shader = function(shader_wrapped)
    local shader = shader_wrapped.id
    lyte_core.shader_cleanup(shader)
end
lyte.set_shader = function(shader_wrapped)
    local shader = shader_wrapped.id
    lyte_core.shader_set(shader)
end
lyte.reset_shader_uniform = function(shader_wrapped, uniform_name)
    local shader = shader_wrapped.id
    lyte_core.shader_reset_uniform(shader, uniform_name)
end

-- manually handled functions in current namespace
lyte.reset_font = function()
    lyte.set_font(lyte._default_font) -- lyte._default_font set in lyte_boot
end
lyte.new_shader = function(def)
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
lyte.set_shader_uniform = function (shader, uniform_name, uniform_value)
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

-- unhandled functions in current namespace
-- tick [implementation: user]


