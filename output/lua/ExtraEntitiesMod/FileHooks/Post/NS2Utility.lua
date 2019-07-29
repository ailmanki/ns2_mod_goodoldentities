
local oldSetPlayerPoseParameters = SetPlayerPoseParameters
function SetPlayerPoseParameters(player, viewModel, headAngles)
	
	oldSetPlayerPoseParameters(player, viewModel, headAngles)
	
	
	local velocity = Vector(0,0,0)
	
	if player.GetGroundEntityVel and player:GetGroundEntityVel():GetLength() > 0 then
		local velocity = player:GetVelocityFromPolar() - player:GetGroundEntityVel()
		-- Not all players will contrain their movement to the X/Z plane only.
		if player.GetMoveSpeedIs2D and player:GetMoveSpeedIs2D() then
			velocity.y = 0
		end
		
		local headCoords = headAngles:GetCoords()

		local x = Math.DotProduct(headCoords.xAxis, velocity)
		local z = Math.DotProduct(headCoords.zAxis, velocity)
		local moveYaw = Math.Wrap(Math.Degrees( math.atan2(z,x) ), -180, 180)

		local moveSpeed = velocity:GetLength() / player:GetMaxSpeed(true)
		
		player:SetPoseParam("move_yaw", moveYaw)
		player:SetPoseParam("move_speed", moveSpeed)
		if viewModel then
			viewModel:SetPoseParam("move_speed", moveSpeed)
			viewModel:SetPoseParam("move_yaw", moveYaw)
		end
	end
	
end