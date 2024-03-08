function ApacheLogs10 {
    $logs = "C:\xampp\apache\logs\access.log"

    if (Test-Path $logs){
        Get-Content $logs -Tail 10
    }
    else {
        Write-Host "Log does not exist"
    }

}
