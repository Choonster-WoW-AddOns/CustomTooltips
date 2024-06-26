--@alpha@
local function debugprint(name, ...)
	-- if not name:find("BonusLoot", 1, true) then return end
	print(name, ...)
end
--@end-alpha@

--[===[@non-alpha@
local function debugprint() end
--@end-non-alpha@]===]

local function SetTooltip_Hook(self)
	local actionType, id, subType = GetActionInfo(self.action)

	if actionType ~= "macro" then return end

	-- GetActionInfo returns invalid ID values for macros in 10.2.0+, try getting the macro by its name
	-- https://github.com/Stanzilla/WoWUIBugs/issues/495
	local macroName = GetActionText(self.action)

	if not macroName or macroName == "" then
		debugprint("CustomTooltips: Macro name is nil/empty", "ID", id, "Name", macroName, "Button", self:GetName())
		return
	end

	local macroText = GetMacroBody(macroName)

	if not macroText then
		debugprint("CustomTooltips: Macro is empty", "ID", id, "Button", self:GetName())
		return
	end

	CustomTooltips.DisplayTooltipForMacroText(self, macroText)
end

if ActionBarActionButtonMixin and ActionBarActionButtonMixin.SetTooltip then -- We're on Retail (10.1.0 or later), hook the mixins
	local ActionBarActionButtonMixin_SetTooltip_Old = ActionBarActionButtonMixin.SetTooltip
	local ActionBarActionButtonDerivedMixin_SetTooltip_Old = ActionBarActionButtonDerivedMixin.SetTooltip

	-- Hook the mixin functions to handle action buttons created dynamically
	hooksecurefunc(ActionBarActionButtonMixin, "SetTooltip", SetTooltip_Hook)
	hooksecurefunc(ActionBarActionButtonDerivedMixin, "SetTooltip", SetTooltip_Hook)

	-- Iterate through all existing frames to handle action buttons created statically
	local frame = EnumerateFrames()
	while frame do
		if frame.SetTooltip == ActionBarActionButtonMixin_SetTooltip_Old then
			hooksecurefunc(frame, "SetTooltip", SetTooltip_Hook)

			debugprint(frame:GetName() or frame, "hooked!")
		elseif frame.SetTooltip == ActionBarActionButtonDerivedMixin_SetTooltip_Old then
			hooksecurefunc(frame, "SetTooltip", SetTooltip_Hook)

			debugprint(frame:GetName() or frame, "hooked!")
		end

		frame = EnumerateFrames(frame)
	end
else -- We're on Classic (Vanilla, TBC, Wrath or Cata), hook the global function
	hooksecurefunc("ActionButton_SetTooltip", SetTooltip_Hook)
end
