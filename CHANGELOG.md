# 1.24
- Bump TOC Interface version for Retail, Classic, Cataclysm Classic and MoP Classic
- Remove ConsolePort module
  - ConsolePort now uses LibActionButton directly, so the LibActionButton module works with it

# 1.23.1
- Update DisableAddOn call to use C_AddOns namespace
- Add Cataclysm Classic TOC Interface version

# 1.23
- Bump TOC Interface versions to 11.0.2
- Add #ct and #td aliases of #customtooltip and #tooltipdesc

# 1.22
- Bump TOC Interface versions to 11.0.0
- Fix LibActionButton and ElvUI modules

# 1.21.1
- Fix Classic support

# 1.21.0
- Fix Classic Season of Discovery support
- Bump TOC Interface versions to 10.2.7

# 1.20.0
- Add ConsolePort module

# 1.19.2
- Enable TOC creation for Classic clients

# 1.19.1
- Downgrade TOC Interface versions to 10.2.6
  - 10.2.7 hasn't been released yet

# 1.19.0
- Change GetActionInfo workaround to only use macro name
  - https://github.com/Stanzilla/WoWUIBugs/issues/495
  - https://github.com/Choonster-WoW-AddOns/CustomTooltips/issues/6
- Bump TOC Interface versions to 10.2.7
- Bump Classic TOC Interface versions to 1.15.2
- Bump Wrath Classic TOC Interface versions to 3.4.3

# 1.18.0
- Add workaround for GetActionInfo not returning macro index
  - https://github.com/Stanzilla/WoWUIBugs/issues/495
- Bump TOC Interface versions to 10.2.0
- Bump Classic TOC Interface versions to 1.14.4
- Bump Wrath Classic TOC Interface version to 3.4.2

# 1.17.0
- Bump TOC Interface versions to 10.1.0
- Bump Wrath Classic TOC Interface version to 3.4.1
- Update Blizzard module for 10.1.0

# 1.16.1
- Bump TOC Interface versions to 10.0.2

# 1.16
- Update Opie module for Yuzu (10.0) changes
- Bump TOC Interface version to 10.0.0

# 1.15
- Add Mega Macro module
- Fix invalid escape sequence in inline tooltip string pattern

# 1.14
- Update Blizzard module to 9.0.2
- Bump TOC Interface version to 9.0.2

# 1.13.2
- Add optional dependencies to .pkgmeta for CurseForge

# 1.13.1
- Add missing changelog for 1.13

# 1.13
- Add Opie module

# 1.12
- Bump TOC Interface version to 8.0
- Add .travis.yml file and TOC properties for the BigWigs packager script
	- https://www.wowinterface.com/forums/showthread.php?t=55801

## 1.11
- Update to 7.2
- Fix LibActionButton/ElvUI custom tooltips being overwritten by default ones

## 1.10
- Update to 7.0
- Fix error being thrown when mousing over an empty vanilla action button
- Make CustomTooltips_LibActionButton disable itself if no AddOns that provide LibActionButton are installed

## 1.09
- Tell Curse to use manual changelog

## 1.08
- Add custom text colour for each line of the tooltip body

## 1.07
- Fix ElvUI and ButtonForge modules not being valid AddOns in packaged release

## 1.06
- Add ButtonForge module
- Use button:HookScript directly in LAB and ElvUI modules

## 1.05
- Split ElvUI module from LibActionButton module
	- As of 8.26, ElvUI uses a modified version of LibActionButton

## 1.04
- Rename CustomTooltips_Bartender4 to CustomTooltips_LibActionButton
    - It already supported any LibActionButton button, it just had Bartender4 as a required dependency
- Make Bartender4 an optional dependency of CustomTooltips_LibActionButton along with ElvUI
- Add AddOn to p3lim's AddOn Packager Proxy
- Update to 6.2

## 1.03
- Restructure for CurseForge packaging
- Add license (MIT License)
- Update to 6.0
- Split tooltip display logic from macro retrieval logic to allow support for non-default action bars
- Add Bartender support
- Add .pkgmeta for CurseForge
- Remove old installation instructions from README to prepare for upload to Curse/WoWI

## 1.02
- Fix "attempt to index global tooltipData (a nil value)" (core.lua:90)
- Fix installation instructions list spacing
- Add #tooltipdesc instructions to README
- Add installation instructions to README
- Add #tooltipdesc metacommand for in-macro tooltip
- Improve instructions slightly
- Add README.md for Github
- Fix "invalid key to 'next'" error
    - We can't add new keys to a table when iterating with pairs().

## 1.01
- Fix "attempt to call a table value" error.