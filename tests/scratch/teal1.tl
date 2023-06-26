local record Config
    width: number
    height: number
end

local cfg: Config = { width = 1400, height = 900 }

lyte.set_window_size(cfg.width, cfg.height)

local N:number = 1300
local p = lyte.load_image("assets/char01.png")
local ps = {}

for i = 1, 1300 do
    ps[i] = lyte.load_image("assets/char01.png")
end


function lyte.tick(dt: number)

    lyte.scale(3,3)
    for i=1,N do

        lyte.draw_image(ps[i], 2*i, 100)
        -- bug reported by user
        -- workarounds
        -- lyte.draw_image_rect(ps[i], 2*i, 100, 0, 0,200, 100)
        -- lyte.draw_image(p, 2*i, 100)
    end
end
