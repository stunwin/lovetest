require("Gameobject")

Planet = Gameobject:extend()
local roles = { "supply", "produce" }

function Planet:new(x, y, planet_code, player)
	Planet.super.new(self, x, y)
	-- assert(role == "supply" or role == "produce", "incorrect role assignment")
	self.x = math.floor(x)
	self.y = math.floor(y)
	self.code = planet_code
	self.playerowned = player
	self.size = 30

	if self.playerowned then
		self.role = roles[self.roleindex]
		self.fleet = 0
		self.supply = 0
		self.roleindex = 1
	else
		self.role = "enemy"
		self.fleet = 10
		self.supply = 0
		self.roleindex = 1
	end

	self.supplyOutput = ("Supply: " .. self.supply .. "Fleet:" .. self.fleet)
	self.hover = false
	self.color = White
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
	if self:distance(mouse_x, mouse_y) then
		self.hover = true
		self:ColorSet()
		if love.mouse.isDown(1) and not self.debounce then
			self:RoleSwap()
		end
		self.debounce = love.mouse.isDown(1)
	else
		self.hover = false
		self:ColorSet()
	end
end

function Planet:DrawPlanet() end

function Planet:ColorSet()
	if self.hover then
		self.color = White
	elseif self.playerowned then
		self.color = Amber
	else
		self.color = Green
	end
end

function Planet:RoleSwap()
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
