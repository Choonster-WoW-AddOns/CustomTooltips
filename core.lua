--[===[

Tooltip Format:
	
	NAME = {
		heading = "Heading Text",
		body = "Body Text",
	},
	
-- NAME is a unique name for this tooltip, used for the #customtooltip TooltipName metacommand in your macro.
   This name is case-insensitive, so ExampleName and EXAMPLENAME will conflict with each other.
-- "Heading Text" is the text to display as the heading of the tooltip, wrapped in "double quotes" or 'single quotes'.
-- "Body Text" is the text to display as the body of the tooltip. It can be wrapped in "double quotes", 'single quotes' or [[double square brackets]].
   This text will be wrapped to fit in the tooltip; but if you still need to have an explicit linebreak in the body, use double square brackets.
   A linebreak directly after the opening square brackets or directly before the closing brackets will be ignored; as will any tab characters at the start of a line.
-- You must put a comma after the closing quote/bracket of the heading and the body as well as after the closing brace of the tooltip definition, as shown in the example.

]===]

local TOOLTIPS = {
-- Put your tooltip definitions below this line
	
	Example = {
		heading = "Example Tooltip Heading",
		body = [[
		This is an example tooltip. It demonstrates how to create your own tooltips.
		
		This text is on a separate line to the first part of the body.
		]],
	},
	
	ExampleTwo = {
		heading = "Second Example Heading",
		body = "This is a second example tooltip, it doesn't have any linebreaks in it.",
	},
	
-- Put your tooltip definitions above this line
}

-------------------
-- END OF CONFIG --
-------------------
local oldTooltips = TOOLTIPS
TOOLTIPS = {} -- Make a new table to store the normalised tooltips in (we can't add new keys when iterating with pairs)

-- Process the tooltip definitions to normalise them.
for name, data in pairs(oldTooltips) do
	local body = data.body
	body = body:gsub("^\t+", "") -- Strip any tabs from the start of the string
	body = body:gsub("\n\t+", "\n") -- Strip any tabs from the start of each line
	body = body:gsub("\n$", "") -- Strip a single newline from the end of the string
	data.body = body
	
	-- Convert the keys to uppercase
	TOOLTIPS[name:upper()] = data
end

oldTooltips = nil -- Allow the old table to be garbage collected.

local function ActionButton_SetTooltip_Hook(self)
	local actionType, id, subType = GetActionInfo(self.action)
	if actionType ~= "macro" then return end
	
	local macroText = GetMacroBody(id)
	
	local tooltipName = macroText:match("#customtooltip ([^\n]+)")
	tooltipName = tooltipName and tooltipName:upper()
	local tooltipData = TOOLTIPS[tooltipName]
	if not tooltipData then return end
	
	local tooltip = GameTooltip
	tooltip:ClearLines()
	
	-- Anchors the tooltip to the action button and positions it
	GameTooltip_SetDefaultAnchor(tooltip, self)
	
	tooltip:AddLine(tooltipData.heading) -- Use default yellow text colour, don't wrap the text
	tooltip:AddLine(tooltipData.body, 1,1,1, true) -- Use white text, wrap the text
	tooltip:Show()
end

hooksecurefunc("ActionButton_SetTooltip", ActionButton_SetTooltip_Hook)