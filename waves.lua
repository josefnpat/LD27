local waves = {}

function waves.init()
  waves.build_t = 10
  waves.build_dt = waves.build_t
  waves.build_last_init = 3
  waves.build_last = waves.build_last_init
  waves.play = false
  waves.data = {}
  waves.level = 0
  waves.buildwait_dt = waves.buildwait_t
  waves.gameover_countdown_dt = waves.gameover_countdown_t
  waves.gameover = false
end

waves.buildimg = love.graphics.newImage("assets/build.png")

waves.buildwait_t = 1

waves.enemyquads = {}
for i = 1,4 do
  waves.enemyquads[i] = love.graphics.newQuad((i-1)*32,0,32,32,128,32)
end

waves.gameover_countdown_t = 10

function waves.draw()
  local explain
  if waves.play then
    explain = #waves.data .. " ENEMIES REMAIN - DEFEND YOURSELVES!"
  else
    explain = math.round(waves.build_dt,0).." SECONDS REMAIN - BUILD MODE!"
    for i,v in pairs(players.data) do
      local newdist = 48
      v.build = {}
      local ax = v.x+(math.cos(v.r))*newdist-16
      local ay = v.y+(math.sin(v.r))*newdist-16
      v.build.x = math.round(ax/32)+1
      v.build.y = math.round(ay/32)+1
      local r,g,b = unpack(colors.players[i])
      love.graphics.setColor(r,g,b,127)
      love.graphics.draw(waves.buildimg,(v.build.x-1)*32,(v.build.y-1)*32)
      love.graphics.setColor(colors.reset)
    end
  end
  for i,v in pairs(waves.data) do
    love.graphics.drawq(v.classes.img,waves.enemyquads[math.floor(v.walkdt%4)+1],v.x,v.y,v.r-math.pi/2,1,1,16,16)
  end
  love.graphics.setColor(colors.reset)
  love.graphics.setFont(fonts.small)
  love.graphics.setFont(fonts.large)
  love.graphics.printf("LEVEL "..waves.level,0,0,love.graphics.getWidth(),"center")
  love.graphics.setFont(fonts.small)
  love.graphics.printf(explain.."\nMONEY: "..math.round(players.money,0),0,48,love.graphics.getWidth(),"center")
  
end

