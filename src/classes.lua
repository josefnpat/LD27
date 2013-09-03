local classes = {}

classes.soldier = {}
classes.soldier.name = "Soldier"
classes.soldier.port = love.graphics.newImage("assets/classes/portraits/soldier.jpg")
classes.soldier.ss = {}
classes.soldier.ss.img = love.graphics.newImage("assets/classes/ss/soldier.png")
classes.soldier.ss.img_color = love.graphics.newImage("assets/classes/ss/soldier_color.png")
classes.soldier.range = 64
classes.soldier.dmg = 250
classes.soldier.hp = 100
classes.soldier.speed = 100
classes.soldier.shoot_t = 0.25
classes.soldier.alt_t = 0.5
classes.soldier.alt_des = "Shield"
classes.soldier.alt_circle = 16
classes.soldier.alt_circle_color = {0,0,255}
classes.soldier.alt = function(self,dt,player)
  player.shield = 5
end

classes.medic = {}
classes.medic.name = "Medic"
classes.medic.port = love.graphics.newImage("assets/classes/portraits/medic.jpg")
classes.medic.ss = {}
classes.medic.ss.img = love.graphics.newImage("assets/classes/ss/medic.png")
classes.medic.ss.img_color = love.graphics.newImage("assets/classes/ss/medic_color.png")
classes.medic.range = 256
classes.medic.dmg = 100
classes.medic.hp = 60
classes.medic.speed = 80
classes.medic.shoot_t = 0.25
classes.medic.alt_t = 1
classes.medic.alt_des = "Area Heal"
classes.medic.alt_circle = 128
classes.medic.alt_circle_color = {0,255,0}
classes.medic.alt = function(self,dt,player)
  for i,v in pairs(players.data) do
    if math.dist(v.x,v.y,player.x,player.y) < 128 then
      v.hp = v.hp + 10
      if v.hp > v.classes.hp then
        v.hp = v.classes.hp
      end
    end
  end
end

classes.ranger = {}
classes.ranger.name = "Ranger"
classes.ranger.port = love.graphics.newImage("assets/classes/portraits/ranger.jpg")
classes.ranger.ss = {}
classes.ranger.ss.img = love.graphics.newImage("assets/classes/ss/ranger.png")
classes.ranger.ss.img_color = love.graphics.newImage("assets/classes/ss/ranger_color.png")
classes.ranger.range = 512
classes.ranger.dmg = 175
classes.ranger.hp = 80
classes.ranger.speed = 120
classes.ranger.shoot_t = 0.25
classes.ranger.alt_t = 2
classes.ranger.alt_des = "Bomb"
classes.ranger.alt_circle = 128
classes.ranger.alt_circle_color = {255,0,0}
classes.ranger.alt = function(self,dt,player)
  for i,v in pairs(waves.data) do
    if math.dist(v.x,v.y,player.x,player.y) < 128 then
      v.hp = v.hp - 500
      if v.hp < 0 then
        v.hp = 0
        v._remove = true
      end
    end
  end
end

classes.engie = {}
classes.engie.name = "Engineer"
classes.engie.port = love.graphics.newImage("assets/classes/portraits/engie.jpg")
classes.engie.ss = {}
classes.engie.ss.img = love.graphics.newImage("assets/classes/ss/engie.png")
classes.engie.ss.img_color = love.graphics.newImage("assets/classes/ss/engie_color.png")
classes.engie.range = 64
classes.engie.dmg = 125
classes.engie.hp = 200
classes.engie.speed = 200
classes.engie.shoot_t = 0.25
classes.engie.alt_t = 0.5
classes.engie.alt_des = "Repair"
classes.engie.alt_circle = 64
classes.engie.alt_circle_color = {0,255,0}
classes.engie.alt = function(self,dt,player)
  for y,xdat in pairs(map.data) do
    for x,v in pairs(xdat) do
      if v.level > 0 then
        local rx = (x-1)*32+16
        local ry = (y-1)*32+16
        if math.dist(rx,ry,player.x,player.y) < player.classes.alt_circle then
          v.hp = v.hp + 25
          if v.hp > build[v.level].hp then
            v.hp = build[v.level].hp
          end
        end
      end
    end
  end
end

return classes
