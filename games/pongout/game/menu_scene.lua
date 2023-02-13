--[[ (c) mg ]]

local M = {}

local menu_state = {
    alpha = 0.0,
}

local tweens = {}

local menu_items = {
    { id = "c", title = "Continue Game" },
    { id = "n", title = "New Game" },
    -- { id = "s", title = "Settings" },
    { id = "q", title = "Quit" },
}

local active_item = 1



function M.init()
    menu_state.alpha = 0.0
    lyte.set_font(Assets.font1)
    tweens.goin = lyte.tween.new(2.0, menu_state, { alpha = 1.0 }, 'inOutQuad')
    tweens.demo_starter = nil
    active_item = 1
end

function M.update(dt)
    local _goin_done = tweens.goin:update(dt)
    if tweens.demo_starter then
    end

    if tweens.goout then
        local goout_done = tweens.goout:update(dt)
        if goout_done then
            M.init()
            tweens.goout = nil
            active_item = 1
            set_scene("play")
        end
    end

    if lyte.is_keypressed("space") or lyte.is_keypressed("enter") or lyte.is_gamepadpressed(0, "but_a") then
        tweens.demo_starter = nil
        if menu_items[active_item].id == "c" then
            tweens.goin:set(10.0)
            tweens.goout = lyte.tween.new(0.3, menu_state, { alpha = 0.0 }, 'outQuad')
        elseif menu_items[active_item].id == "n" then
            State.left_points = 0
            State.right_points = 0

            -- this one's hacky
            State.num_brickrows = 4
            State.num_briccols = 1
            State.brick_dx = 6
            State.brick_dy = 10
            State.brick_w = 4
            State.brick_h = math.floor((CH - 2 * State.brick_dy) / (State.num_brickrows)) - State.brick_dy
            init_bricks()

            State.lvl_points = 0
            tweens.goin:set(10.0)
            tweens.goout = lyte.tween.new(0.3, menu_state, { alpha = 0.0 }, 'outQuad')
        elseif menu_items[active_item].id == "q" then
            quit()
        end
    end

    if lyte.is_keypressed("up") or lyte.is_keypressed("w") or lyte.is_gamepadpressed(0, "but_dpad_up") then
        tweens.demo_starter = nil
        active_item = active_item - 1
    end
    if lyte.is_keypressed("down") or lyte.is_keypressed("s") or lyte.is_gamepadpressed(0, "but_dpad_down") then
        tweens.demo_starter = nil
        active_item = active_item + 1
    end

    local first = 2
    if State.paused  then
        first = 1
    end

    if active_item < first then active_item = first end
    if active_item > #menu_items then active_item = #menu_items end

end

function M.draw()
    lyte.push_matrix()
    lyte.translate(CW / 2, 50)
    lyte.scale(3, 3)

    lyte.set_color(1, 0.5, 0.5, menu_state.alpha)
    draw_text_centered("PONG    !", 0, 0)
    draw_text_centered("PONG    !", 0, 0)
    draw_text_centered("PONG    !", 0, 0)

    lyte.set_color(0.5, 1, 1, menu_state.alpha)
    draw_text_centered("     OUT!", 0, 0)
    draw_text_centered("     OUT!", 0, 0)
    draw_text_centered("     OUT!", 0, 0)

    local start = 2
    if State.paused then
        start = 1
    end

    lyte.pop_matrix()
    for i = start, #menu_items do
        local mi = menu_items[i]
        if i == active_item then
            lyte.set_color(1, 1, 0, 1)
        else
            lyte.set_color(0.7, 0.7, 0.7, 1)
        end
        lyte.draw_text(mi.title, CW / 2 - 50, (70 + i * 20))
        lyte.draw_text(mi.title, CW / 2 - 50, (70 + i * 20))
        lyte.draw_text(mi.title, CW / 2 - 50, (70 + i * 20))
    end
end

return M
