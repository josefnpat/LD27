dong = require("libs/dong")

controls = require("controls")
players = require("players")

colors = require("colors")
map = require("map")
classes = require("classes")
enemies = require("enemies")
bullet = require("bullet")
waves = require("waves")
build = require("build")

gamestate = require("libs/gamestate")

states = {}
states.select = require("state_select")
states.game = require("state_game")
states.over = require("state_over")

function love.load()
  gamestate.registerEvents()
  gamestate.switch(states.select)
end


function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function math.dist(x1,y1,x2,y2)
  return math.sqrt( (x1-x2)^2 + (y1-y2)^2 )
end

function table.loopshift(table,current)
  local first
  local get
  for i,v in pairs(table) do

    if not first then first = v end

    if get then
      return v
    end

    if v == current then
      get = true
    end
  end

  return first

end

function table.random(table)
  local find = math.random(1,#table)
  local index = 0
  for _,v in pairs(table) do
    index = index + 1
    if index == find then
      return v
    end

  end
end

function math.randomd()
  return math.random(0,1)*2-1
end
