$chrome = Get-Process -Name chrome -ErrorAction SilentlyContinue
if ($chrome -eq $null) {
    Start-Process "chrome" -ArgumentList "https://www.champlain.edu"
    Write-Host "Chrome started... directed to www.champlain.edu"
}
else {
    Stop-Process -Name chrome -Force
    Write-Host "Chrome stopped"
}