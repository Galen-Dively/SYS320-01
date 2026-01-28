# Get-EventLog -LogName System -Source Microsoft-Windows-Winlogon


function GetLoginLogoffByDayOffset($days)
{
    $loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

    $loginoutstable = @()
    for ($i=0; $i -lt $loginouts.Count; $i++) {
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
    
    
        $user = $loginouts[$i].ReplacementStrings[1]
        $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
        $new_user = $SID.Translate([System.Security.Principal.NTAccount])

        $loginoutstable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; "Id" = $loginouts[$i].InstanceId; "Event" = $event; "User"=$new_user.Value}
    }

    $loginoutsTable
}

function GetShutdownEvent($days)
{
    $shutdowns = Get-EventLog -LogName system -After (Get-Date).AddDays(-$days)| Where-Object {$_.EventId -eq 6006}
    $table = @()
    for($i=0; $i -lt $shutdowns.Count; $i++){
        $table += [pscustomobject]@{"Time" = $shutdowns[$i].TimeGenerated; "Id"=$shutdowns[$i].EventID; "Event" = "Shutdown"; "User"="System"}
        
    }
    return $table
}

function GetStartEvent($days)
{
    $turnons = Get-EventLog -LogName system -After (Get-Date).AddDays(-$days)| Where-Object {$_.EventId -eq 6005}
    $table = @()
    for($i=0; $i -lt $turnons.Count; $i++){
        $table += [pscustomobject]@{"Time" = $turnons[$i].TimeGenerated; "Id"=$turnons[$i].EventID; "Event" = "Startup"; "User"="System"}
        
    }
    return $table
}
