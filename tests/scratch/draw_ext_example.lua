local W, H = 400, 280 -- canvas size
local SC = 3 -- canvas scale
local C = lyte.new_canvas(W, H)
local T = 0 -- count seconds since the app opened
local S = 10 -- speed of the sprite

-- image, number of frames, width, height, x, y
local I = lyte.load_image("assets/hero.png")    
local NF = 5 -- 5 frames in this spritesheet image
local IW, IH = I.width/NF, I.height
local IX, IY = 0, H/2 --  position


lyte.set_window_size(W*SC, H*SC)


-- lots of arguments on this one:
-- img -> Image
-- scr_x, scr_y -> where on screen we want to draw
-- rect_x, rect_y, rect_w, rect_h  -> the rectangle from the image we want to draw
-- rotation radians, rot_at_x, rot_at_y --> rotation 
-- there are defaults after argument scr_y
function draw_image_rect_ext(
        img, 
        scr_x, scr_y, 
        rect_x, rect_y, rect_w, rect_h,
        rotation, rot_at_x, rot_at_y
    )
    -- defaults
    rect_x = rect_x or 0
    rect_y = rect_y or 0
    rect_w = rect_w or img.width
    rect_h = rect_h or img.height
    rotation = rotation or 0
    rot_at_x = rot_at_x or rect_w / 2
    rot_at_y = rot_at_y or rect_h / 2
    -- code
    lyte.push_matrix()
    lyte.translate(scr_x, scr_y)
    lyte.rotate_at(rotation, rot_at_x, rot_at_y)
    lyte.draw_image_rect(img, 0, 0, rect_x, rect_y, rect_w, rect_h)
    lyte.pop_matrix()
end

function draw_image_ext(img, x, y, rotation, rot_at_x, rot_at_y)
    draw_image_rect_ext(img, x, y, 0, 0, img.width, img.height, rotation, rot_at_x, rot_at_y)
    ---- or use the direct method:
    -- lyte.push_matrix()
    -- lyte.translate(x, y)
    -- lyte.rotate_at(rotation, rot_at_x, rot_at_y)
    -- lyte.draw_image(img, 0, 0)
    -- lyte.pop_matrix()
end


function lyte.tick(dt, w, h)
    T = T + dt
    IX = IX + S * dt
    lyte.set_canvas(C)
    lyte.cls(0, 1, 0, 1)

    local frame = 1
    local angle =  T -- rotate over time
    -- local angle = 30 * 2*math.pi/360 -- 30 degrees
    draw_image_rect_ext(I, IX, IY, IW*frame, 0, IW, IH, -angle, IW/(2), IH/2)

    ---
    lyte.reset_canvas()
    lyte.scale(SC, SC)
    lyte.draw_image(C, 0, 0)
end


