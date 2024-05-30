Class = require("classic")
Func = Class:extend()

function Func:new() end

function Func.test(value)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.print(value, 200, 200)
end

function Func.Map_To_Render(map_x, map_y)
	local render_x = map_x * Cam.scale - Cam.x
	local render_y = map_y * Cam.scale - Cam.y

	return render_x, render_y
end
function Func.Render_To_Map(render_x, render_y)
	local map_x = (render_x - Cam.x) / Cam.scale
	local map_y = (render_y - Cam.y) / Cam.scale

	return map_x, map_y
end
function Func.distance(x1, y1, x2, y2, threshold)
	if math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) < threshold then
		return true
	end
end
return Func
