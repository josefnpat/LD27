local players = {}

function players.real_init()
  players.data = {}
end

players.walkquads = {}
for i = 1,4 do
  players.walkquads[i] = love.graphics.newQuad((i-1)*32,0,32,32,128,128)
end
players.attackquads = {}
for i = 1,4 do
  players.attackquads[i] = love.graphics.newQuad((i-1)*32,32,32,32,128,128)
end

players.deadimg = love.graphics.newImage("assets/classes/dead.png")

function players.init()
  for i,p in pairs(players.data) do
    p.x = love.graphics.getWidth()/2
    p.y = love.graphics.getHeight()/2
    p.r = 0
    p.walkdt = 0
    p.shoot_dt = 0
    p.alt_dt = 0
    p.hp = p.classes.hp
  end
  players.money = #players.data*2000
end

function players.draw()
  for i,v in pairs(players.data) do

    if v.dead then
      love.graphics.setColor(colors.players[i])
      love.graphics.draw(players.deadimg,v.x,v.y,0,1,1,16,16)
      love.graphics.setColor(colors.reset)
    else

      local percent = v.hp/v.classes.hp
      if percent ~= 1 then
        local hp_color = colors.hp_low
        if v.hp > v.classes.hp*2/3 then
          hp_color = colors.hp_high
        elseif v.hp > v.classes.hp*1/3 then
          hp_color = colors.hp_mid
        end

        love.graphics.setColor(hp_color)
        love.graphics.rectangle("fill",v.x-16,v.y-24,32*percent,4)
        love.graphics.setColor(colors.hp_border)
        love.graphics.rectangle("line",v.x-16,v.y-24,32,4)
        love.graphics.setColor(colors.reset)
      end
   
      local quad = players.walkquads[1]
      if v.controls:alt(v) then
        quad = players.attackquads[math.floor(v.walkdt%2+1+2)]
        love.graphics.setColor(v.classes.alt_circle_color)
        love.graphics.circle("line",v.x,v.y,v.classes.alt_circle+math.random(-4,4))
        love.graphics.setColor(colors.reset)
      elseif v.controls:shoot(v) then
        quad = players.attackquads[math.floor(v.walkdt%2+1)]
      elseif v.controls:move(v) then
        quad = players.walkquads[math.floor(v.walkdt%4+1)]
      end
      love.graphics.setColor(colors.players[i])
      love.graphics.print("P"..i,v.x+16,v.y+16)
      love.graphics.setColor(colors.reset)
      love.graphics.drawq(v.classes.ss.img,quad,v.x,v.y,v.r-math.pi/2,1,1,16,16)
      love.graphics.setColor(colors.players[i])
      love.graphics.drawq(v.classes.ss.img_color,quad,v.x,v.y,v.r-math.pi/2,1,1,16,16)
      love.graphics.setColor(colors.reset)
    end

  end
end

function players.build(p)
  if waves.buildwait_dt <= 0 then
    if map.data[p.build.y] and map.data[p.build.y][p.build.x] then
      local current_level = map.data[p.build.y][p.build.x].level
      if build[current_level+1] then
        if players.money >= build[current_level+1].cost then
          players.money = players.money - build[current_level+1].cost
          map.data[p.build.y][p.build.x].tile = build[current_level+1].tile
          map.data[p.build.y][p.build.x].level = map.data[p.build.y][p.build.x].level + 1
          map.data[p.build.y][p.build.x].hp = build[current_level+1].hp
          return true
        end
      end
    end
  end
end

function players.update(dt)
  for i,v in pairs(players.data) do
    if v.dead then 
      if not waves.play then
        v.dead = nil
        v.hp = v.classes.hp/10
      end
    else
      v.walkdt = v.walkdt + dt*8
      v.r = v.controls:direction(v)
      if v.controls:move(v) then
        v.x = v.x+(math.cos(v.r)*dt*v.classes.speed)
        v.y = v.y+(math.sin(v.r)*dt*v.classes.speed)
        if v.x < 0 then
          v.x = 0
        end
        if v.x > love.graphics.getWidth() then
          v.x = love.graphics.getWidth()
        end
        if v.y < 0 then
          v.y = 0
        end
        if v.y > love.graphics.getHeight() then
          v.y = love.graphics.getHeight()
        end
      end
      if waves.play then
        v.shoot_dt = v.shoot_dt - dt
        if v.controls:shoot(v) and v.shoot_dt <= 0 and v.alt_dt <= 0 then
          bullet.new(v)
          v.shoot_dt = v.classes.shoot_t
          sfx.play(sfx.data.shoot)
        end
      else
        if v.controls:build(v) then
          local success = players.build(v)
          if success then
            sfx.play(sfx.data.build)
          end
        end
      end
      v.alt_dt = v.alt_dt - dt
      if v.controls:alt(v) and v.alt_dt <= 0 then
        v.classes:alt(dt,v)
        v.alt_dt = v.classes.alt_t
        sfx.play(sfx.data.alt)
      end
    end
  end
end

return players
