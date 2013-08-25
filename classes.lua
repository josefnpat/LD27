local classes = {}

classes.soldier = {}
classes.soldier.name = "Soldier"
classes.soldier.port = love.graphics.newImage("assets/classes/portraits/soldier.jpg")
classes.soldier.ss = {}
classes.soldier.ss.img = love.graphics.newImage("assets/classes/ss/soldier.png")
classes.soldier.ss.img_color = love.graphics.newImage("assets/classes/ss/soldier_color.png")
classes.soldier.range = 32
classes.soldier.dmg = 250
classes.soldier.hp = 100
classes.soldier.speed = 100
classes.soldier.shoot_t = 0.25
classes.soldier.alt_t = 0.1
classes.soldier.alt = function(self,dt,player)
  -- SHIELD
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


return classes
