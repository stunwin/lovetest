Class = require("classic")
Rendermanager = Class:extend()

function Rendermanager:new()
	-- self.Colors = Config.COLORS
end

function Rendermanager:test()
	print(self.Colors["White"])
end
function Rendermanager:render(arr)
	for _, obj in pairs(arr) do
		local render_x, render_y = Cam:map_to_render(obj.x, obj.y)
		if not Cam:is_visible(obj) then
			goto continue
		end

		love.graphics.setColor(Config.COLORS[obj.color])
		love.graphics.circle("fill", render_x, render_y, obj.size * Cam.scale)

		if obj.role == "supply" then
			love.graphics.setColor(Config.COLORS["Red"])
			love.graphics.circle("fill", render_x - 30, render_y - 30, 10)
		elseif obj.role == "produce" then
			love.graphics.setColor(Config.COLORS["Amber"])
			love.graphics.circle("fill", render_x, render_y - 45, obj.fleet)
		end

		::continue::

		self:Render_Tooltip(obj)
	end
	local cam_coord = ("x = " .. Cam.x .. " y = " .. Cam.y .. " scale = " .. Cam.scale)
	love.graphics.setColor(Config.COLORS["White"])
	love.graphics.print(cam_coord, 0, 0)
end

function Rendermanager:Render_Tooltip(obj)
	local mouse_x, mouse_y = love.mouse.getPosition()
	if obj.hover then
		love.graphics.print(obj:Update_Tooltip(), mouse_x, mouse_y)
	end
end

return Rendermanager
