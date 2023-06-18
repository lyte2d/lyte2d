-- abstractions over LOVE2D and Lyte2D
-- - initially to find the big perf issues in Lyte2D
-- - eventually for performance comparison purposes

local plat = require "lib.plat"

local LOVE = plat.LOVE
local LYTE = plat.LYTE


local fps_list = {}
local FPS = 0

local function noop() end

local function count_fps(dt)
  local fps = (1 / dt)
  table.insert(fps_list, fps)
  if (#fps_list > 140) then
    table.remove(fps_list, 1)
  else
  end
  FPS = 0
  for i = 1, #fps_list do
    FPS = (FPS + fps_list[i])
  end
  FPS = (FPS / #fps_list)
  return nil
end

local function init(a2d)
    local fnt = a2d.loadfont("assets/m5x7.ttf", 40)
    a2d.setfont(fnt)
    a2d.winsize(800,600)
    a2d.totaltime = 0
end


function LOVE.set_fns(draw, update)
    local update = update or noop
    local draw = draw or noop
    love.update = function(dt)
        LOVE.totaltime = LOVE.totaltime + dt
        LOVE.deltatime = dt
        count_fps(dt)
        LOVE.FPS = FPS
        update(dt)
    end
    love.draw = draw

    jit.off()
end

function LYTE.set_fns(draw, update)
    local update = update or noop
    local draw = draw or noop
    lyte.tick = function(dt)
        LYTE.totaltime = LYTE.totaltime + dt
        LYTE.deltatime = dt
        count_fps(dt)
        LYTE.FPS = FPS
        update(dt)
        draw()
    end
end


local function make_a2d(m)
    local A = {}
    if m == "love" then
        A = LOVE
    elseif m == "lyte" then
        A = LYTE
    else
        error("mode expected 'lyte' or 'love'. got: '" .. m .. "'")
    end
    init(A)
    return A
end

return make_a2d
