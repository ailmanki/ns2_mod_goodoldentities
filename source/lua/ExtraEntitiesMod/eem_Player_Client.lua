--________________________________
--
--   	NS2 CustomEntitesMod
--	Made by JimWest 2012
--
--________________________________

local overrideOnClientDisconnected = OnClientDisconnected
function OnClientDisconnected(reason)    
    if self.gEemToolTipScript then
        GetGUIManager():DestroyGUIScriptSingle(self.gEemToolTipScript)
        self.gEemToolTipScript  = nil
    end
    
    overrideOnClientDisconnected(reason)
end

