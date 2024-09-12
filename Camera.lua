require("Gameobject")

Camera = Gameobject:extend()

function Camera:new(x, y, width, height)
	Camera.super.new(self, x, y)

	self.x = x
	self.y = y
	self.scale = 1
	self.width = width
	self.height = height
end

function Camera:map_to_render(map_x, map_y)
	--take global coordinates and convert them into camera coordinates
	local render_x = map_x * self.scale - self.x
	local render_y = map_y * self.scale - self.y

	return render_x, render_y
end
function Camera:render_to_map(render_x, render_y)
	-- take coordinates from a camera object and convert them into global coordinates
	local map_x = (render_x - self.x) / self.scale
	local map_y = (render_y - self.y) / self.scale

	return map_x, map_y
end
function Camera:is_visible(x, y)
	-- checks to see if an object is in the camera view
	local render_x, render_y = self:map_to_render(x, y)
	if render_x < 0 or render_x > self.width or render_y < 0 or render_y > self.height then
		return false
	else
		return true
	end
end

function Camera:render()
	for _, planet in pairs(PlanetList) do
		local render_x = planet.x * self.scale - self.x
		local render_y = planet.y * self.scale - self.y
		if render_x < 0 or render_x > self.width or render_y < 0 or render_y > self.height then
			goto continue
		end

		local supplyOutput = (
			render_x
			.. " "
			.. render_y
			.. "name: "
			.. planet.code
			.. " Supply: "
			.. math.floor(planet.supply)
			.. " Fleet:"
			.. math.floor(planet.fleet)
		)

		love.graphics.setColor(love.math.colorFromBytes(planet.color))
		love.graphics.circle("fill", render_x, render_y, planet.size * self.scale)
		if planet.hover then
			love.graphics.print(supplyOutput, render_x - 40, render_y + 30)
		end

		if planet.role == "supply" then
			love.graphics.setColor(love.math.colorFromBytes(Red))
			love.graphics.circle("fill", render_x - 30, render_y - 30, 10)
		elseif planet.role == "produce" then
			love.graphics.setColor(love.math.colorFromBytes(Amber))
			love.graphics.circle("fill", render_x, render_y - 45, planet.fleet)
		end

		::continue::
	end
end

return Camera
