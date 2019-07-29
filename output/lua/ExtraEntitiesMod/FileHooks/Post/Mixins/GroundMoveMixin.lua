
GroundMoveMixin.networkVars["standingOnEntId"] = "entityid"

local oldInit = GroundMoveMixin.__initmixin
function GroundMoveMixin:__initmixin()
	oldInit(self)
	self.standingOnEntId = Entity.invalidId
end



local GetIsCloseToGround = debug.getupvaluex(GroundMoveMixin.UpdatePosition, "GetIsCloseToGround")
local UpdateOnGround = debug.getupvaluex(GroundMoveMixin.UpdatePosition, "UpdateOnGround")
local DoStepMove = debug.getupvaluex(GroundMoveMixin.UpdatePosition, "DoStepMove")


function GroundMoveMixin:UpdateOnEntity()
	
	if self.isOnEntity then
		local onGround, _, hitEntities, surfaceMaterial = GetIsCloseToGround(self, 0.15)
		if hitEntities ~= nil and #hitEntities > 0 then
			self.standingOnEntId = hitEntities[1]:GetId()
			return
		end
	end
	self.standingOnEntId = Entity.invalidId
	
end


function GroundMoveMixin:GetGroundEntityVel(callNum)
	if callNum and callNum > 16 then
		return Vector(0,0,0)
	end
	if self:GetIsOnEntity() and self.standingOnEntId and Shared.GetEntity(self.standingOnEntId) then
		local movingPlatform = Shared.GetEntity(self.standingOnEntId)
		if movingPlatform.vel then
			return movingPlatform.vel
		end
		if movingPlatform.GetGroundEntityVel and movingPlatform.GetVelocity then
			if not callNum then
				callNum = 0
			end
			return movingPlatform:GetGroundEntityVel(callNum + 1) + movingPlatform:GetVelocity()
		end
	end
	
	return Vector(0,0,0)
end

local oldApplyFriction = debug.getupvaluex(GroundMoveMixin.UpdateMove, "ApplyFriction")
local function ApplyFriction(self, input, velocity, deltaTime)

	self:UpdateOnEntity()
	
	velocity:Add( -self:GetGroundEntityVel())
	
	if oldApplyFriction then
		oldApplyFriction(self, input, velocity, deltaTime)
	end
	
	
end
debug.setupvaluex(GroundMoveMixin.UpdateMove, "ApplyFriction", ApplyFriction)

local oldUpdatePosition = GroundMoveMixin.UpdatePosition
function GroundMoveMixin:UpdatePosition(input, velocity, deltaTime)
	
	velocity:Add(self:GetGroundEntityVel())
	if oldUpdatePosition then
		oldUpdatePosition(self, input, velocity, deltaTime)
	end
	
end
