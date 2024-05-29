Class = require("classic")

Gameobject = Class:extend()

function Gameobject:new(x, y)
	self.x = x
	self.y = y
end

function Gameobject:distance(x2, y2)
	if math.sqrt((x2 - self.x) ^ 2 + (y2 - self.y) ^ 2) < self.size then
		return true
	end
end

return Gameobject
