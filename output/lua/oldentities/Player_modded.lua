--________________________________
--
--   	NS2 Single-Player Mod   
--  	Made by JimWest, 2012
--
--________________________________

Script.Load("lua/Class.lua")
Script.Load("lua/Player.lua")

-- original network variables are not deleted
local networkVars =
{
    gravityTrigger = "entityid",
    -- add this to all players so they see the teleport effect
    timeOfLastPhase = "private time",
}

-- override for the gravity trigger
function Player:AdjustGravityForceOverride(gravity)
    if self.gravityTrigger and self.gravityTrigger ~= 0 then
        local ent = Shared.GetEntity(self.gravityTrigger)
        if ent then
            gravity = ent:GetGravityOverride(gravity) 
        end
    end
    return gravity
end




Class_Reload("Player", networkVars)