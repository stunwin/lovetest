Class = require("classic")

Controller = Class:extend()

function Controller:new()
	self.debounce = false
	self.old_x = 0
	self.old_y = 0
end

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

function Controller:Mouse_Input(Render_List)
	local mouse_x, mouse_y = love.mouse.getPosition()

	local click_object = self:Hover_Check(mouse_x, mouse_y, Render_List)

	if love.mouse.isDown(1) and click_object and not self.debounce then
		click_object:On_Click()
	elseif love.mouse.isDown(1) then
		if Mouse_Drag then
			local xdiff = mouse_x - self.old_x
			local ydiff = mouse_y - self.old_y
			Cam.x = Cam.x - xdiff
			Cam.y = Cam.y - ydiff
			self.old_x = mouse_x
			self.old_y = mouse_y
		end

		Mouse_Drag = true
		self.old_x = mouse_x
		self.old_y = mouse_y
	else
		Mouse_Drag = false
	end
	self.debounce = love.mouse.isDown(1)
end

function Controller:Hover_Check(mouse_x, mouse_y, arr)
	for i, planet in ipairs(arr) do
		local rx, ry = Cam:map_to_render(planet.x, planet.y)
		local rscale = planet.size * Cam.scale
		if not Helper.distance(mouse_x, mouse_y, rx, ry, rscale) then
			planet.hover = false
		else
			planet.hover = true
			return planet
		end
	end
	-- return false
end
return Controller
