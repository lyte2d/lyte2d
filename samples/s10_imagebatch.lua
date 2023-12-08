-- lyte.ImageBatch sample

local img = lyte.load_image("assets/batch.png")

local batch = lyte.new_imagebatch(img);

local N = 100

local function add_items()
    for i=1,N do
        local x = math.random(10, 600) -- location of the destination rectangle
        local y = math.random(10, 400)
        local sz = math.random(8,128) -- size of the destination rectangle
        local r = math.random(1,4) -- one of the 4 sprites will be added
        if r == 1 then
            -- dest_x, y, width, height,  source_x, y, width, height
            batch:add_rect(x, y, sz, sz, 0, 0, 32, 32 )
        elseif r == 2 then
            batch:add_rect(x, y, sz, sz, 32, 0, 32, 32 )
        elseif r == 3 then
            batch:add_rect(x, y, sz, sz, 0, 32, 32, 32 )
        else
            batch:add_rect(x, y, sz, sz, 32, 32, 32, 32 )
        end

    end
end

add_items()

function lyte.tick()
    lyte.cls(0,0,0,1)
    if lyte.is_key_down("enter") or lyte.is_mouse_down("mb1") then
        batch:reset()
        add_items()
    end
    batch:draw()
end