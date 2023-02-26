--[[ (c) mg ]]


local M = {}

local PaddleLeft = {}

local PaddleRight = {}

local Ball = {}

local Bricks = {}

local Walls = {}

local function rect_collision(rect1, rect2)
    local h = false
    local v = false
    local vv = 0.
    local vh = 0.
    if rect1.x < rect2.x + rect2.w and
        rect1.x + rect1.w > rect2.x then

        v = true
        vv = math.min((rect1.x + rect1.w - rect2.x), (rect2.x + rect2.w - rect1.x))
    end
    if rect1.y < rect2.y + rect2.h and
        rect1.h + rect1.y > rect2.y then

        h = true
        vh = math.min((rect1.y + rect1.h - rect2.y), (rect2.y + rect2.h - rect1.y))
    end

    return v and h, vh < vv, vh > vv
end


local function increase_difficulty()
    if (State.num_briccols < 5) then
        State.num_briccols = State.num_briccols + 1
    end
    if State.num_brickrows < 9 then
        if State.num_briccols % 3 == 1 then
            State.num_brickrows = State.num_brickrows + 2
        end
    end

    State.brick_h = math.floor((CH - 2 * State.brick_dy) / (State.num_brickrows)) - State.brick_dy
end


local function init_walls()
    Walls[1] = { x = 0, y = 0, w = WALL_THICK, h = CH, t = "l" }
    Walls[2] = { x = 0, y = 0, w = CW, h = WALL_THICK }
    Walls[3] = { x = CW - WALL_THICK, y = 0, w = WALL_THICK, h = CH, t = "r" }
    Walls[4] = { x = 0, y = CH - WALL_THICK, w = CW, h = WALL_THICK }
end

function init_bricks()
    local b = 1
    Bricks = {}
    for y = 1, State.num_brickrows do
        for x = 1, State.num_briccols do
            Bricks[b] = {
                active = true,
                x = (x - 1) * (State.brick_w + State.brick_dx) + CW / 2 - (State.num_briccols * (State.brick_w + State.brick_dx)) / 2,
                y = (y - 1) * (State.brick_h + State.brick_dy) + CH / 2 - (State.num_brickrows * (State.brick_h + State.brick_dy)) / 2,
                w = State.brick_w,
                h = State.brick_h,
                r = 1, g = 1, b = 1,
            }
            -- -- middle "hole"
            if y > State.num_brickrows/2 - 1 and y <= State.num_brickrows/2 + 1 then
                Bricks[b].active = false
            end

            b = b + 1
        end
    end
    Assets.sc_brick:play();
end

local function init_paddles_and_ball()
    PaddleLeft.w = 10
    PaddleLeft.h = 30
    PaddleLeft.y = CH / 2 - PaddleLeft.h / 2
    PaddleLeft.x = 10

    PaddleRight.w = 10
    PaddleRight.h = 30
    PaddleRight.y = CH / 2 - PaddleRight.h / 2
    PaddleRight.x = CW - PaddleRight.w - WALL_THICK - 5


    Ball.w = 32 / 4
    Ball.h = 32 / 4
    Ball.vx = 2.0
    Ball.vy = -1.6

    if math.random() > 0.5 then
        Ball.x = PaddleLeft.x + PaddleLeft.w / 2 + Ball.w / 2 + 5
        Ball.y = PaddleLeft.y + PaddleLeft.h / 2. - Ball.h / 2
    else
        Ball.x = PaddleRight.x - PaddleRight.w / 2 - Ball.w / 2 - 5
        Ball.y = PaddleRight.y + PaddleRight.h / 2. - Ball.h / 2
        Ball.vx = Ball.vx * -1
    end

    Ball.x1 = Ball.x
    Ball.y1 = Ball.y
end

local function update_paddles(DT)
    local speed = State.paddle_speed * DT

    if lyte.is_key_down("w") or lyte.is_gamepad_down(0, "dpad_up") then PaddleLeft.y = PaddleLeft.y - speed end
    if lyte.is_key_down("s") or lyte.is_gamepad_down(0, "dpad_down") then PaddleLeft.y = PaddleLeft.y + speed end

    if lyte.is_key_down("up") or lyte.is_gamepad_down(1, "dpad_up") then PaddleRight.y = PaddleRight.y - speed end
    if lyte.is_key_down("down") or lyte.is_gamepad_down(1, "dpad_down") then PaddleRight.y = PaddleRight.y + speed end

    local paddle_delta = 1
    if PaddleLeft.y < 0 + paddle_delta + WALL_THICK then PaddleLeft.y = 0 + paddle_delta + WALL_THICK end
    if PaddleLeft.y >= CH - PaddleLeft.h - paddle_delta - WALL_THICK then PaddleLeft.y = CH - PaddleLeft.h - paddle_delta
        - WALL_THICK end

    if PaddleRight.y < 0 + paddle_delta + WALL_THICK then PaddleRight.y = 0 + paddle_delta + WALL_THICK end
    if PaddleRight.y >= CH - PaddleRight.h - paddle_delta - WALL_THICK then PaddleRight.y = CH - PaddleRight.h -
        paddle_delta - WALL_THICK end
end

