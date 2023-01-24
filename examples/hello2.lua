local x = lyte.get_windowwidth()
local y = lyte.get_windowheight()
local s = "Hello, world :)"

function lyte.frame()
  lyte.clear(0,0,0,1)
  lyte.set_color(1,1,1,1)
  local w, h = lyte.measure_text(s)
  lyte.draw_text(s, (x-w)/2, (y-h)/2)
end
