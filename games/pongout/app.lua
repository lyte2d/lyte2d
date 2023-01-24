--[[ (c) mg ]]

-- contants

TOP_SPACE = 15
BOTTOM_SPACE = 5
CW = 64 * 6 -- game area width
CH = 40 * 6 - TOP_SPACE - BOTTOM_SPACE -- game area height
WALL_THICK = 5

-- global state

State = {
    lvl_points = 0,
    left_points = 0,
    right_points = 0,
    paddle_speed = 100.,
    ball_speed = 45.,
    num_brickrows = 4,
    num_briccols = 1,
    brick_dx = 6,
    brick_dy = 10,
    brick_w = 10,
    brick_h = 10,
    paused = false
}
State.brick_h = math.floor((CH - 2 * State.brick_dy) / (State.num_brickrows)) - State.brick_dy


Window = {
    width = 0.,
    height = 0.,
    fullscreen = false,
    scale = 1.,
    canvas = nil,

    DRAW_DEBUG = false,
    PIXEL_PERFFECT = true,
}

Assets = {
    font1 = nil,
    music_elev = nil,
    sd_brick_dt = nil,
    sd_paddle_dt = nil,
    sd_hurt_dt = nil,
    sc_brick = nil,
    sc_paddle = nil,
    sc_hurt = nil,
}

-- global functions

function LOG(...)
    -- print(...)
end

function draw_text_centered(str, x, y)
    local w, h = lyte.measure_text(str)
    lyte.draw_text(str, x - w / 2, y - h / 2)
end

function draw_text_rightaligned(str, x, y)
    local w, _h = lyte.measure_text(str)
    lyte.draw_text(str, x - w, y)
end


-- state/scenes

local current_scene = "menu"

local play_scene = require "game.play_scene"
local menu_scene = require "game.menu_scene"

function set_scene(name)
    current_scene = name
end

local function load_assets()
    Assets.font1 = lyte.load_font("/assets/fonts/m5x7.ttf", 14)
    Assets.music_elev = lyte.Music("/assets/music/elev.mp3")

    Assets.sd_brick_dt = lyte.SoundData("/assets/snd/sfx_pellet.ogg")
    Assets.sd_brick_dt.volume = 0.3
    Assets.sd_paddle_dt = lyte.SoundData("/assets/snd/shoot.ogg")
    Assets.sd_paddle_dt.volume = 0.3
    Assets.sd_hurt_dt = lyte.SoundData("/assets/snd/sfx_hurt.wav")
    Assets.sd_hurt_dt.volume = 0.3

    Assets.sc_brick = lyte.Sound(Assets.sd_brick_dt)
    Assets.sc_paddle = lyte.Sound(Assets.sd_paddle_dt)
    Assets.sc_hurt = lyte.Sound(Assets.sd_hurt_dt)
end

local function debug_draw(DT)
    set_color(1, 1, 1, 1)
    draw_text("FPS: " .. mathx.round(1 / DT, 2), 5, 0)
    draw_text("DT: " .. mathx.round(DT, 4), 5, 15)

    set_color(1, 0, 0, 1)
    -- window rect
    draw_rect(1, 1, Window.width - 1, Window.height - 1)

    -- canvas rect
    set_color(0, 1, 0, 1)
    -- set_color(1, 1, 1, 0.4)
    translate(
        math.floor((Window.width - CW * Window.scale) / 2) - 0.5,
        math.floor((Window.height - (CH + TOP_SPACE+BOTTOM_SPACE) * Window.scale) / 2) - 0.5)
    draw_rect(0, 0, mathx.round(CW * Window.scale), mathx.round((CH+TOP_SPACE+BOTTOM_SPACE) * Window.scale))

end

local function adjust_scale()
    local sc = (math.min(Window.width / CW, Window.height / (CH + TOP_SPACE + BOTTOM_SPACE)))
    if Window.PIXEL_PERFFECT then
        Window.scale = math.floor(sc)
    else
        Window.scale = sc
    end
end

function lyte.frame(delta_time, width, height, resized, fullscreen)
    if resized then
        Window.width = width
        Window.height = height
        Window.fullscreen = fullscreen
        adjust_scale()
    end

    -- System keys
    -- F4: quit
    if lyte.is_keypressed("f4") or lyte.is_gamepadpressed(0, "but_back") then quit() end
    -- Alt-F11: pixel perfect vs regular scaling
    if (lyte.is_keydown('left_alt') or lyte.is_keydown('right_alt')) and lyte.is_keypressed("f11") then
        Window.PIXEL_PERFFECT = not Window.PIXEL_PERFFECT
        adjust_scale()
        return
    end

    -- F11: fullscreen/exit fullscreen
    if lyte.is_keypressed("f11") or lyte.is_gamepadpressed(0, "but_start") then set_fullscreen(not fullscreen) end
    -- Alt-F12: debug info drawn/not drawn
    if (lyte.is_keydown('left_alt') or lyte.is_keydown('right_alt')) and lyte.is_keypressed("f12") then
        Window.DRAW_DEBUG = not Window.DRAW_DEBUG
        return
    end

    if lyte.is_keypressed("f8") then set_vsync(false) end
    if lyte.is_keypressed("f9") then set_vsync(true) end

    -- App update
    if current_scene == "menu" then
        menu_scene.update(delta_time)
    elseif current_scene == "play" then
        play_scene.update(delta_time)
    else
        error("Unknown scene to update: " .. current_scene)
    end

    -- Draw: App -> Canvas
    lyte.set_canvas(Window.canvas)
    lyte.push_matrix()
    lyte.translate(0, (TOP_SPACE))
    if current_scene == "menu" then
        play_scene.draw(false)
        menu_scene.draw()
    elseif current_scene == "play" then
        play_scene.draw(true)
    else
        error("Unknown scene to draw: " .. current_scene)
    end
    lyte.pop_matrix()
    lyte.reset_canvas()

    -- Draw Canvas -> Window
    lyte.push_matrix()
    if Window.DRAW_DEBUG then
        lyte.clear(0.15, 0.15, 0.15, 1)
    else
        lyte.clear(0, 0, 0, 1)
    end
    -- translate(0.5, (CH + TOP_SPACE + BOTTOM_SPACE) * Window.scale + 0.5);
    lyte.scale(Window.scale, Window.scale)
    lyte.draw_image(Window.canvas.image,
        math.floor(Window.width / Window.scale / 2 - CW / 2),
        math.floor(Window.height / Window.scale / 2 - (CH + TOP_SPACE+BOTTOM_SPACE) / 2))
    lyte.pop_matrix()

    -- Draw: Debug info
    if Window.DRAW_DEBUG then
        lyte.push_matrix()
        debug_draw(delta_time)
        lyte.pop_matrix()
    end
end

local function start()
    -- set_margins(1, 1, 1, 1)
    -- set_paddings(0, 0, 0, 0)
    lyte.window.vsync = true
    lyte.window.size = { width = CW*3, height = (CH+TOP_SPACE+BOTTOM_SPACE)*3 }
    lyte.window.title = "Pong Out!"
    lyte.window.icon = "/assets/images/icon.png"

    Window.width = lyte.window.size.width
    Window.height = lyte.window.size.height
    Window.canvas = lyte.Canvas(CW, (CH + TOP_SPACE + BOTTOM_SPACE))
    adjust_scale()

    load_assets()

    lyte.set_font(Assets.font1)
    menu_scene.init()
    play_scene.init()
    Assets.music_elev.volume = 0.3
    Assets.music_elev:play()

end

start()
