--[===[

Tooltip Format:
	
	NAME = {
		heading = "Heading Text",
		body = {{"Body Text Line", RED, GREEN, BLUE}}
	},

REQUIRED FIELDS	
-- NAME is a unique name for this tooltip, used for the "#customtooltip TooltipName" metacommand in your macro (without the
   quotes). This name is case-insensitive, so ExampleName and EXAMPLENAME will conflict with each other.
-- "Heading Text" is the text to display as the heading of the tooltip, wrapped in "double quotes" or 'single quotes'.
   Heading text will always be in white, and will not wrap.
-- "Body Text Line" is the text for a single line of the tooltip.  Optionally, the colour of the text for that line may be
   specified. Each line may have a different colour specified. If no colour is included, that line of text will use the default
   yellow text colour. To see how to specify multiple lines, see the examples below.
   
OPTIONAL FIELDS
-- "RED" is the red component of the line colour. This value must be in the interval [0.0, 1.0]. If one colour component is
   specified, all three must be specified.
-- "GREEN" is the green component of the line colour. This value must be in the interval [0.0, 1.0]. If one colour component is
   specified, all three must be specified.
-- "BLUE" is the blue component of the line colour. This value must be in the interval [0.0, 1.0]. If one colour component is
   specified, all three must be specified.

EXAMPLES
-- See below for the three examples.
-- The first example shows how multiple lines can be created in a tooltip with different colours.
-- The second example is a simple example for a tooltip with default colours and only one line of text.
-- The third example is an example of a tooltip that will generate a syntax error. Try using this tooltip in-game to see
   what information is provided when the tooltip is configured improperly. DO NOT USE THIS EXAMPLE AS A BASIS FOR NEW
   TOOLTIPS. IT IS HERE TO SHOW YOU WHAT NOT TO DO.
   
   
ADDITIONAL NOTES
-- If you do not want any custom colours, you can create custom tooltips in the macro that use them. The format for this is:
   #tooltipdesc heading^body
   To add line breaks into this, add the string '\n' (no quotes) into the body. Custom colours are disabled for inline tooltip
   definitions. Furthermore, '\n' only works for inline definitions, as this configuration file uses a different means to
   specify line breaks. (See the first example for more details.)
]===]

local TOOLTIPS = {
-- Put your tooltip definitions below this line
	
	Example = {
		heading = "Example Tooltip Heading",
		body = {{"This is an example tooltip. The text will be in red.", 1.0, 0.0, 0.0},
		        {"This text is on a separate line. The text will have the default yellow text colour."},
		        {"This is the third line of the tooltip. It will be blue.", 0.0, 0.0, 1.0}}
	},
	
	ExampleTwo = {
		heading = "Second Example Heading",
		body = {{"This is a second example tooltip; it doesn't have any linebreaks in it. It uses the default yellow colour."}}
	},
	
	-- This is a test example, to ensure that the syntax checker is working properly
	-- DO NOT USE THIS TOOLTIP - IT WILL DISPLAY AN ERROR TOOLTIP
	ExampleThreeWithSyntaxError = {
		heading = 3, -- this is an error, here - heading needs to be a string
		
		-- this is actually 2 errors-in-one
		-- first of all, the red value is specified, but neither the green nor the blue values are specified, so thats one error
		-- the second error in this line is that the red value is not between 0 and 1 inclusive
		body = {{"This is an erroneous tooltip. If used, it should display the syntax error tooltip.", 2.0}} 
	},
	
-- Put your tooltip definitions above this line
}

-------------------
-- END OF CONFIG --
-------------------

-- List globals here for Mikk's FindGlobals script
-- GLOBALS: unpack, type, assert, CustomTooltips_DisplayTooltip, GameTooltip_SetDefaultAnchor, GetActionInfo, GetMacroBody

-- Do not change this
local ERROR_SYNTAX_TOOLTIP = {
	heading = "Tooltip Syntax Error",
	body = {"Syntax error in tooltip definition in core.lua:",
	        "Error: %s in tooltip %s",
	        "%s"}
}

local ERROR_NOT_FOUND_TOOLTIP = {
	heading = "Tooltip Not Found Error",
	body = "Error: Custom tooltip definition not found with name \"%s\"."
}

local function GetSyntaxError(errorMessage, tooltipName, detailedMessage)
	local heading = ERROR_SYNTAX_TOOLTIP.heading
	local body = {{ERROR_SYNTAX_TOOLTIP.body[1], 1.0, 0.0, 0.0},
	              {ERROR_SYNTAX_TOOLTIP.body[2]:format(errorMessage, tooltipName), 1.0, 0.0, 0.0},
	              {ERROR_SYNTAX_TOOLTIP.body[3]:format(detailedMessage), 1.0, 0.0, 0.0}}
	
	return heading, body
end

local function GetNotFoundError(name)
	local heading = ERROR_NOT_FOUND_TOOLTIP.heading
	local body = {{ERROR_NOT_FOUND_TOOLTIP.body:format(name), 1.0, 0.0, 0.0}}
	
	return heading, body
end

