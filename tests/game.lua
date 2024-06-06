vector = require("vector")
local width = 2000
local height = 2000

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
	local i = math.floor(point.x / w)
	local j = math.floor(point.y / w)
	print(i .. j)
	grid[i][j] = point
	table.insert(active, point)
	-- printgrid()
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
function printgrid()
	for i, col in pairs(grid) do
		for j, row in pairs(col) do
			print(grid[i][j])
		end
	end
end
setup()

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
