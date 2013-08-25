local map = {}

map.tiles = love.graphics.newImage("assets/tiles.png")

map.baseimg = love.graphics.newImage("assets/base.png")

function map.init()
  map.size = {
    x=math.floor(love.graphics.getWidth()/32)+1,
    y=math.floor(love.graphics.getHeight()/32)+1
  }

  map.quads = {}
  local i = 0
  for y = 1,4 do
    for x = 1,4 do
      i = i + 1
      map.quads[i] = love.graphics.newQuad( (x-1)*32, (y-1)*32, 32, 32, 128, 128 )
    end
  end

 map.data = {}
  for i = 1,map.size.y do
    map.data[i] = {}
    for j = 1,map.size.x do
      map.data[i][j] = {
        tile=1,
        level=0
      }
    end
  end
end

function map.draw(x,y)
  for y,xdat in pairs(map.data) do
    for x,v in pairs(xdat) do
      if v.level > 0 then
        local fade = v.hp/build[v.level].hp*255
        love.graphics.setColor(255,fade,fade)
      end
      love.graphics.drawq(map.tiles,map.quads[v.tile],(x-1)*32,(y-1)*32)
      love.graphics.setColor(colors.reset)
      love.graphics.print(v.tile,x*32,y*32)
    end
  end
  love.graphics.draw(map.baseimg,love.graphics.getWidth()/2,love.graphics.getHeight()/2,0,1,1,32,32)
end

function map.update(dt)
  for iy,ydat in pairs(map.data) do
    for ix,dat in pairs(ydat) do
      if dat.level > 0  and build[dat.level].update then
        build[dat.level]:update(dt,ix,iy,dat)
      end
    end
  end
end

return map
