local build = {}

-- BOX
build[1] = {}
build[1].tile = 2
build[1].hp = 100
build[1].slow = 0.1
build[1].cost = 100

-- CAT GUN
build[2] = {}
build[2].tile = 3
build[2].hp = 25
build[2].slow = 0.25
build[2].cost = 200
build[2].dmg = 5
build[2].shoot_t = 0.1
build[2].range = 256
build[2].ss = {}
build[2].ss.img = classes.medic.ss.img
build[2].update = function(self,dt,mx,my,tile)
  if not tile.shoot_dt then tile.shoot_dt = self.shoot_t end
  tile.shoot_dt = tile.shoot_dt - dt
  if tile.shoot_dt <= 0 then
    local x = (mx)*32-16
    local y = (my)*32-16
    local target
    local best_dist = self.range
    for i,v in pairs(waves.data) do
      local dist = math.dist(v.x,v.y,x,y)
      if dist < self.range and dist < best_dist then
        target = {x=v.x,y=v.y}
        best_dist = dist
      end
    end
    if target then
      local testr = -math.atan2(target.x-x,target.y-y)+math.pi/2
      tile.shoot_dt = self.shoot_t
      bullet.new({
        x = x,
        y = y,
        r = testr,
        classes = self,
        range = self.range
      })
    end
  end
end
-- MONEY
build[3] = {}
build[3].tile = 4
build[3].hp = 20
build[3].slow = 0.5
build[3].cost = 300
build[3].money = 5
build[3].dmg = build[2].dmg
build[3].shoot_t = 0.25
build[3].range = 384
build[3].ss = {}
build[3].ss.img = classes.medic.ss.img
build[3].update = function(self,dt,mx,my,tile)
  players.money = players.money + self.money*dt
  
  if not tile.shoot_dt then tile.shoot_dt = self.shoot_t end
  tile.shoot_dt = tile.shoot_dt - dt
  if tile.shoot_dt <= 0 then
    local x = (mx)*32-16
    local y = (my)*32-16
    local target
    local best_dist = self.range
    for i,v in pairs(waves.data) do
      local dist = math.dist(v.x,v.y,x,y)
      if dist < self.range and dist < best_dist then
        target = {x=v.x,y=v.y}
        best_dist = dist
      end
    end
    if target then
      local testr = -math.atan2(target.x-x,target.y-y)+math.pi/2
      tile.shoot_dt = self.shoot_t
      bullet.new({
        x = x,
        y = y,
        r = testr,
        classes = self,
        range = self.range
      })
    end
  end
  
end


return build
