-- List globals here for Mikk's FindGlobals script
-- GLOBALS: print, DisableAddOn, CustomTooltips, OneRingLib

local RW = OneRingLib.ext.ActionBook:compatible("Rewire", 1, 12)

if not RW then
	local addon, ns = ...
	DisableAddOn(addon)
	print(addon .. " has been automatically disabled because you don't have a compatible version of Opie installed. You can manually re-enable it when you install one.")
	return
end

local function SetTooltipTextNamed(tooltipFrame, tooltipName)
	local _, heading, body = CustomTooltips.GetNamedTooltip(tooltipName)
	
	CustomTooltips.SetTooltipText(tooltipFrame, heading, body)
end

RW:SetMetaHintFilter("customtooltip", "replaceTooltip", false, function(meta, tooltipName, target)
	return true, SetTooltipTextNamed, tooltipName
end)

local function SetTooltipTextInline(tooltipFrame, definition)
	local _, heading, body = CustomTooltips.GetInlineTooltip(definition)
	
	CustomTooltips.SetTooltipText(tooltipFrame, heading, body)
end

RW:SetMetaHintFilter("tooltipdesc", "replaceTooltip", false, function(meta, definition, target)
	return true, SetTooltipTextInline, definition
end)
