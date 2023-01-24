-- basic animation

local hero_img = lyte.Image("hero.png")

local frame_time = 0
local frame_idx = 1

function lyte.frame(dt)
    frame_time = frame_time + dt
    if (frame_time > 0.5) then
        frame_time = 0
        frame_idx = frame_idx % 5 + 1
    end
    lyte.clear(0,0,0,1)
    lyte.push_matrix()
    lyte.scale(4,4)
    lyte.draw_imagerect(hero_img, 10, 10, (frame_idx-1)*16, 0, 16, 16)
    lyte.pop_matrix()
end
