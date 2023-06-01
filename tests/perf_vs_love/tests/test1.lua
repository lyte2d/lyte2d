---

local posx = {}
local posy = {}
local rads = {}

local framecnt = 0

local function change()
    for i=1,940 do
        posx[i] = math.random(10,750)
        posy[i] = math.random(10,500)
        rads[i] = math.random(6,80)
    end
end


local function draw_test()
    framecnt = framecnt + 1
    a2d.cls()
    a2d.color(1,1,1,0.02)
    for i=1,#rads do
        a2d.circle(posx[i],posy[i], rads[i])
    end
    a2d.color(1,1,0,1)
    a2d.text("HELLO " .. a2d.totaltime, 50, 10)
    a2d.text("FPS (1)" .. 1/a2d.deltatime, 50, 60)
    a2d.text("FPS (5)" .. a2d.FPS, 50, 110)

    if (framecnt % 31 == 0) then change() end
end



local function test1()
    math.randomseed(100) -- unfortunately this doesn't work between luajit and puc lua
    change()
    a2d.set_fns(draw_test)

end

return test1