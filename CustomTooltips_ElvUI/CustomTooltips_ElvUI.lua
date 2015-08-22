local LibActionButton = LibStub("LibActionButton-1.0-ElvUI")

local function Button_OnEnter_Hook(self)	
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
		CustomTooltips_DisplayTooltip(self, macroText)
	end
end

LibActionButton.RegisterCallback("CustomTooltips_ElvUI", "OnButtonCreated", function(_, button)
	button:HookScript("OnEnter", Button_OnEnter_Hook)
end)