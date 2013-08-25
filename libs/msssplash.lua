local msssplash = {}

msssplash.img = love.graphics.newImage("libs/mss.png")
msssplash.fade_in = 2.55
msssplash.fade_out = 2.55
msssplash.total = 8.40

function msssplash.draw()
  if msssplash.temp_dt < msssplash.fade_in then
    love.graphics.setColor(255,255,255,math.floor(msssplash.temp_dt*100))
  elseif msssplash.temp_dt >= msssplash.fade_in and msssplash.temp_dt < msssplash.total - msssplash.fade_out then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(255,255,255,math.floor((msssplash.total-msssplash.temp_dt)*100))
  end
  love.graphics.draw(msssplash.img,
    (love.graphics.getWidth()-msssplash.img:getWidth())/2,
    (love.graphics.getHeight()-msssplash.img:getHeight())/2 )
  msssplash.start = true
end

msssplash.temp_dt = 0
function msssplash.update(dt)
  if msssplash.start then
    msssplash.temp_dt = msssplash.temp_dt + dt
  end
  if msssplash.temp_dt >= msssplash.total then
  end
end

function msssplash.stop()
  msssplash.temp_dt = msssplash.total
end

function msssplash.done()
  if msssplash.temp_dt >= msssplash.total then -- 255 * 2
    return true
  end
end

return msssplash
