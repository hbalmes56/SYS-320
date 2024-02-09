$stoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' }

$orderedServices = $stoppedServices | Sort-Object DisplayName

$csvFilePath = "$PSScriptRoot\stopped_services.csv"

$orderedServices | Export-Csv -Path $csvFilePath -NoTypeInformation

Write-Host "Stopped services have been saved to $csvFilePath"