local MAX_MACROS = MAX_ACCOUNT_MACROS + MAX_CHARACTER_MACROS

--@alpha@
local function debugprint(name, ...)
	-- if not name:find("BonusLoot", 1, true) then return end
	print(name, ...)
end
--@end-alpha@

--[===[@non-alpha@
local function debugprint() end
--@end-non-alpha@]===]

local SetTooltip_Old = ActionBarActionButtonMixin.SetTooltip

local function SetTooltip_Hook(self)
	local actionType, id, subType = GetActionInfo(self.action)
	if actionType ~= "macro" or id < 1 or id > MAX_MACROS then return end

	local macroText = GetMacroBody(id)
	if not macroText then
		debugprint("CustomTooltips: Macro is empty", "ID", id, "Button", self:GetName())
		return
	end

	CustomTooltips.DisplayTooltipForMacroText(self, macroText)
end

-- Hook the mixin function to handle action buttons created dynamically
hooksecurefunc(ActionBarActionButtonMixin, "SetTooltip", SetTooltip_Hook)

-- Iterate through all existing frames to handle action buttons created statically
local frame = EnumerateFrames()
while frame do
	if frame.SetTooltip == SetTooltip_Old then
		hooksecurefunc(frame, "SetTooltip", SetTooltip_Hook)

		debugprint(frame:GetName() or frame, "hooked!")
	end

	frame = EnumerateFrames(frame)
end
