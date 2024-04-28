local CPActionButton = LibStub("CPActionButton")

local function SetTooltip_Hook(self)
	local type, action = self:GetAction()

	local macroText
	if type == "action" then
		local actionType, id, subType = GetActionInfo(action)

		if actionType ~= "macro" then return end

		-- GetActionInfo returns invalid ID values for macros in 10.2.0+, try getting the macro by its name
		-- https://github.com/Stanzilla/WoWUIBugs/issues/495
		local macroName = GetActionText(action)

		if not macroName or macroName == "" then
			return
		end

		macroText = GetMacroBody(macroName)

		if not macroText then
			return
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

local hasHookedMetatables = false

local function CPActionButton_InitButton_Hook(self, button, id, header)
	-- Only hook the :SetTooltip methods once
	if hasHookedMetatables then
		return
	end

	button:SetAttribute("state", "0")

	button:SetState("0", "action", 1) -- Set the button's kind to "action" and its metatable to Action
	HookMeta(button)             -- Hook the Action metatable

	button:SetState("0", "macro", 1) -- Set the button's kind to "macro" and its metatable to Macro
	HookMeta(button)             -- Hook the Macro metatable

	button:SetAttribute("state", nil)

	button:ClearStates()         -- Clear the button's states

	hasHookedMetatables = true
end

hooksecurefunc(CPActionButton, "InitButton", CPActionButton_InitButton_Hook)
