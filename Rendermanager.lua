Class = require("classic")
Rendermanager = Class:extend()

function Rendermanager:new(config)
	self.Colors = config.COLORS
end

function Rendermanager:render(arr)
	for _, planet in pairs(arr) do
		local render_x = planet.x * Cam.scale - Cam.x
		local render_y = planet.y * Cam.scale - Cam.y
		if render_x < 0 or render_x > Cam.width or render_y < 0 or render_y > Cam.height then
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

		love.graphics.setColor(love.math.colorFromBytes(self.Colors[planet.color]))
		love.graphics.circle("fill", render_x, render_y, planet.size * Cam.scale)
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
	local cam_coord = ("x = " .. Cam.x .. " y = " .. Cam.y .. " scale = " .. Cam.scale)
	love.graphics.setColor(self.Colors[White])
	love.graphics.print(cam_coord, 0, 0)
end
return Rendermanager
