-- lyte sample

-- load an image
local image_1 = lyte.load_image("assets/hero.png")


function lyte.tick(dt, width, height)
    -- background color
    lyte.cls(0, 0, 0, 1)

    -- foreground color for the rectangles, red with alpha
    lyte.set_color(1, 0, 0, 0.3)

    -- draw 4 filled overlapping rectangles
    for i=1,4 do
        local x = i * width/7
        local y = i * height/7
        lyte.draw_rect(x, y, width/3, height/3)
    end

    -- foreground color for the circles, green with alpha
    lyte.set_color(0, 1, 0, 0.3)
    -- draw 4 filled overlapping circles
    for i=1,4 do
        local x = width - ((i+1) * width/7)
        local y = i * height/7
        lyte.draw_circle(x, y, (width+height)/6)
    end


    lyte.set_color(1,1,0,1)

    lyte.draw_circle_line(width/2, height/2, (width+height)/4);

    lyte.reset_color() -- sets color to: (1, 1, 1, 1)
    -- draw the text on the top
    lyte.draw_text("Hello, Lyte2D", 4, 4)

    -- draw the image
    lyte.draw_image(image_1, 10, 50)

    -- draw the image, scaled
    lyte.push_matrix()
    lyte.scale(2, 2)

    -- full image
    lyte.draw_image(image_1, 10, 70)
    -- a portion of the image (sprite's ticks are 16x16. draw #3)
    lyte.draw_image_rect(image_1, 10, 90, 16*(3-1), 0, 16, 16)

    -- 0.7.4: new drawing primitives
    lyte.draw_line(10,10,100,100)
    lyte.draw_point(102,102)

    lyte.draw_triangle_line(150,50,154,100, 220,100)
    lyte.draw_triangle(150,150,154,200, 220,200)

    lyte.draw_ellipse(250, 50, 30, 10)
    lyte.draw_ellipse_line(220, 50, 30, 10)
    lyte.draw_ellipse(250, 150, 10, 40)
    lyte.draw_ellipse_line(220, 150, 6, 30)

    lyte.pop_matrix()
end


