-- key input and last pressed keys

local last = ""

function lyte.tick()
    local keys = lyte.get_pressed_keys()
    if #keys > 0 then
        last = ""
        for i,v in ipairs(keys) do
            last = last .. v .. " "
        end
    end
    lyte.cls(0,0,0,0)
    lyte.draw_text("Last set of pressed keys: " .. last, 10, 10)
end