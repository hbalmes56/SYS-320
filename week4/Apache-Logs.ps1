function VisitingIP {
    param(
        [string]$PageVisited, 
        [string]$HTTPCode, 
        [string]$BrowserName
       
    )

    # get logs with the HTTP code
    $logs = Get-Content C:\xampp\apache\logs\access.log | Select-String " $HTTPCode "

    # regex for IP addresses 
    $regex = [regex] "\d{1,3}\.\d{1,3}\d{1,3}\.\d{1,3}"

    # array to store IPs matching critera 
    $matchingIPs = @()

    foreach ($log in $logs) {
        $matches = $regex.Matches($log)
        foreach ($match in $matches) {
            $ip = $match.Value
            $userAgent = $log -split '"'
            if ($userAgent[5] -like "*BrowserName*" -and $userAgent[1] -like "*$PageVisited*") {
                $matchingIPs += $ip
            }
        }
    }

    # return unique IPs 
    $matchingIPs | Select-Object -Unique
}