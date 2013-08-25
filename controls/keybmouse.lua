local keybmouse = {}

keybmouse.name = "Keyboard & Mouse"

keybmouse.direction = function(self,player)
  local x = love.mouse.getX() - player.x
  local y = love.mouse.getY() - player.y

  local dist = math.dist(x,y,0,0)

  local dir = player.r
  if dist > 8 then
    dir = -math.atan2(x,y)+math.pi/2
  end
  return dir
end

keybmouse.shoot = function(self,player)
  if love.mouse.isDown("l") then
    return true
  end
end

keybmouse.alt = function(self,player)
  if love.mouse.isDown("r") then
    return true
  end
end

keybmouse.move = function(self,player)
  if love.keyboard.isDown("w") then
    return true
  end
end

keybmouse.join_wait = false
keybmouse.join = function(self,player)
  if not self.join_wait and love.keyboard.isDown("return") then
    self.join_wait = true
    return true
  end
  if not love.keyboard.isDown("return") then
    self.join_wait = false
  end
end

keybmouse.build_wait = false
keybmouse.build = function(self,player)
  if not self.build_wait and love.mouse.isDown("l") then
    self.build_wait = true
    return true
  end
  if not love.mouse.isDown("l") then
    self.build_wait = false
  end
end

return keybmouse
