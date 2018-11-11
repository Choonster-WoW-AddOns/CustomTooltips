-- List globals here for Mikk's FindGlobals script
-- GLOBALS: print, DisableAddOn, CustomTooltips, OneRingLib

local RW = OneRingLib.ext.ActionBook:compatible("Rewire", 1, 12)

if not RW then
	local addon, ns = ...
	DisableAddOn(addon)
	print(addon .. " has been automatically disabled because you don't have a compatible version of Opie installed. You can manually re-enable it when you install one.")
	return
end

local function SetTooltipText(tooltipFrame, args)
	local heading, body = args[1], args[2]
	
	CustomTooltips.SetTooltipText(tooltipFrame, heading, body)
end

RW:SetMetaHintFilter("customtooltip", "replaceTooltip", false, function(meta, tooltipName, target)
	local _, heading, body = CustomTooltips.GetNamedTooltip(tooltipName)
	
	return true, SetTooltipText, {heading, body}
end)

RW:SetMetaHintFilter("tooltipdesc", "replaceTooltip", false, function(meta, definition, target)
	local _, heading, body = CustomTooltips.GetInlineTooltip(definition)
		
	return true, SetTooltipText, {heading, body}
end)
