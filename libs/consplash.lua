local consplash = {}

consplash.img = love.graphics.newImage("libs/control.png")
consplash.fade_in = 2.55
consplash.fade_out = 2.55
consplash.total = 8.40

function consplash.draw()
  if consplash.temp_dt < consplash.fade_in then
    love.graphics.setColor(255,255,255,math.floor(consplash.temp_dt*100))
  elseif consplash.temp_dt >= consplash.fade_in and consplash.temp_dt < consplash.total - consplash.fade_out then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(255,255,255,math.floor((consplash.total-consplash.temp_dt)*100))
  end
  love.graphics.draw(consplash.img,
    (love.graphics.getWidth()-consplash.img:getWidth())/2,
    (love.graphics.getHeight()-consplash.img:getHeight())/2 )
  consplash.start = true
end

consplash.temp_dt = 0
function consplash.update(dt)
  if consplash.start then
    consplash.temp_dt = consplash.temp_dt + dt
  end
  if consplash.temp_dt >= consplash.total then
  end
end

function consplash.stop()
  consplash.temp_dt = consplash.total
end

function consplash.done()
  if consplash.temp_dt >= consplash.total then -- 255 * 2
    return true
  end
end

return consplash
