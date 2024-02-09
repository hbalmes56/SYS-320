. (Join-Path $PSScriptRoot "Functions_EventLogs.ps1")

clear

# login and logouts from last 15 days
$loginoutsTable = LoginLogEvents 15
$loginoutsTable

# shutdowns and startups from last 25 days
$shutandstartTable = SystemEventLogs 25
$shutandstartTable
