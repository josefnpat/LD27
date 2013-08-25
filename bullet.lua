local bullet = {}

function bullet.init()
  bullet.data = {}
end

bullet.speed = 500
bullet.quad = love.graphics.newQuad(0,64,32,32,128,129)

function bullet.new(player)
  local b = {}
  b.x = player.x
  b.y = player.y
  b.r = player.r
  b.classes = player.classes
  b.range = player.classes.range
  table.insert(bullet.data,b)
end

function bullet.update(dt)
  for i,v in pairs(bullet.data) do
    v.x = v.x+(math.cos(v.r)*dt*bullet.speed)
    v.y = v.y+(math.sin(v.r)*dt*bullet.speed)
    v.range = v.range - dt*bullet.speed
    if v.range <= 0 then
      v._remove = true
    end
    for wi,wv in pairs(waves.data) do
      if math.dist(wv.x,wv.y,v.x,v.y) < 16 then
        wv.hp = wv.hp - v.classes.dmg
        v._remove = true
        if wv.hp <= 0 then
          wv._remove = true
          players.money = players.money + wv.classes.value
        end
      end
    end
  end
  
  for i,v in pairs(bullet.data) do
    if v._remove then
      table.remove(bullet.data,i)
    end
  end
end

function bullet.draw()
  for i,v in pairs(bullet.data) do
    love.graphics.drawq(v.classes.ss.img,bullet.quad,v.x,v.y,v.r-math.pi/2,1,1,16,16)
  end
end

return bullet
