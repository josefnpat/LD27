local state_splash = {}

function state_splash:draw()
  if not lovesplash.done() then
    lovesplash.draw()
  else
    if not msssplash.done() then
      msssplash.draw()
    else
      if not consplash.done() then
        consplash.draw()
      end
    end
  end
end

function state_splash:update(dt)
  if not lovesplash.done() then
    lovesplash.update(dt)
  else
    if not msssplash.done() then
      msssplash.update(dt)
    else
      if not consplash.done() then
        consplash.update(dt)
      else
        gamestate.switch(states.select)
        love.graphics.setColor(255,255,255) -- SEPPI, YOUR LIBRARY SUCKS
      end
    end
  end
end

function state_splash:keypressed()
  if not lovesplash.done() then
    lovesplash.stop()
  else
    if not msssplash.done() then
      msssplash.stop(dt)
    else
      if not consplash.done() then
        consplash.stop(dt)
      end
    end
  end
end

function state_splash:mousepressed()
  state_splash:keypressed()
end

function state_splash:joystickpressed()
  state_splash:keypressed()
end

return state_splash
