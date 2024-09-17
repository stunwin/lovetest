function love.load()
	math.randomseed(os.time())
	Class = require("classic")
	Gameobject = require("Gameobject")
	Planet = require("Planet")
	Camera = require("Camera")
	Controller = require("Controller")
	h = require("Helper")
	Config = require("config")
	Gamemanager = require("Gamemanager")
	Rendermanager = require("Rendermanager")

	Render = Rendermanager(Config)
	SupplySpeed = 1
	Cam = Camera(0, 0, Config.CAM_WIDTH, Config.CAM_HEIGHT)
	Planetlist = Gamemanager:PlanetFactory()
	Mouse_Drag = false
	Render_List = {}
end

function love.update(dt)
	Render_List = Gamemanager:Populate_Render(Planetlist)

	Controller:Mouse_Input(Render_List)
	Controller:Key_Input()

	-- TODO: make an update function that is called every turn
	-- include total planet list, and onscreen list
	for _, planet in pairs(Planetlist) do
		planet:make(dt, SupplySpeed)
	end
end

function love.draw()
	Rendermanager:render(Render_List)

	local cam_coord = ("x = " .. Cam.x .. " y = " .. Cam.y .. " scale = " .. Cam.scale)
	love.graphics.setColor(Config.COLORS["White"])
	love.graphics.print(cam_coord, 0, 0)

	-- NOTE: this will definitely come back to bite you
	Render_List = {}
end
