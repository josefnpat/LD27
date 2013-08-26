local controls = {}

controls[1] = require("controls/keybmouse")
local xboxs = require("controls/xbox")
for i,v in pairs(xboxs) do
  controls[#controls+1] = v
end

return controls
