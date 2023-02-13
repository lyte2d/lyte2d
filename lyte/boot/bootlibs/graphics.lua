--[[ (c) mg ]]

local default_font = lyte.load_font("/bootassets/monogram-extended.ttf", 24)

function lyte.reset_font()
    lyte.set_font(default_font)
end

lyte.reset_font(default_font)



function lyte.draw_circle(xc, yc, r)
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
    lyte.draw_lines(lines)
end

function lyte.draw_circle_filled(xc, yc, r)
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


    lyte.draw_triangles_filled(triangles);
end


