
local oldUpdateBodyYaw = debug.getupvaluex(Player.OnProcessMove, "UpdateBodyYaw")

local function UpdateBodyYaw(self, deltaTime, tempInput)
	
	local oldVel = self:GetVelocity()
	self:SetVelocity(oldVel - self:GetGroundEntityVel())
	oldUpdateBodyYaw(self, deltaTime, tempInput)
	--Log("%s should be zero because of %s", self:GetVelocity(), velocity)
	self:SetVelocity(oldVel)
	
	
end

debug.setupvaluex(Player.OnProcessMove, "UpdateBodyYaw", UpdateBodyYaw)