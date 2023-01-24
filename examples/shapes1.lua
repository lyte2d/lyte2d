local W = 0
local H = 0
local str = "Shapes! #1"

local function my_print(str, x, y, center)
    if center then
        local w, h = lyte.measure_text(str)
        x = x - w / 2
        y = y - h / 2
    end
    lyte.draw_text(str, x, y)
end

function lyte.frame(dt, W, H)

    lyte.clear(0, 0, 0, 1)

    -- circle
    lyte.set_color(0.4, 0.2, 0, 0.7)
    lyte.draw_circle_filled(W/2,H/2,510)

    -- rectangles
    lyte.set_color(1,0,0,0.5)
    lyte.draw_rect_filled(20, H/2-100, 200, 50)

    lyte.set_color(0,1,0,0.25)
    lyte.draw_rect_filled(20, H/2-100, 50, 150)

    -- random circles and lines
    math.randomseed(1)
    for i=1,20 do
        local x = math.random(0, W)
        local y = math.random(0, H)
        local s = math.random(10,50)
        local r = math.random()
        local g = math.random()
        local b = math.random()
        local a = math.random()*0.5 + 0.5
        lyte.set_color(r,g,b,a)
        lyte.draw_circle(x,y,s)
        lyte.draw_line(W/2, H/2, x, y)
    end

    -- centered text
    lyte.set_color(1, 1, 1, 1)
    my_print(str, W / 2, H / 2, true)

end

lyte.set_windowminsize(800, 500)

