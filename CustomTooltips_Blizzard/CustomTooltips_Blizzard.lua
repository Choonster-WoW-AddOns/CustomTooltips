-- List globals here for Mikk's FindGlobals script
-- GLOBALS: print, CustomTooltips, GetActionInfo, GetMacroBody

local MAX_MACROS = MAX_ACCOUNT_MACROS + MAX_CHARACTER_MACROS

--@alpha@
local function debugprint(name, ...)
	if not name:find("BonusLoot", 1, true) then return end
	print(name, ...)
end
--@end-alpha@

--[===[@non-alpha@
local function debugprint() end
--@end-non-alpha@]===]

hooksecurefunc("ActionButton_SetTooltip", function(self)
	local actionType, id, subType = GetActionInfo(self.action)
	if actionType ~= "macro" or id < 1 or id > MAX_MACROS then return end
	
	local macroText = GetMacroBody(id)
	if not macroText then
		debugprint("CustomTooltips: Macro is empty", "ID", id, "Button", self:GetName())
		return
	end
	
	CustomTooltips.DisplayTooltipForMacroText(self, macroText)	
end)
