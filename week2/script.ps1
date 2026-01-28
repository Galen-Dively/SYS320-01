$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if ($chrome) {
    Stop-Process -Name "chrome" -Force
} else {
    Start-Process chrome "https://www.champlain.edu"
}