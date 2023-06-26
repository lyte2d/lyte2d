lyte.set_window_size(1400,900)

-- error case 1
error"heh"

function lyte.tick(dt)
    -- error case 2
    error("AAAAAAAAAAAAAHAHHAHAHAHAHAHHAHAHHA")
    -- error case 3
    lyte.draw_text(1)

    -- success case
    lyte.draw_text("test",0,0)
end
