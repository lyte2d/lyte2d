-- lyte sample

local total_time = 0

-- create a canvas
local canvas_1 = lyte.new_canvas(220,220)
print(lyte.is_image_canvas(canvas_1))

-- helper function to randomly fill the canvas
local function fill_canvas_random()
    lyte.set_canvas(canvas_1)
    lyte.cls(0, 0, 0, 1)
    for i=1,1000 do
        lyte.set_color(math.random(), math.random(), math.random(), math.random())
        lyte.draw_rect(math.random(1,220), math.random(1,220), math.random(5,100), math.random(5,100))
    end
    lyte.set_color(1,1,0,1)
    lyte.draw_text("HELLO HAHA", 10, 10)
    lyte.reset_canvas()
end

-- helper function to cls the canvas
local function cls_canvas()
    lyte.set_canvas(canvas_1)
    lyte.cls(0, 0, 0, 1)
    lyte.reset_canvas()
end

-- setup the initial canvas drawing
cls_canvas()
fill_canvas_random()

function lyte.tick(dt, width, height)
    -- UPDATE
    total_time = total_time + dt

    if lyte.is_mouse_pressed("mb1") then
        fill_canvas_random()
    end
    if lyte.is_mouse_pressed("mb2") then
        cls_canvas()
    end

    -- DRAW
    lyte.cls(0.2, 0.05, 0.2, 1)
    lyte.push_matrix()
    -- draw canvas' image, rotating in te middle
    lyte.rotate_at(total_time, width/2, height/2)

    -- draw the current image. note: when canvas is GC'd, image goes with it
    -- so make sure to keep a reference to canvas itself, even if you won't update it
    lyte.draw_image(canvas_1, width/2 - canvas_1.width/2, height/2 - canvas_1.height/2)

    lyte.pop_matrix()

    lyte.reset_color()
    lyte.draw_text("LMB to re-generate canvas image", 10, height-40-20)
    lyte.draw_text("RMB to cls canvas image", 10, height-40)
end
