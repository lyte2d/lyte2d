local x = get_windowwidth()
local y = get_windowheight()
local s = "Hello, world :)"

function frame()
  clear(0,0,0,1)
  set_color(1,1,1,1)
  local w, h = measure_text(s)
  draw_text(s, (x-w)/2, (y-h)/2)
end