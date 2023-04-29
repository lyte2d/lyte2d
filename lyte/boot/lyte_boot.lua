--[[ (c) mg ]]

lyte = lyte or {}

table.unpack = table.unpack or unpack
unpack = unpack or table.unpack

local default_font = lyte.load_font("/bootassets/monogram-extended.ttf", 24)

function lyte.reset_font()
    lyte.set_font(default_font)
end

lyte.reset_font(default_font)

lyte.set_window_icon("bootassets/icon.png")

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

lyte.tick = function()
    lyte.cls(0.1,0.1,0.1,0)
    lyte.set_color(0.8,0.8,0.8,1)
    local w = lyte.get_text_width("GURU MEDITATION")
    local h = lyte.get_text_height("GURU MEDITATION")
    lyte.draw_text("GURU MEDITATION", 7, 10)
    local w2 = lyte.get_text_width("Couldn't find 'lyte.tick' function")
    local h2 = lyte.get_text_height("Couldn't find 'lyte.tick' function")
    lyte.draw_text("Couldn't find 'lyte.tick' function", 7, 32)
    lyte.set_color(0.9,0,0,1)
    lyte.draw_rect_line(4,12, math.max(w, w2) + 6, h2 + 30)
end
