. (Join-Path $PSScriptRoot "apachelogs1.ps1")

#clear

$records = ApacheLogs1
write-host ($records | Where-Object { $_.Page -ilike "*page2.html*" -and $_.Referrer -ilike "*index.html*" } | Format-Table | Out-String)