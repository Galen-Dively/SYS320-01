. (Join-Path $PSScriptRoot script.ps1)

clear

$loginoutstable = GetLoginLogoffByDayOffset 15
$loginoutstable

$shutdowntable = GetShutdownEvent 900
$shutdowntable

$startuptable = GetStartEvent 25
$startuptable