# List all of the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log

# Lists only last 5 Apache logs
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

# Display only logs that contain 404 (Not Found) or 400 (Bad request)
#Get-Content C:\xampp\apache\logs\access.log | select-string ' 404 ', ' 400 '

# Display only logs that do not contain 200 (OK)
#Get-Content C:\xampp\apache\logs\access.log | select-string ' 200 ' -NotMatch

# From Every .log file in the directory, only get logs that contain the word "error"
#$A = Get-Childitem C:\xampp\apache\logs\*.log | select-string 'error'
# Display the last 5 elements of the result array
#$A[-1..-5]

# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | select-string ' 404 '

# Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.matches($notfounds)

# Get IPs as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ips | Where-Object { $_.IP -ilike "10.*" }

# Count IP's from above
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Measure
$counts | Select-Object Count, Name