function waves.new()
  waves.addenemies(enemies.small_easy,waves.level*4*#players.data)
  waves.addenemies(enemies.large_easy,math.floor(waves.level/2)*#players.data)
  waves.addenemies(enemies.small_hard,math.floor(waves.level/4)*#players.data)
  waves.addenemies(enemies.large_hard,math.floor(waves.level/8)*#players.data)
end

function waves.addenemies(enemyclass,count)
  if count > 0 then
    for i = 1,count do
      local b = {}
      b.classes = enemyclass
      b.hp = enemyclass.hp
      if math.random(0,1) == 1 then
        b.y = math.random(64,512)+love.graphics.getHeight()
      else
        b.y = -math.random(64,512)
      end
      if math.random(0,1) == 1 then
        b.x = math.random(64,512)+love.graphics.getWidth()
      else
        b.x = -math.random(64,512)
      end
      b.r = 0
      b.walkdt = math.random(1,100)/100
      table.insert(waves.data,b)
    end
  end
end

function waves.update(dt)

  if not waves.play then
    if waves.build_dt < waves.build_last then
      waves.build_last = waves.build_last - 1
      if waves.build_last >= 0 then
        sfx.play(sfx.data.countdown)
      end
    end
  end

  if waves.gameover then
    waves.gameover_countdown_dt = waves.gameover_countdown_dt - dt
    if waves.gameover_countdown_dt <= 0 then
      waves.gameover_countdown_dt = waves.gameover_countdown_t
      gamestate.switch(states.select)
    end
  end

  if waves.play then
    for i,v in ipairs(waves.data) do  
      
      if v.no_new_targets then    
        v.no_new_targets = v.no_new_targets - dt
        if v.no_new_targets <= 0 then
          v.no_new_targets = nil
        end
      else
        local target = nil
        if not v.dist_to_target then
          target = {x=love.graphics.getWidth()/2,y=love.graphics.getHeight()/2}
        else
          v.dist_to_target = v.dist_to_target - dt*100
          if v.dist_to_target <= 0 then
            v.dist_to_target = nil
          end
        end
        local players_dead = true
        for biy,bxdat in pairs(map.data) do
          for bix,dat in pairs(bxdat) do
            if dat.level > 0 then
              local bx = (bix-1)*32+16
              local by = (biy-1)*32+16
              local dist = math.dist(bx,by,v.x,v.y)
              if dist < v.classes.sexyness then
                if v.dist_to_target then
                  if dist < v.dist_to_target then
                    target = {x=bx,y=by}
                    v.dist_to_target = dist
                  end
                else
                  v.dist_to_target = dist
                  target = {x=bx,y=by}
                end
                if dist < 16 then
                  dat.hp = dat.hp - v.classes.dmg*dt
                  if dat.hp <= 0 then
                    dat.hp = nil
                    dat.level = 0
                    dat.tile = 1
                    v.dist_to_target = nil
                  end
                end
              end
            end
          end
        end
        local player_dist = 999999999 --TODO: lololol
        for pi,pv in pairs(players.data) do

          if not pv.dead then
            players_dead = false
          end
          local dist = math.dist(v.x,v.y,pv.x,pv.y)
          if not pv.dead and dist < v.classes.sexyness then
            if dist < player_dist then
              target = {x=pv.x,y=pv.y}
              player_dist = dist
            end
          end
          if dist < 16 then
            v.no_new_targets = v.classes.nohomobro

            if pv.shield then
              pv.shield = pv.shield - 1
              if pv.shield <= 0 then
                pv.shield = nil
              end
            else
              pv.hp = pv.hp - v.classes.dmg
              if pv.hp < 0 then
                pv.hp = 0
                pv.dead = true
                sfx.play(sfx.data.death)
              end
            end

          end
        end
        if players_dead then
          waves.gameover = true
        end
        for ei,ev in pairs(waves.data) do
          if ev ~= v and math.dist(ev.x,ev.y,v.x,v.y) < 16 then
            target = {x=v.x+(math.random(0,1)*2-1),y=v.y+(math.random(0,1)*2-1)}
            v.no_new_targets = v.classes.nohomobro
          end
        end
        if target then
          v.r = -math.atan2(target.x-v.x,target.y-v.y)+math.pi/2
        end
        if math.dist(v.x,v.y,love.graphics.getWidth()/2,love.graphics.getHeight()/2) < 32 then
          waves.gameover = true
        end
      end
    
      v.walkdt = v.walkdt + dt*8
      local tx = math.floor(v.x/32)+1
      local ty = math.floor(v.y/32)+1
      local slow = 1
      if map.data[ty] and map.data[ty][tx] and map.data[ty][tx].level > 0 then
        if build[map.data[ty][tx].level].slow then
          slow = build[map.data[ty][tx].level].slow
        end
      end
      v.x = v.x+(math.cos(v.r)*dt*v.classes.speed*slow)
      v.y = v.y+(math.sin(v.r)*dt*v.classes.speed*slow)
    end
    for i,v in pairs(waves.data) do
      if v._remove then
        table.remove(waves.data,i)
        sfx.play(sfx.data.enemydeath)
      end
    end
    if #waves.data == 0 then
      waves.play = false
    end
  else
    waves.buildwait_dt = waves.buildwait_dt - dt
    if waves.buildwait_dt <= 0 then
      waves.build_dt = waves.build_dt - dt
    end
    if waves.build_dt <= 0 then
      waves.build_last = waves.build_last_init
      waves.play = true
      waves.build_dt = waves.build_t
      waves.level = waves.level + 1
      waves.new()
      waves.buildwait_dt = waves.buildwait_t
    end
  end
end

return waves
