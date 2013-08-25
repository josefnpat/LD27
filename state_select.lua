local select_state = {}

select_state.start = 1
select_state.start_dt = select_state.start

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
  love.graphics.print("Press `enter` (keyboard & mouse) or `A` (xbox 360) to join.",32,0)
  for i,v in pairs(players.data) do
    local xoffset = love.graphics.getWidth()/(#players.data+1)*i
    local yoffset = love.graphics.getHeight()/2
    love.graphics.draw(v.classes.port,xoffset,yoffset,0,1,1,v.classes.port:getWidth()/2)
    love.graphics.print("Player "..i..": "..v.controls.name.." - "..v.classes.name,32,32*(i+1))
  end
  if select_state.start ~= select_state.start_dt then
    love.graphics.print(math.round(select_state.start_dt,1).." seconds to start.",32,32)
  end
end


return select_state
