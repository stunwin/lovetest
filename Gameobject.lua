Class = require("classic")

Gameobject = Class:extend()

function Gameobject:new(x, y)
	self.x = x
	self.y = y
end

return Gameobject
