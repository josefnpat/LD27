local game_state = {}

function game_state:enter()
  bullet.init()
  map.init()
  waves.init()
  players.init()
end

function game_state:init()
--  players.real_init()
--  game_state:enter()
end

function game_state:update(dt)
  players.update(dt)
  bullet.update(dt)
  waves.update(dt)
  map.update(dt)
end

function game_state:draw()
  map.draw()
  bullet.draw()
  players.draw()
  waves.draw()
  
  if waves.gameover then
    local f = (1-waves.gameover_countdown_dt/waves.gameover_countdown_t)*255
    love.graphics.setColor(0,0,0,f)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(colors.reset)
    love.graphics.printf("GAME OVER",0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
  end
end

return game_state
