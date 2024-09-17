require("Gameobject")

Planet = Gameobject:extend()
local roles = { "supply", "produce" }

function Planet:new(x, y, planet_code, isPlayer)
	Planet.super.new(self, x, y)
	-- assert(role == "supply" or role == "produce", "incorrect role assignment")
	self.x = math.floor(x)
	self.y = math.floor(y)
	self.code = planet_code
	self.isPlayer = isPlayer
	self.size = 30

	if self.isPlayer then
		self.roleindex = 1
		self.role = roles[self.roleindex]
		self.fleet = 0
		self.supply = 0
	else
		self.role = "enemy"
		self.fleet = 10
		self.supply = 0
	end

	self.supplyOutput = ("Supply: " .. self.supply .. "Fleet:" .. self.fleet)
	self.hover = false
	self.color = "Red"
	self.debounce = false
end

function Planet:make(dt, SupplySpeed)
	if self.role == "supply" then
		self.supply = self.supply + (SupplySpeed * dt)
	elseif self.role == "produce" and math.floor(self.supply) > 0 then
		self.supply = self.supply - (SupplySpeed * dt)
		self.fleet = self.fleet + (SupplySpeed * dt * 0.5)
	elseif self.role == "enemy" then
		EnemyAI()
	end
end

function Planet:IsHover(mouse_x, mouse_y)
	local render_x, render_y = Camera.Map_To_Render(self.x, self.y)
	if h.distance(mouse_x, mouse_y, render_x, render_y, self.size) then
		self.hover = true
		if love.mouse.isDown(1) and not self.debounce then
			self:On_Click()
		end
		self.debounce = love.mouse.isDown(1)
	else
		self.hover = false
		self:ColorSet()
	end
end

function Planet:Update_Tooltip()
	local supplyOutput = (
		self.code
		.. "\nSupply: "
		.. math.floor(self.supply)
		.. "\nFleet: "
		.. math.floor(self.fleet)
		.. "\nRole: "
		.. tostring(self.role)
	)

	return supplyOutput
end

-- function Planet:ColorSet()
-- 	if self.hover then
-- 		self.color = "White"
-- 	elseif self.isPlayer then
-- 		self.color = "Amber"
-- 	else
-- 		self.color = "Green"
-- 	end
-- end

function Planet:On_Click()
	self.roleindex = self.roleindex + 1
	if self.roleindex > #roles then
		self.roleindex = 1
	end
	self.role = roles[self.roleindex]
end

function EnemyAI()

	-- literally no idea rn lol
end

return Planet
