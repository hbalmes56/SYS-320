. (Join-Path $PSScriptRoot menu2.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Users.ps1)

$prompt = "Please Choose"
$prompt += "1: Display last 10 Apache Logs"
$prompt += "2: Display last 10 failed Logins"
$prompt += "3: Display at risk Users"
$prompt += "4: Start Chrome and go to champlain.edu"
$prompt += "5: Quit"

$operation = $true

while($operation){

    Write-Host $prompt | Out-String
    $choice = Read-Host

    if($choice -eq 5){
        Write-Host "Successfully quit the operation" | Out-String
        exit
        $operation = $false
    }

    elseif(choice -eq 1){
        Get-LastApacheLogs
    }

    elseif(choice -eq 2){
        $user = Read-Host "enter a user to be checked"

        $userInfo = getFailedLogins 10
        Write-Host ($userInfo | Where-Object { $_.user -ilike "*name*" } | Format-Table | Out-String)
    }

    elseif(choice -eq 3){
        $days = Read-Host "Enter number of days to be checked"
        atRiskUsers $days
    }

    elseif(choice -eq 4){
        Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--start-fullscreen "https://www.champlain.edu'
    }

    else{
        Write-Host "No number selected." | Out-String
    }
}