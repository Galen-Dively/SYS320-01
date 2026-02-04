
cd C:\xampp\apache\logs
#Get-Content -tail 5 C:\xampp\apache\logs\access.log
#Get-Content access.log | select-string "404", "400"
#Get-Content access.log | select-string "200" -NotMatch

$errors = Get-Content access.log | Select-String "404"
$ips = @()
for($i=0;$i -lt $errors.Length;$i++)
{
    $ips += $errors[$i].ToString().Split()[0]
}

$ips | group -NoElement