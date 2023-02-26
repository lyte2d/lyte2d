-- lyte sample

-- sound fx: data files
-- these contain the data, but can't be played on their own
local sfx_hurt_data = lyte.load_sounddata("assets/sfx_hurt.wav")
local sfx_shoot_data = lyte.load_sounddata("assets/sfx_shoot.ogg")

-- sound fx: playable instances
-- 3 'hurt' instances
local sfx_hurt_1 = lyte.new_sound(sfx_hurt_data)
local sfx_hurt_2 = lyte.new_sound(sfx_hurt_data)
local sfx_hurt_3 = lyte.new_sound(sfx_hurt_data)
-- 2 'shoot' instances
local sfx_shoot_1 = lyte.new_sound(sfx_shoot_data)
local sfx_shoot_2 = lyte.new_sound(sfx_shoot_data)

-- pans on both sides and middle
sfx_hurt_1.pan = 1.0
sfx_hurt_2.pan = 0.5
sfx_hurt_3.pan = 0.0
-- pans on both sides
sfx_shoot_1.pan = 1.0
sfx_shoot_2.pan = 0.0

function lyte.tick(dt, width, height)
    -- UPDATE

    -- lmb/rmb for shooting sounds
    if lyte.is_mouse_pressed("mb1") then
        sfx_shoot_1:play()
    end
    if lyte.is_mouse_pressed("mb2") then
        sfx_shoot_2:play()
    end
    -- keys 1/2/3 for hurting sounds
    if lyte.is_key_pressed("1") then
        sfx_hurt_1:play()
    end
    if lyte.is_key_pressed("2") then
        sfx_hurt_2:play()
    end
    if lyte.is_key_pressed("3") then
        sfx_hurt_3:play()
    end

    -- DRAW
    lyte.cls(0.0, 0.15, 0.05, 1)
    lyte.draw_text("Sounds FX", 10, 10)
    lyte.draw_text("LMB/RMB for 'shooting'", 10, 60)
    lyte.draw_text("1/2/3 for 'hurting'", 10, 80)

    lyte.set_color(1, 1, 0, 1)
    lyte.draw_text("(on browser, sounds can be delayed)", 5, 120)
end
