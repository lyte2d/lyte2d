
local world = lyte_core.world_new()
local space = lyte_core.space_new()
local jg = lyte_core.jointgroup_new()

-- lyte_core.world_set_gravity(world, 0, 10)

lyte.set_window_minsize(1024,1024)

function update_phys(dt)
    lyte_core.world_update(world, dt)
    lyte_core.coll_update_correct(space)
    lyte_core.coll_update_check(world, space, jg);
end


function make_circle(x, y, rad)
    local obj = {x=x,y=y,rad=rad}
    obj.body = lyte_core.body_new(world)
    obj.geom = lyte_core.geom_new_circle(space, rad)
    lyte_core.geom_set_body(obj.geom, obj.body)
    lyte_core.body_set_position(obj.body, x, y)
    return obj
end



function make_rect(x, y, w, h)
    local obj = {x=x,y=y,w=w,h=h,rot=0}
    obj.body = lyte_core.body_new(world)
    obj.geom = lyte_core.geom_new_rect(space, w, h)
    lyte_core.geom_set_body(obj.geom, obj.body)
    lyte_core.body_set_position(obj.body, x, y)
    return obj
end



local circles = {}
local rects = {}

for i=1,40 do
    local x = math.random(0, 800)
    local y = math.random(0, 600)
    local r = math.random(15,40)
    circles[i] = make_circle(x, y, r)
end

for i=1,25 do
    local x = math.random(0, 800)
    local y = math.random(0, 600)
    local w = math.random(15,30)
    local h = math.random(25,60)
    rects[i] = make_rect(x, y, w, h);
end

function lyte.tick(dt)
    lyte.cls(0,0,0,1)
    update_phys(dt)
    for i=1,#circles do
        circles[i].x, circles[i].y = lyte_core.body_get_position(circles[i].body)
        lyte.draw_circle(circles[i].x, circles[i].y, circles[i].rad)
    end
    for i=1,#rects do
        local r = rects[i]
        r.x, r.y = lyte_core.body_get_position(r.body)
        r.rot = lyte_core.body_get_rotation(r.body)
        lyte.push_matrix()
        lyte.translate(r.x, r.y)
        -- lyte.rotate(r.rot+math.pi/2)
        lyte.rotate(r.rot)

        lyte.draw_rect(-r.w/2, -r.h/2, r.w, r.h)
        lyte.pop_matrix();
    end
end

