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
	Controller = require("Controller")
	Func = require("game")

	SupplySpeed = 1
	Cam = Camera(0, 0, CAM_WIDTH, CAM_HEIGHT)
	PlanetFactory()
	Mouse_Drag = false
end

function love.update(dt)
	Controller:Mouse_Input()
	Controller:Key_Input()

	-- TODO: make an update function that is called every turn
	-- include total planet list, and onscreen list
	for _, planet in pairs(PlanetList) do
		planet:make(dt, SupplySpeed)
	end
end

function love.draw()
	Cam:render()
	-- TODO: make a debug function that can be toggled
	local cam_coord = ("x = " .. Cam.x .. " y = " .. Cam.y .. " scale = " .. Cam.scale)
	love.graphics.setColor(White)
	love.graphics.print(cam_coord, 0, 0)
end

-- TODO: make a game setup function that houses this and all  the other declarations and variables
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
