local lovesplash = {}

lovesplash.img = love.graphics.newImage("libs/love.png")
lovesplash.whatislove = love.audio.newSource( "libs/love_short.ogg", "stream" )
lovesplash.fade_in = 2.55
lovesplash.fade_out = 2.55
lovesplash.total = 8.40

function lovesplash.draw()
  if lovesplash.temp_dt < lovesplash.fade_in then
    love.graphics.setColor(255,255,255,math.floor(lovesplash.temp_dt*100))
  elseif lovesplash.temp_dt >= lovesplash.fade_in and lovesplash.temp_dt < lovesplash.total - lovesplash.fade_out then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(255,255,255,math.floor((lovesplash.total-lovesplash.temp_dt)*100))
  end
  love.graphics.draw(lovesplash.img,
    (love.graphics.getWidth()-lovesplash.img:getWidth())/2,
    (love.graphics.getHeight()-lovesplash.img:getHeight())/2 )
  lovesplash.start = true
end

lovesplash.temp_dt = 0
function lovesplash.update(dt)
  if lovesplash.start then
    lovesplash.temp_dt = lovesplash.temp_dt + dt
  end
  if not lovesplash.sound_play then
    love.audio.play(lovesplash.whatislove)
    lovesplash.sound_play = true
  end
  if lovesplash.temp_dt >= lovesplash.total then
    love.audio.stop(lovesplash.whatislove)
  end
end

function lovesplash.stop()
  love.audio.stop(lovesplash.whatislove)
  lovesplash.temp_dt = lovesplash.total
end

function lovesplash.done()
  if lovesplash.temp_dt >= lovesplash.total then -- 255 * 2
    return true
  end
end

return lovesplash
