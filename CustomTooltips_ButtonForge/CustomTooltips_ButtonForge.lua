-- List globals here for Mikk's FindGlobals script
-- GLOBALS: CustomTooltips

local API = ButtonForge_API1

-- We need to hook this method directly rather than using the BUTTON_ALLOCATED callback because
-- the method is set as Widget.UpdateTooltip, which GameTooltip will call from OnUpdate while owned by the widget.
-- This means that simply setting an OnEnter hook won't work, as the custom tooltip will be replaced almost instantly.
hooksecurefunc(BFButton, "UpdateTooltipMacro", function(self)
	self = self.ParentButton or self
	CustomTooltips.DisplayTooltipForMacroText(self.Widget, self.MacroBody)
end)
