
<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

function checkUser($name) {

   $userExists = checkUser $name 

   if ($userExists -eq $false) {
        do {
            $password = Read-Host -AsSecureString -Prompt "Please enter new password"
            $BSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $regPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

            $checkPass = checkPassword $regPass
            if (-not $checkPass) {
                Write-Host "Password doesn't fit criteria... try again"
            }
        } while (-not $checkPass)

        createAUser $name $password
        Write-Host "User $name has been added."
    }
    else {
        Write-Host "User already exists... add a different user."
    }
}

$nameToCheck = "champuser"

checkUser $nameToCheck

