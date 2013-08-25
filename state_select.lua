local select_state = {}

select_state.start = 5

function select_state:init()
  select_state.modes = love.graphics.getModes()
  table.sort(select_state.modes, function(a, b) return a.width*a.height < b.width*b.height end)   -- sort from smallest to largest
  select_state.current_mode = #select_state.modes+1
end

function select_state:keypressed(key)

  if key == "m" then
    select_state.current_mode = select_state.current_mode - 1
    if select_state.current_mode < 1 then
      select_state.current_mode = #select_state.modes
    end
    local cm = select_state.modes[select_state.current_mode]
    local success = love.graphics.setMode( cm.width, cm.height )
  elseif key == "f" then
    love.graphics.toggleFullscreen()
  elseif key == "escape" then
    love.event.quit()
  end
end

function select_state:enter()
  select_state.start_dt = select_state.start
  players.real_init()
end

function select_state:update(dt)
  if #players.data > 0 then
    select_state.start_dt = select_state.start_dt - dt
  end
  if select_state.start_dt <= 0 then
    gamestate.switch(states.game)
  end
  for i,v in pairs(controls) do
    if v:join() then

      local already_joined = false
      for _,testv in pairs(players.data) do
        if testv.controls == v then
          already_joined = true
        end
      end

      if already_joined then
        sfx.play(sfx.data.select)
        local index
        for checki,checkv in pairs(players.data) do
          if checkv.controls == v then
            index = checki
          end
        end
        players.data[index].classes = 
          table.loopshift(
            classes,
            players.data[index].classes)
      else
        sfx.play(sfx.data.join)
        local index = #players.data+1
        players.data[index] = {}
        players.data[index].controls = v
        players.data[index].classes = table.random(classes)
      end
      select_state.start_dt = select_state.start
    end
  end
end

function select_state:draw()
  love.graphics.setFont(fonts.large)
  love.graphics.printf(gamename,0,love.graphics.getHeight()/2-192,love.graphics.getWidth(),"center")
  love.graphics.setFont(fonts.small)
  love.graphics.printf("Press `enter` (Keyboard & Mouse) or `A` (Xbox 360 Controller) to join.",0,love.graphics.getHeight()/2-64,love.graphics.getWidth(),"center")
  for i,v in pairs(players.data) do
    local xoffset = love.graphics.getWidth()/(#players.data+1)*i
    local yoffset = love.graphics.getHeight()/2
    local r,g,b = unpack(colors.players[i])
    love.graphics.setColor(r,g,b,127)
    
    love.graphics.rectangle("fill",
      xoffset-v.classes.port:getWidth()/2 - 16,
      yoffset - 16,
      v.classes.port:getWidth()+32,
      v.classes.port:getHeight()+32+16*6)
    love.graphics.setColor(colors.reset)
    love.graphics.draw(v.classes.port,xoffset,yoffset,0,1,1,v.classes.port:getWidth()/2)
    love.graphics.printf(
      "Player "..i.."\n"..v.controls.name.."\n"..v.classes.name.."\n"..v.classes.alt_des,
      xoffset-128,yoffset+v.classes.port:getHeight() + 16,
      256,
      "center")
  end
  if select_state.start ~= select_state.start_dt then
    love.graphics.setFont(fonts.large)
    love.graphics.printf(
      math.round(select_state.start_dt,1).." seconds to start.",
      0,
      love.graphics.getHeight()/2-128,
      love.graphics.getWidth(),
      "center")
    love.graphics.setFont(fonts.small)
  end
  love.graphics.print(
    "Current Resolution: "..love.graphics.getWidth().."x"..love.graphics.getHeight().."\n"..
    "Press `m` to change resolution.\n"..
    "Press `f` to toggle fullscreen.",32,32)
end

return select_state
