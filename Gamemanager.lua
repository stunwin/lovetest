Class = require("classic")

Gamemanager = Class:extend()

function Gamemanager.new(config) end

function Gamemanager:PlanetFactory()
	local list = Config.PLANETNAMES
	local width = Config.WORLD_WIDTH
	local height = Config.WORLD_HEIGHT
	local p = 1
	local planets = {}
	local isPlayer = false

	for i = 1, 5 do
		for j = 1, 5 do
			if p == 13 then
				isPlayer = true
			else
				isPlayer = false
			end
			local x = (((0.8 * width) / 5) * i) + math.random(-20, 20)
			local y = (((0.8 * height) / 5) * j) + math.random(-20, 20)
			print(tostring(x) .. tostring(y))

			table.insert(planets, Planet(x, y, list[p], isPlayer))
			p = p + 1
		end
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
