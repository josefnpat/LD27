local enemies = {}

enemies.small_easy = {}
enemies.small_easy.hp = 50
enemies.small_easy.img = love.graphics.newImage("assets/enemies/small_easy.png")
enemies.small_easy.speed = 125
enemies.small_easy.sexyness = 128
enemies.small_easy.nohomobro = 0.5
enemies.small_easy.dmg = 5
enemies.small_easy.value = 10

enemies.large_easy = {}
enemies.large_easy.hp = 200
enemies.large_easy.img = love.graphics.newImage("assets/enemies/large_easy.png")
enemies.large_easy.speed = 100
enemies.large_easy.sexyness = 512
enemies.large_easy.nohomobro = 0.1
enemies.large_easy.dmg = 10
enemies.large_easy.value = 40

enemies.small_hard = {}
enemies.small_hard.hp = 50*10
enemies.small_hard.img = love.graphics.newImage("assets/enemies/small_hard.png")
enemies.small_hard.speed = 125*1.1
enemies.small_hard.sexyness = 128*10
enemies.small_hard.nohomobro = 0.5
enemies.small_hard.dmg = 5*10
enemies.small_hard.value = 8*10

enemies.large_hard = {}
enemies.large_hard.hp = 200*10
enemies.large_hard.img = love.graphics.newImage("assets/enemies/large_hard.png")
enemies.large_hard.speed = 100*1.1
enemies.large_hard.sexyness = 512*10
enemies.large_hard.nohomobro = 0.1
enemies.large_hard.dmg = 10*10
enemies.large_hard.value = 16*10

return enemies
