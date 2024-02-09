$processes = Get-Process| Where-Object { $_.Path -notlike '*\System32\*' }

$processes | Format-Table -Property ID, ProcessName, Path
