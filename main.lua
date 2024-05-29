PlanetNames = { "Earth", "Mars", "Magrathea", "Alderaan", "bleek", "blork", "bloop" }
PlanetList = {}
CAM_WIDTH = 800
CAM_HEIGHT = 600
WORLD_WIDTH = 1200
WORLD_HEIGHT = 1000

White = { 255, 255, 255 }
Green = { 124, 252, 0 }
Red = { 196, 32, 32 }
Amber = { 230, 171, 21 }

function love.load()
	math.randomseed(os.time())
	Class = require("classic")
	Gameobject = require("Gameobject")
	Planet = require("Planet")
	Camera = require("Camera")
	love.window.setMode(CAM_WIDTH, CAM_HEIGHT, { resizable = false, vsync = 0, minwidth = 400, minheight = 300 })
	SupplySpeed = 1
	cam = Camera(0, 0, CAM_WIDTH, CAM_HEIGHT)
	PlanetFactory()
	drag = false
end

function love.update(dt)
	local mouse_x, mouse_y = love.mouse.getPosition()

	for i, planet in pairs(PlanetList) do
		planet:IsHover(mouse_x, mouse_y)
		planet:make(dt, SupplySpeed)
	end
	function love.keypressed(k)
		if k == "escape" then
			love.event.quit()
		elseif k == "h" then
			cam.x = cam.x - 10
		elseif k == "j" then
			cam.y = cam.y + 10
		elseif k == "k" then
			cam.y = cam.y - 10
		elseif k == "l" then
			cam.x = cam.x + 10
		elseif k == "t" then
			cam.scale = cam.scale + 0.1
			cam.x = math.floor(cam.x + cam.width * 0.05)
			cam.y = math.floor(cam.y + cam.height * 0.05)
		elseif k == "g" then
			cam.scale = cam.scale - 0.1
			cam.x = math.floor(cam.x - cam.width * 0.05)
			cam.y = math.floor(cam.y - cam.height * 0.05)
		end
	end
	if love.mouse.isDown(1) then
		if drag then
			xdiff = mouse_x - old_x
			ydiff = mouse_y - old_y
			cam.x = cam.x - xdiff
			cam.y = cam.y - ydiff
			old_x = mouse_x
			old_y = mouse_y
		end
		drag = true
		old_x = mouse_x
		old_y = mouse_y
	else
		drag = false
	end
end

function love.draw()
	cam:render()
	local cam_coord = ("x = " .. cam.x .. " y = " .. cam.y .. " scale = " .. cam.scale)
	love.graphics.setColor(White)
	love.graphics.print(cam_coord, 0, 0)
end

function PlanetFactory()
	for i, planet in pairs(PlanetNames) do
		if i == 1 then
			isPlayer = true
		else
			isPlayer = false
		end

		local x = math.random(40, WORLD_WIDTH - 40)
		local y = i * (WORLD_HEIGHT - 100) / #PlanetNames

		table.insert(PlanetList, Planet(x, y, planet, isPlayer))
	end
end
