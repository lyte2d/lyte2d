-- lyte sample

local total_time = 0

-- music
local music_1 = lyte.load_music("assets/elev.mp3")

-- start playing right away
music_1:play()

function lyte.tick(dt, width, height)
    -- UPDATE
    total_time = total_time + dt

    -- up/down keys to change the pitch
    if lyte.is_key_pressed("up") or lyte.is_mouse_pressed("scrollup") then
        music_1.pitch = (music_1.pitch + 0.01)
    elseif lyte.is_key_pressed("down") or lyte.is_mouse_pressed("scrolldown")then
        music_1.pitch = (music_1.pitch - 0.01)
    end
    -- left/right keys to change the pan
    if lyte.is_key_pressed("left") then
        music_1.pan = math.min(music_1.pan + 0.1, 1)
    elseif lyte.is_key_pressed("right") then
        music_1.pan = math.max(music_1.pan - 0.1, 0)
    end
    -- rmb start/pause music
    if lyte.is_mouse_pressed("mb2") then
        if music_1.playing then
            music_1:pause()
        else
            music_1:play()
        end
    end

    -- DRAW
    lyte.cls(0.0, 0.1, 0.2, 1)
    lyte.draw_text(("played: %1.2f/%3.1f secs"):format(music_1.length_played, music_1.length), 10, 10)
    lyte.draw_text(("pitch: %1.2f, pan: %1.2f "):format(music_1.pitch, music_1.pan), 10, 30)
    lyte.set_color(1,1,0.2,1)
    lyte.draw_text("(browser? LMB to enable sound)", 10, height/2-20)
    lyte.reset_color()
    lyte.draw_text("RMB to start/pause music", 10, height/2)
    -- background with a "pulsating" alpha
    lyte.set_color(0.8,0.9,0.8, math.abs(math.sin(total_time/2))+0.3)
    lyte.draw_text("Up/Down: change pitch", 10, height-40-20)
    lyte.set_color(0.9,0.8,0.8, math.abs(math.cos(total_time/2))+0.3)
    lyte.draw_text("Left/Right: change pan", 10, height-40)
end
