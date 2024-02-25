-- simple physics world
local world = lyte.new_world()

-- colliders are stored in these tables
local circles = {}
local rects = {}

-- create some random circle colliders
for i=1,45 do
    local x = math.random(0, 800)
    local y = math.random(0, 600)
    local r = math.random(10,30)
    circles[i] = world:new_circle_collider(r, x, y, 0);
    circles[i].hit = false
end

-- create some random rectangle colliders
for i=1,45 do
    local x = math.random(0, 800)
    local y = math.random(0, 600)
    local w = math.random(15,25)
    local h = math.random(25,40)
    local rot = math.random()*math.pi*2
    rects[i] = world:new_rect_collider(w, h, x, y, rot)
    rects[i].hit = false
end


local function refresh_objects(dt)
    for i=1,#circles do
        circles[i]:refresh()
        circles[i].hit = false
        if(circles[i]:get_collision_count() > 0) then circles[i].hit = true end
    end
    for i=1,#rects do
        rects[i]:refresh()
        rects[i].hit = false
        if(rects[i]:get_collision_count() > 0) then rects[i].hit = true end
    end
end

refresh_objects(0) -- initial coords

function lyte.tick(dt)
    world:update(dt)

    lyte.cls(0.2,0.2,0.2,1)

    for i=1,#circles do
        local c = circles[i]
        lyte.set_color(0.8,0.8,0.8,1)
        lyte.draw_circle_line(c.x, c.y, c.radius)
        if c.hit then
            lyte.set_color(0.8,0.4,0.0,0.3)
            lyte.draw_circle(c.x, c.y, c.radius)
        end
    end

    for i=1,#rects do
        local r = rects[i]
        lyte.push_matrix()
        lyte.translate(r.x, r.y)
        lyte.rotate(r.angle)
        lyte.translate(-r.width/2, -r.height/2)
        lyte.set_color(0.8,0.8,0.8,1)
        lyte.draw_rect_line(0, 0, r.width, r.height)
        if r.hit then
            lyte.set_color(0.8,0.4,0.0,0.3)
            lyte.draw_rect(0, 0, r.width, r.height)
        end
        lyte.pop_matrix();
    end

    lyte.set_color(0.8,0.8,0.8,1)
    lyte.draw_text("HELLO!", 10, 10);
    refresh_objects(dt)
end
