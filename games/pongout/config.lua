function lyte.tick_loading(dt, w, h)
  lyte.cls(0,0.2,0.7,1)
  lyte.set_color(1,1,0,1)
  lyte.translate(20,h/2)
  lyte.scale(5,5)
  local txt = "LOADING ..."

  lyte.draw_text(txt, 0, 0)
  lyte.draw_text(txt, 0, 0)
  lyte.draw_text(txt, 0, 0)
  lyte.draw_text(txt, 0, 0)
end

return {
    window_width = 320*4,
    window_height = 200*4,
    window_title = "pong-out :)",
    fulscreen = false,
    window_vsync = true,
    window_resizable = false,
    default_filtermode = "nearest", -- linear
    default_blendmode = "blend",
  }
