local sfx = {}

sfx.data = {}


sfx.data.join = love.audio.newSource("assets/sfx/join.wav","static")
sfx.data.select = love.audio.newSource("assets/sfx/select.wav","static")
sfx.data.shoot = love.audio.newSource("assets/sfx/shoot.wav","static")
sfx.data.build = love.audio.newSource("assets/sfx/build.wav","static")
sfx.data.enemydeath = love.audio.newSource("assets/sfx/enemydeath.wav","static")
sfx.data.death = love.audio.newSource("assets/sfx/death.wav","static")
sfx.data.alt = love.audio.newSource("assets/sfx/alt.wav","static")
sfx.data.countdown = love.audio.newSource("assets/sfx/countdown.wav","static")

function sfx.play(asset)
  love.audio.stop(asset)
  love.audio.play(asset)
end

return sfx
