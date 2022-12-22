--[[ (c) mg ]]

local default_font = load_font("/bootassets/monogram-extended.ttf", 24)

function lyte.reset_font()
    set_font(default_font)
end

lyte.reset_font(default_font)


function lyte.draw_circle(xc, yc, r)
    local segments = math.max(4, (2*r/3))
    local ang = 2*math.pi/segments
    local points = {}
    local lines = {}
    local angle = 0
    -- local p = {}
    for i=1, segments+2 do
        local x = xc + r/2 * math.sin(angle)
        local y = yc - r/2 * math.cos(angle);
        angle = angle + ang
        points[i] = {x=x,y=y}
    end

    for i=1, segments+1 do
        lines[i] = {
            x1 = points[i].x,
            y1 = points[i].y,
            x2 = points[i+1].x,
            y2 = points[i+1].y,
        }
    end
    draw_lines(lines)
end

function lyte.draw_circle_filled(xc, yc, r)
    local segments = math.max(4, (2*r/3))
    local ang = 2*math.pi/segments
    local points = {}
    local triangles = {}
    local angle = 0
    -- local p = {}
    for i=1, segments+2 do
        local x = xc + r/2 * math.sin(angle)
        local y = yc - r/2 * math.cos(angle);
        angle = angle + ang
        points[i] = {x=x,y=y}
    end

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

    draw_triangles_filled(triangles);
end


