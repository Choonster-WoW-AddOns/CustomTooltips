local function ShowCustomToolTipForMegaMacro(macroId)
	local macro = MegaMacro.GetById(macroId)

	if not macro or not macro.Code then
		return
	end

	CustomTooltips.DisplayTooltipForMacroText(nil, macro.Code)
end

hooksecurefunc("ShowToolTipForMegaMacro", ShowCustomToolTipForMegaMacro)
