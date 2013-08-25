local enemies = {}

enemies.base = {}
enemies.base.hp = 50
enemies.base.img = love.graphics.newImage("assets/enemies/base.png")
enemies.base.speed = 125
enemies.base.sexyness = 128
enemies.base.nohomobro = 0.5
enemies.base.dmg = 50
enemies.base.value = 5

enemies.boss = {}
enemies.boss.hp = 300
enemies.boss.img = love.graphics.newImage("assets/enemies/boss.png")
enemies.boss.speed = 100
enemies.boss.sexyness = 512
enemies.boss.nohomobro = 0.1
enemies.boss.dmg = 100
enemies.boss.value = 20

return enemies
