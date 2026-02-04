cd C:\xampp\apache\logs

function ApacheLogs1()
{

    $access_logs = Get-Content access.log
    $tableRecords = @()
    for($i=0;$i -lt $access_logs.Count;$i++)
    {
        $split_logs = $access_logs[$i].Split()
        $tableRecords += [pscustomobject]@{"IP"=$split_logs[0]; 
                                            "Time"=$split_logs[3]; 
                                            "Method"=$split_logs[5]; 
                                            "Page"=$split_logs[6]; 
                                            "Protocol"=$split_logs[7]; 
                                            "Response"=$split_logs[8];
                                            "Referrer"=$split_logs[10]}
    }
    return $tableRecords | Where-Object {$_.IP -like "10.*"}
}