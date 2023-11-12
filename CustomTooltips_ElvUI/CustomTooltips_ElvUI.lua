local LibActionButton = LibStub("LibActionButton-1.0-ElvUI")

local function SetTooltip_Hook(self)
	local type, action = self:GetAction()

	local macroText
	if type == "action" then
		local actionType, id, subType = GetActionInfo(action)

		if actionType ~= "macro" then return end

		-- First try using the ID as a macro index
		macroText = GetMacroBody(id)

		-- If that doesn't work (5.2.0), try getting the macro by its name
		-- https://github.com/Stanzilla/WoWUIBugs/issues/495
		if not macroText then
			local macroName = GetActionText(self.action)

			macroText = GetMacroBody(macroName)
		end
	elseif type == "macro" then
		macroText = GetMacroBody(action)
	end

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
