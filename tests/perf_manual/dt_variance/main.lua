local dt, max=0,0

function love.keypressed( key, scancode, isrepeat )
  if key == "f3" then max = 0 end

end

function love.update(d)
    dt = d
    if (dt > max) then max = dt end
end

function love.draw()
    love.graphics.print("max: " ..  max, 10, 10)
    love.graphics.print("dt: " ..  dt, 10, 30)
end
