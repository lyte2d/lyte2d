local img
-- local img2
-- local cvs = lyte.new_canvas(300,300)


-- lyte.cls(0.2,0,0.2,0)
-- lyte.set_canvas(cvs)
-- lyte.cls(0.2,0,0.2,1)
-- lyte.set_color(0,1,0,1)
-- lyte.draw_circle(150,150,100)
-- lyte.reset_color()
-- img2 = lyte_core.capture_image(0,0,300,300)
-- lyte.reset_canvas()

-- lyte.set_window_margins(32,32,32,32)
-- lyte.set_window_paddings(100,0,0,0)

lyte.set_window_size(1000,800)

function lyte.tick(dt, w, h)
    lyte.cls(0,0,0,1)
    local mx, my
    mx = lyte.get_mouse_x()
    my = lyte.get_mouse_y()
    lyte.draw_text("let's capture the screen bro: " .. math.random(10, 100000), 10, 10)
    lyte.draw_text("W " .. w .. "," .. h .." M " .. mx .. "," .. my, 10, h-40)
    if lyte.is_key_pressed("space") or lyte.is_key_down("down") then
        if img then
            lyte_core.image_cleanup(img)
            img = nil
        end
        img = lyte_core.capture_image(0,0,500,400)

    end
    if img then
        lyte_core.image_draw(img, 10, 100)
    end

    lyte.draw_rect_line(0,0,520,130)
    -- lyte.draw_image(cvs, 400,200)
    lyte.draw_rect(340,300, 32, 32)

    -- if img2 then
    --     lyte_core.image_draw(img2, 300, 300)
    -- end

end