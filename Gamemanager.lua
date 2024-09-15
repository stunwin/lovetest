Class = require("classic")

Gamemanager = Class:extend()

function Gamemanager.new(config) end

function Gamemanager:PlanetFactory()
	local list = Config.PLANETNAMES
	local width = Config.WORLD_WIDTH
	local height = Config.WORLD_HEIGHT
	local planets = {}
	for i, planet in pairs(list) do
		if i == 1 then
			isPlayer = true
		else
			isPlayer = false
		end

		local x = math.random(40, width - 40)
		local y = i * (height - 100) / #list

		table.insert(planets, Planet(x, y, planet, isPlayer))
	end
	return planets
end

function Gamemanager:Populate_Render(...)
	arg = { ... }
	local renderlist = {}
	for _, i in ipairs(arg) do
		for _, j in ipairs(i) do
			if Cam:is_visible(j) then
				table.insert(renderlist, j)
			end
		end
	end
	return renderlist
end

return Gamemanager
