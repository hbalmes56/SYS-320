<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($contents, $lookline){

    if ($password.Length -lt 6) {
        Write-Host "Password is too short"
        return $false
    }

    if (-not ($password -match "[a-zA-Z]" -and $password -match '\d' -and $password -match '\W')) {
        Write-Host "Password needs at least 1 special character, 1 number, and 1 letter"
        return $false
    }

    return $true

}

$passToCheck = checkPassword "hello"

if ($passToCheck) {
    Write-Host "Password is valid"
} else {
    Write-Host "Password is too weak"

} 
