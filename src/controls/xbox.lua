local xbox_base = {}

xbox_base.name = "Xbox 360 Controller"

xbox_base.direction = function(self,player)
  local x,y = dong.rs(self.js)
  local dir = -math.atan2(x,y)+math.pi/2
  return dir
end

xbox_base.shoot = function(self,player)
  if dong.isDown(self.js,"RB") then
    return true
  end
end

xbox_base.alt = function(self,player)
  if dong.isDown(self.js,"LB") then
    return true
  end
end

xbox_base.move = function(self,player)
  local x,y = dong.ls(self.js)
  local d = math.dist(x,y,0,0)
  if d > 0.95 then
    return -math.atan2(x,y)+math.pi/2
  end
end

xbox_base.join_wait = false
xbox_base.join = function(self,player)
  if not self.join_wait and dong.isDown(self.js,"A") then
    self.join_wait = true
    return true
  end
  if not dong.isDown(self.js,"A") then
    self.join_wait = false
  end
end

xbox_base.build_wait = false
xbox_base.build = function(self,player)
  if not self.build_wait and dong.isDown(self.js,"RB") then
    self.build_wait = true
    return true
  end
  if not dong.isDown(self.js,"RB") then
    self.build_wait = false
  end
end

local xboxs = {}

for i = 1,4 do
  local tmp = {}
  for xi,xv in pairs(xbox_base) do
    tmp[xi] = xv
  end
  tmp.js = i
  xboxs[i] = tmp
end


return xboxs
