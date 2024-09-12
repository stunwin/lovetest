Class = require("classic")
Func = Class:extend()

function Func:new() end

function Func.test(value)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.print(value, 200, 200)
end

function Func.distance(x1, y1, x2, y2, threshold)
	local distance = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
	if threshold then
		return distance < threshold
	else
		return distance
	end
end

return Func
