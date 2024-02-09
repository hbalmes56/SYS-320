# function
function Get-LoginLogEvents {
    param(
        [int]$days
    )

# Get login and logoff records from Windows Events
# Get the last 14 days
$loginouts = Get-EventLog system -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() #Empty array to fill customly

for($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].InstanceId -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$sid = "S-1-5-21-4045193593-2709619087-1961831424-1002";
$objsid = New-Object -TypeName System.Security.Principal.SecurityIdentifier -ArgumentList $sid;
$name = $objsid.Translate([System.Security.Principal.NTAccount]).Value;

# Creating user property value
# $user = $loginouts[$i].ReplacementStrings[1]

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject] @{"Time" = $loginouts[$i].TimeGenerated; `
                                        "Id" = $loginouts[$i].InstanceId; `
                                     "Event" = $event; `
                                      "User" = $name;
                                      }
}

return $loginoutsTable

}

function Get-SystemEventLogs {
    param(
        [int]$days
    )

$startEvents = Get-EventLog -LogName System -Source "EventLog" -After (Get-Date).AddDays(-$days) | Where-Object { $_.EventID -eq 6005 }
$shutdownEvents = Get-EventLog -LogName System -Source "EventLog" -After (Get-Date).AddDays(-$days) | Where-Object { $_.EventID -eq 6006 } 


$eventsTable = @()

# start events
foreach ($startEvent in $startEvents) {
    $eventsTable += [pscustomobject] @{
        "Time" = $startEvent.TimeGenerated; `
        "Id" = $startEvent.EventId; `
        "Event" = "Computer Start"; `
        "User" = "System";
    }
}

# shutdown events
foreach ($shutdownEvent in $shutdownEvents) {
    $eventsTable += [pscustomobject] @{
        "Time" = $shutdownEvent.TimeGenerated; `
        "Id" = $shutdownEvent.InstanceId; `
        "Event" = "Computer Shutdown"; `
        "User" = "System";
    }
}

return $eventsTable

}

# call the function with the parameter and print the results
$days = 14
$loginoutsTable = Get-LoginLogEvents -days $days
$systemEventsTable = Get-SystemEventLogs -days $days

# print
$loginoutsTable
$systemEventsTable