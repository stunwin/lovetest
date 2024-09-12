Class = require("classic")

Controller = Class:extend()

function Controller:new() end

function Controller:Key_Input()
	function love.keypressed(k)
		if k == "escape" then
			love.event.quit()
		elseif k == "h" then
			Cam.x = Cam.x - 10
		elseif k == "j" then
			Cam.y = Cam.y + 10
		elseif k == "k" then
			Cam.y = Cam.y - 10
		elseif k == "l" then
			Cam.x = Cam.x + 10
		elseif k == "t" then
			Cam.scale = Cam.scale + 0.1
			Cam.x = math.floor(Cam.x + Cam.width * 0.05)
			Cam.y = math.floor(Cam.y + Cam.height * 0.05)
		elseif k == "g" then
			Cam.scale = Cam.scale - 0.1
			Cam.x = math.floor(Cam.x - Cam.width * 0.05)
			Cam.y = math.floor(Cam.y - Cam.height * 0.05)
		end
	end
end

function Controller:Mouse_Input()
	local mouse_x, mouse_y = love.mouse.getPosition()

	self:Hover_Check(mouse_x, mouse_y)

	if love.mouse.isDown(1) then
		if Mouse_Drag then
			local xdiff = mouse_x - old_x
			local ydiff = mouse_y - old_y
			Cam.x = Cam.x - xdiff
			Cam.y = Cam.y - ydiff
			old_x = mouse_x
			old_y = mouse_y
		end
		Mouse_Drag = true
		old_x = mouse_x
		old_y = mouse_y
	else
		Mouse_Drag = false
	end
end

function Controller:Hover_Check(mouse_x, mouse_y)
	for i, planet in pairs(PlanetList) do
		if Cam:is_visible(planet.x, planet.y) then
			planet.hover = true
		else
			planet.hover = false
		end
	end
end
return Controller
