local W, H = 540, 630
local SC = 5
local I = lyte.load_image("assets/hero.png")
local C = lyte.new_canvas(W, H)

lyte.set_window_size(W, H)

lyte.set_default_blendmode("none")

function lyte.tick(dt) 
    lyte.set_canvas(C)

    lyte.push_matrix()
    lyte.cls(0, 1, 0, 1)
    lyte.scale(SC, SC)
   
    -- with default blendmode
    lyte.draw_image(I, 10, 10)

    lyte.set_blendmode("add")
    lyte.draw_image(I, 10, 40)
    lyte.reset_blendmode()

    lyte.set_blendmode("mod")
    lyte.draw_image(I, 10, 60)
    lyte.reset_blendmode()
    
    lyte.set_blendmode("mul")
    lyte.draw_image(I, 10, 80)
    lyte.reset_blendmode()
    
    lyte.set_blendmode("blend")
    lyte.draw_image(I, 10, 100)
    lyte.reset_blendmode()

    lyte.pop_matrix()
    lyte.reset_canvas()
    lyte.draw_image(C, 0, 0)
    
end


