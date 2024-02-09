$processes = Get-Process| Where-Object { $_.ProcessName -like 'C*' }

$processes | Format-Table -Property ID, ProcessName, StartTime
