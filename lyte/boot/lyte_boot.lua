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

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


function lyte.draw_circle_line(xc, yc, r)
    local segments = math.max(7, (2*r/math.pi))
    -- if segments%2 == 1 then segments = segments - 1 end -- even?
    local ang = 2*math.pi/segments
    local points = {}
    local lines = {}
    local angle = 0
    -- local p = {}
    for i=0, segments+1 do
        local x = xc + r/2 * math.sin(angle)
        local y = yc - r/2 * math.cos(angle);
        angle = angle + ang
        points[i+1] = {x=x,y=y}
    end

    points[#points].x = points[1].x
    points[#points].y = points[1].y

    for i=1, segments+1 do
        lines[i] = {
            x1 = points[i].x,
            y1 = points[i].y,
            x2 = points[i+1].x,
            y2 = points[i+1].y,
        }
    end
    lyte.draw_many_lines(lines)
end

function lyte.draw_circle(xc, yc, r)
    local segments = math.max(7, (2*r/math.pi))
    -- if segments%2 == 1 then segments = segments - 1 end -- even?
    local ang = 2*math.pi/segments
    local points = {}
    local triangles = {}
    local angle = 0
    -- local p = {}
    for i=0, segments+1 do
        local x = xc + r/2 * math.sin(angle)
        local y = yc - r/2 * math.cos(angle);
        angle = angle + ang
        points[i+1] = {x=x,y=y}
    end

    points[#points-1].x = points[1].x
    points[#points-1].y = points[1].y

    for i=1, segments+1 do
        triangles[i] = {
            x1 = xc,
            y1 = yc,
            x2 = points[i].x,
            y2 = points[i].y,
            x3 = points[i+1].x,
            y3 = points[i+1].y,
        }
    end


    lyte.draw_many_triangles(triangles);
end





---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------



----------------------------
-- Copy "direct" api over lyte
-- will remove. maybe.
-----------------------------
-- for k,v in pairs(_lyte_direct_api) do
--     lyte[k] = v
-- end

-- -- GLOBALS
-- for k,v in pairs(lyte) do
--     _G[k] = v
-- end

-- temporary tick (for repl)

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
