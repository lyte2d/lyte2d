
local lyte = require("lyte")


function test_this()
    local x = 100/0
    local img = lyte.load_image("test.png")
    print(" :) stop here")
    return img
end

function lyte.tick(dt, _w, _h)
    if lyte.is_key_down("q") then test_this() end
    lyte.draw_text("mmm", 10, 20)
end

