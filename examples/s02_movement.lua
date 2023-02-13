-- lyte sample

local total_time = 0
local SCALE = 3

-- image_1
local image_1 = lyte.load_image("assets/hero.png")
local sprite_1_frame = 2
local sprite_1_numframes = 5


function lyte.frame(dt, width, height)
    -- UPDATE

    -- dt is the time (in seconds) from last frame to now
    -- keep track of total time
    total_time = total_time + dt

    -- control the sprite frame draw with space or left mouse button
    if lyte.is_keypressed("space") or lyte.is_mousepressed("m_1") then
        sprite_1_frame = (sprite_1_frame + 1) % sprite_1_numframes
    end

    -- scaled down width/height
    local W = width/SCALE
    local H = height/SCALE

    -- x position will change based on time
    local x_pos = W/2-16/2 + math.sin(total_time)*W/3 
    -- y position middle of the screen (even when window is resized)
    local y_pos = H/2-16/2
     
    -- DRAW
    lyte.clear(0.2, 0.1, 0.1, 1)
    lyte.push_matrix()
    lyte.scale(SCALE, SCALE)

    lyte.draw_imagerect(image_1, x_pos, y_pos, 16*(sprite_1_frame), 0, 16, 16)

    lyte.pop_matrix()
   
    -- background with a "pulsating" alpha
    lyte.set_color(1,1,1, math.abs(math.sin(total_time/2)))
    
    lyte.draw_text("SPACE or LMB: change sprite frame", 10, height-40)

end