local function CheckSyntax(name, data)
	local heading, body = data.heading, data.body
	local hasError = false
	
	if not heading then
		heading, body = GetSyntaxError("heading not found", name, "Tooltip definition is missing a heading.")
		hasError = true
	end
	
	if not hasError and type(heading) ~= "string" then
		heading, body = GetSyntaxError("heading is not a string", name, "Tooltip's heading must be a string.")
		hasError = true
	end
	
	if not hasError and not body then
		heading, body = GetSyntaxError("body not found", name, "Tooltip definition is missing a tooltip body.")
		hasError = true
	end
	
	if not hasError and type(body) ~= "table" then
		heading, body = GetSyntaxError("body is not a table", name, "Tooltip's body must be a table.")
		hasError = true
	end
	
	if not hasError then
		for i=1, #body do
			local line = body[i]
			if not hasError and type(line) ~= "table" then
				heading, body = GetSyntaxError("body line is not a table", name, ("Line %d of the tooltip's body must be a table."):format(i))
				hasError = true
			end
			
			local text = line[1]
			if not hasError and not text then
				heading, body = GetSyntaxError("line text not found", name, ("Line %d of the tooltip's body is missing text."):format(i))
				hasError = true
			end
			
			local red, green, blue = line[2], line[3], line[4]
			if not hasError and red and (not green or not blue) then
				heading, body = GetSyntaxError("colour value(s) missing", name, ("Line %d of the tooltip's body must either specify all 3 colour components or none."):format(i))
				hasError = true
			end
			
			-- We know red, green, and blue are all defined
			if not hasError and red then
				if type(red) ~= "number" or red < 0.0 or red > 1.0 then
					heading, body = GetSyntaxError("invalid red value", name, ("Line %d of the tooltip's body: red value must be a number between 0.0 and 1.0 inclusive."):format(i))
					hasError = true
				end
				
				if type(green) ~= "number" or green < 0.0 or green > 1.0 then
					heading, body = GetSyntaxError("invalid green value", name, ("Line %d of the tooltip's body: green value must be a number between 0.0 and 1.0 inclusive."):format(i))
					hasError = true
				end
				
				if type(blue) ~= "number" or blue < 0.0 or blue > 1.0 then
					heading, body = GetSyntaxError("invalid blue value", name, ("Line %d of the tooltip's body: blue value must be a number between 0.0 and 1.0 inclusive."):format(i))
					hasError = true
				end
			end
		end
	end
	
	data.heading, data.body = heading, body
	
	return name, data
end

local oldTooltips = TOOLTIPS
TOOLTIPS = {} -- Make a new table to store the normalised tooltips in (we can't add new keys when iterating with pairs)

-- Process the tooltip definitions to normalise them.
for name, data in pairs(oldTooltips) do
	name, data = CheckSyntax(name, data)
	
	-- Convert the keys to uppercase
	TOOLTIPS[name:upper()] = data
end

oldTooltips = nil -- Allow the old table to be garbage collected.

local GameTooltip = GameTooltip

-- Display a custom tooltip anchored to the supplied button based on the supplied macro text
function CustomTooltips_DisplayTooltip(button, macroText)
	local tooltipName = macroText:match("#customtooltip ([^\n]+)")
	local heading, body
	if tooltipName then
		local tooltipData = TOOLTIPS[tooltipName:upper()]
		if tooltipData then
			heading, body = tooltipData.heading, tooltipData.body
		else
			heading, body = GetNotFoundError(tooltipName)
		end
	else
		-- Do we have an inline tooltip definition?
		if not macroText:find("#tooltipdesc") then return end
		
		-- We do have an inline tooltip definition (use a non-greedy approach to the separator - heading ends at
		-- the first ^, and all subsequent ^ will be part of the body)
		heading, body = macroText:match("#tooltipdesc ([^\n\^][^\n\^]-)\^([^\n]+)")
		if not heading or not body then
			heading, body = GetSyntaxError("Bad inline tooltip definition format", "<inline>", "Macro inline tooltip must follow this format: #customtooltip heading^body")
		else
			local text = body:gsub("\\n", "\n")
			body = {{ text, nil, nil, nil }}
		end
	end
	
	assert(heading, "Heading is nil.")
	assert(body, "Body is nil.")
	
	GameTooltip:ClearLines()
	
	-- Anchors the tooltip to the action button and positions it
	GameTooltip_SetDefaultAnchor(GameTooltip, button)
	
	GameTooltip:AddLine(heading, 1,1,1) -- Use white text, don't wrap the text
	for i=1, #body do
		-- If the colours were not specified, these values are nil, which tells the GameTooltip to use the default yellow
		local text, red, green, blue = unpack(body[i], 1, 4)
		GameTooltip:AddLine(text, red, green, blue, true)
	end
	
	GameTooltip:Show()
end

hooksecurefunc("ActionButton_SetTooltip", function(self)
	local actionType, id, subType = GetActionInfo(self.action)
	if actionType ~= "macro" then return end
	
	local macroText = GetMacroBody(id)
	CustomTooltips_DisplayTooltip(self, macroText)	
end)
