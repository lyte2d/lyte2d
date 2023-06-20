lyte.set_window_size(1400,900)

local N = 1300
local p = lyte.load_image("assets/char01.png")
local ps = {}

for i=1,N do
    ps[i] = lyte.load_image("assets/char01.png")
end


function lyte.tick(dt)

    lyte.scale(3,3)
    for i=1,N do

        lyte.draw_image(ps[i], 2*i, 100)
        -- bug reported by user
        -- workarounds
        -- lyte.draw_image_rect(ps[i], 2*i, 100, 0, 0,200, 100)
        -- lyte.draw_image(p, 2*i, 100)
    end
end
