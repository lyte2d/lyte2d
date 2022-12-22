-- basic animation

local hero_img = load_image("hero.png")

local frame_time = 0
local frame_idx = 1

function frame(dt)
    frame_time = frame_time + dt
    if (frame_time > 0.5) then
        frame_time = 0
        frame_idx = frame_idx % 5 + 1
    end
    clear(0,0,0,1)
    push_matrix()
    scale(4,4)
    draw_imagerect(hero_img, 10, 10, (frame_idx-1)*16, 0, 16, 16)
    pop_matrix()
end