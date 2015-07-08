local LibActionButton = LibStub("LibActionButton-1.0")

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

-- LibActionButton replaces the metatable of its buttons, so we need to retrieve the HookScript method from a regular CheckButton
local HookScript = getmetatable(CreateFrame("CheckButton")).__index.HookScript

LibActionButton.RegisterCallback("CustomTooltips_LibActionButton", "OnButtonCreated", function(_, button)
	HookScript(button, "OnEnter", Button_OnEnter_Hook)
end)