--
-- TODO: rename me to like func or helper or something
--
Class = require("classic")
Func = Class:extend()
vector = require("vector")
function Func:new() end

function Func.test(value)
	love.graphics.setColor(255, 255, 255, 1)
	love.graphics.print(value, 200, 200)
end

function Func.Map_To_Render(map_x, map_y)
	local render_x = map_x * Cam.scale - Cam.x
	local render_y = map_y * Cam.scale - Cam.y

	return render_x, render_y
end
function Func.Render_To_Map(render_x, render_y)
	local map_x = (render_x - Cam.x) / Cam.scale
	local map_y = (render_y - Cam.y) / Cam.scale

	return map_x, map_y
end
function Func.distance(x1, y1, x2, y2, threshold)
	if math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) < threshold then
		return true
	end
end

-- NOTE: hey the normal algorithm goes until it fills the screen, we don't want to do that. n is the number of points to be generated
function Func.poisson(width, height, n)
	-- minimum distance between points
	local r = 100
	-- maximum tries before discarding candidiate point
	local k = 30
	-- width of each grid square
	local w = math.floor(r / math.sqrt(2))
	-- the list of active points that need to be tested
	local active = {}
	-- initialize array of grid squares
	local cols = width / w
	local rows = height / w
	local grid = {}
	local function setup()
		for i = 1, cols do
			grid[i] = {}
			for j = 1, rows do
				grid[i][j] = -1
			end
		end
		local fx = math.floor(math.random(1, width))
		local fy = math.floor(math.random(1, height))
		local point = vector(fx, fy)
		print(point)
		local i = math.floor(fx / w)
		local j = math.floor(fy / w)
		print(i .. j)
		grid[i][j] = point
		table.insert(active, point)
	end

	local function newpoint()
		if #active > 0 then
			local i = math.floor(math.random(#active))
			local pos = active[i]
			for j = 1, k do
				local sample = vector.randon()
				local m = math.random(r, 2 * r)
				sample:setmag(m)
				sample = sample + pos
				if test_sample(sample) then
					table.insert(active, sample)
					local x = math.floor(sample.x / w)
					local y = math.floor(sample.x / w)
					grid[x][y] = sample
					break
				elseif j == k - 1 then
					table.remove(active[i])
				end
			end
		end
	end

	setup()
	return grid
	-- for i, col in pairs(grid) do
	-- 	for j, row in pairs(col) do
	-- 		if grid[i][j] ~= -1 then
	-- 			local dx = grid[i][j].x
	-- 			local dy = grid[i][j].y
	-- 			love.graphics.setColor(255, 255, 255, 1)
	-- 			love.graphics.circle("fill", dx, dy, 10)
	-- 		end
	-- 	end
	-- end
end

return Func
