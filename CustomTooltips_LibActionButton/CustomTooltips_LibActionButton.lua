local LibActionButton = LibStub("LibActionButton-1.0", true)

if not LibActionButton then
	local addon, ns = ...
	DisableAddOn(addon)
	print(addon .. " has been automatically disabled because you don't have any AddOns that provide LibActionButton installed. You can manually re-enable it when you install one.")
	return
end

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

LibActionButton.RegisterCallback("CustomTooltips_LibActionButton", "OnButtonCreated", function(_, button)
	button:HookScript("OnEnter", Button_OnEnter_Hook)
end)