local function update_ball(DT)
    -- DT = 1/30
    local speedx = Ball.vx * DT * State.ball_speed
    local speedy = Ball.vy * DT * State.ball_speed
    Ball.x1 = Ball.x
    Ball.y1 = Ball.y
    Ball.x = Ball.x + speedx
    Ball.y = Ball.y + speedy

    local num_bricks_left = 0


    for _, wall in ipairs(Walls) do
        local c, hor, ver = rect_collision(Ball, wall)
        if c then
            LOG("*** wall -- " .. tostring(hor) .. " | " .. tostring(ver))
            Ball.y = Ball.y1
            Ball.x = Ball.x1
            if hor then
                -- play_sound(Assets.sc_brick)
                Assets.sc_brick:play()
                Ball.vy = Ball.vy * -1
            end
            if ver then

                if wall.t == "l" then
                    State.right_points = State.right_points + State.lvl_points
                elseif wall.t == "r" then
                    State.left_points = State.left_points + State.lvl_points
                end
                State.lvl_points = 0
                -- play_sound(Assets.sc_hurt)
                Assets.sc_hurt:play()
                init_paddles_and_ball()
            end
        end
    end


    for _, brick in ipairs(Bricks) do
        if brick.active then
            local c, hor, ver = rect_collision(Ball, brick)
            if c then
                brick.active = false
                State.lvl_points = State.lvl_points + 1
                -- play_sound(Assets.sc_brick)
                Assets.sc_brick:play()
                if hor then
                    Ball.y = Ball.y - speedy / 2
                    Ball.vy = Ball.vy * -1
                end
                if ver then
                    Ball.x = Ball.x - speedx / 2
                    Ball.vx = Ball.vx * -1
                end
            else
                num_bricks_left = num_bricks_left + 1
            end
        end
    end



    do
        local c1, hor1, ver1 = rect_collision(Ball, PaddleLeft)
        local c2, hor2, ver2 = rect_collision(Ball, PaddleRight)
        if c1 then
            -- play_sound(Assets.sc_paddle)
            Assets.sc_paddle:play()
            LOG("+++ paddle_left -- " .. tostring(hor1) .. " | " .. tostring(ver1))
            if hor1 then
                Ball.y = Ball.y - speedy / 2
                Ball.vy = Ball.vy * -1
            end
            if ver1 then
                Ball.x = Ball.x - speedx / 2
                Ball.vx = Ball.vx * -1
            end
        end
        if c2 then
            -- play_sound(Assets.sc_paddle)
            Assets.sc_paddle:play()
            LOG("+++ paddle_right -- " .. tostring(hor2) .. " | " .. tostring(ver2))
            if hor2 then
                Ball.y = Ball.y - speedy / 2
                Ball.vy = Ball.vy * -1
            end
            if ver2 then
                Ball.x = Ball.x - speedx / 2
                Ball.vx = Ball.vx * -1
            end
        end
    end

    if Ball.x - Ball.w / 2 <= 0 or Ball.x >= CW - Ball.w / 2 then
        Ball.x = Ball.x - 1.5 * Ball.vx * DT * State.ball_speed
        Ball.vx = Ball.vx * -1
    end
    if Ball.y - Ball.h / 2 <= 0 or Ball.y >= CH - Ball.h / 2 then
        Ball.y = Ball.y - 1.5 * Ball.vy * DT * State.ball_speed
        Ball.vy = Ball.vy * -1
    end

    if num_bricks_left == 0 then
        increase_difficulty()
        M.init()
        -- set_scene("menu")
    end

end


function M.init()
    init_paddles_and_ball()
    init_walls()
    init_bricks()
end


function M.update(DT)
    if lyte.is_key_pressed("escape") then
        set_scene("menu")
        State.paused = true
    end
    update_paddles(DT)
    update_ball(DT)
end

function M.draw(active)
    lyte.cls(0, 0, 0, 1)

    if active then

        lyte.set_color(0.9, 0.6, 0.5, 1)
        lyte.draw_text("" .. State.left_points, 0 + 2 + 10, 5)
        lyte.set_color(0.5, 0.6, 0.9, 1)
        draw_text_rightaligned(State.right_points .. "", CW - 2 - 10, 5)

        lyte.set_color(0.4, 0.6, 0.4, 1)
        draw_text_centered(string.rep('|', State.lvl_points), CW / 2, 1 )


        lyte.set_color(0.9, 0.6, 0.5, 1)
        lyte.draw_rect(PaddleLeft.x, PaddleLeft.y, PaddleLeft.w, PaddleLeft.h)


        lyte.set_color(0.5, 0.6, 0.9, 1)
        lyte.draw_rect(PaddleRight.x, PaddleRight.y, PaddleRight.w, PaddleRight.h)

        lyte.set_color(0.8, 0.8, 0.4, 1)
        lyte.draw_rect(Ball.x, Ball.y, Ball.w, Ball.h)

        local b = 1
        for y = 1, State.num_brickrows do
            for x = 1, State.num_briccols do
                local v = Bricks[b];
                if v then
                    if (v.active) then
                        lyte.set_color(v.r, v.g, v.b, 1.0)
                        lyte.draw_rect(v.x, v.y, v.w, v.h)
                    end
                    b = b + 1
                end
            end
        end
    end


    for _, wall in ipairs(Walls) do
        lyte.set_color(0.5, 0.6, 0.5, 0.3)
        lyte.draw_rect(wall.x, wall.y, wall.w, wall.h)

    end

end

return M
