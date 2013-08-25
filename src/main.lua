math.randomseed( os.time() )

git,git_count = "missing git.lua",0
pcall( function() return require("git") end );

dong = require("libs/dong")

require("libs/slam")

gamename = string.upper("Defense of Your Craft")

controls = require("controls")
players = require("players")
sfx = require("sfx")
colors = require("colors")
map = require("map")
classes = require("classes")
enemies = require("enemies")
bullet = require("bullet")
waves = require("waves")
build = require("build")
fonts = require("fonts")
love.graphics.setFont(fonts.small)

gamestate = require("libs/gamestate")

lovesplash = require("libs/lovesplash")
msssplash = require("libs/msssplash")
consplash = require("libs/consplash")

states = {}
states.splash = require("state_splash")
states.select = require("state_select")
states.game = require("state_game")

function love.load()
  gamestate.registerEvents()
  gamestate.switch(states.splash)
end

updatefps_t = 1
updatefps_dt = updatefps_t

function love.update(dt)
  updatefps_dt = updatefps_dt - dt
  if updatefps_dt <= 0 then
    updatefps_dt = updatefps_t
    love.graphics.setCaption(gamename.." - v" .. git_count .. " [" .. git .. "] "..love.timer.getFPS().." fps")
  end
end

function bg(img)
  local sx = love.graphics.getWidth()/img:getWidth()
  local xy = love.graphics.getHeight()/img:getHeight()
  love.graphics.draw(img,0,0,sy,sx)
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
  local c=0; for _,_ in pairs(table) do c=c+1; end 
  local find = math.random(1,c)
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
