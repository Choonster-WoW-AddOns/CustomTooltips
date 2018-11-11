-- List globals here for Mikk's FindGlobals script
-- GLOBALS: getmetatable, hooksecurefunc, CustomTooltips, GetActionInfo, GetMacroBody

local LibActionButton = LibStub("LibActionButton-1.0-ElvUI")

local function SetTooltip_Hook(self)	
	local type, action = self:GetAction()
	
	local macroIndex
	if type == "action" then
		local actionType, id, subType = GetActionInfo(action)
		if actionType == "macro" then
			macroIndex = id
		end
	elseif type == "macro" then
		macroIndex = action
	end
	
	if not macroIndex then return end
	
	local macroText = GetMacroBody(macroIndex)
	if macroText then
		CustomTooltips.DisplayTooltipForMacroText(self, macroText)
	end
end

-- Hook the :SetTooltip method of the button's metatable index
local function HookMeta(button) 
	local methods = getmetatable(button).__index
	
	hooksecurefunc(methods, "SetTooltip", SetTooltip_Hook)
end

LibActionButton.RegisterCallback("CustomTooltips_ElvUI", "OnButtonCreated", function(_, button)
	-- Only hook the :SetTooltip methods once
	LibActionButton.UnregisterCallback("CustomTooltips_ElvUI", "OnButtonCreated")

	button:SetState(0, "action", 1) -- Set the button's kind to "action" and its metatable to Action
	HookMeta(button) -- Hook the Action metatable
	
	button:SetState(0, "macro", 1) -- Set the button's kind to "macro" and its metatable to Macro
	HookMeta(button) -- Hook the Macro metatable
	
	button:ClearStates() -- Clear the button's states
end)
