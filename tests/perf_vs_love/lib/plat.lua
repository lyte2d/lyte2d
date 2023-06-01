--

local LOVE = {}
local LYTE = {}



function LOVE.quit() love.event.quit() end
function LYTE.quit() lyte.quit() end

function LOVE.winsize(w,h) love.window.setMode(w, h, {resizable = true}) end
function LYTE.winsize(w,h) lyte.set_window_size(w,h) end

function LOVE.cls() love.graphics.clear(0,0,0,1)  end
function LYTE.cls(r,g,b,a) lyte.cls(0,0,0,1) end

function LOVE.color(r,g,b,a) love.graphics.setColor(r,g,b,a)  end
function LYTE.color(r,g,b,a) lyte.set_color(r,g,b,a) end

function LOVE.circle(x,y,r) love.graphics.circle("fill", x, y, r)  end
function LYTE.circle(x,y,r) lyte.draw_circle(x, y, r) end

function LOVE.loadfont(path, sz) local fnt = love.graphics.newFont(path, sz); fnt:setFilter("nearest", "nearest"); return fnt end
function LYTE.loadfont(path, sz) return lyte.load_font(path, sz) end

function LOVE.setfont(f) love.graphics.setFont(f) end
function LYTE.setfont(f) lyte.set_font(f) end

function LOVE.text(txt, x,y) love.graphics.print(txt, x, y) end
function LYTE.text(txt, x,y) lyte.draw_text(txt, x, y) end





return { LOVE = LOVE, LYTE = LYTE }

