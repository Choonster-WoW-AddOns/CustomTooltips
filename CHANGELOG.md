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