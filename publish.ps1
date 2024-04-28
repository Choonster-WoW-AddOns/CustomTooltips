<#
.SYNOPSIS
    Packages the AddOn with the BigWigs Packager and copies it to the WoW game directories.
    
    Requires https://github.com/Tuller/PublishAddon to be installed in ~\source\repos\PublishAddon.
#>

$global:WOW_HOME = 'D:\World of Warcraft'

Import-Module '~\source\repos\PublishAddon\wow.psm1'

Publish-Addon
