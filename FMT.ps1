 
function Start-Menu {

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {    
  Echo "This script needs to be run As Admin"
  Break
 }

echo 'Welcome to File Migration Tool'
echo 'Select from the list of options:'
echo '
1. Show and migrate current user.
2. Migrate another user on this computer.
3. List all Users and last date of use.
4. Exit.'
$List = Read-Host 'Press 1-4 to Continue'
}

Start-Menu

if($List -eq 1){
#Shows current user profile, and prompts for migration.
echo $env:USERPROFILE
$Source = 'C:\Users\jjwade\Documents'
$Destination = 'C:\Users\jjwade\Desktop\NewFolder'
$Readhost = Read-Host 'Would you like to migrate this profile? (Y)es/(N)o/(M)enu'
Switch($Readhost)
        {
            Y {Write-host "Okay, migrating files to P:/ drive"; 
            Test-Path -Path "C:\users\jjwade\Desktop\NewFolder\jjwade" 
            if(Test-Path -eq True){
            Copy-Item -Path $Source -Destination $Destination -Recurse}}

            N {Write-host "Okay, closing. Thank you for using File Migration Tool."}

            M {Write-host "Back to main menu"; Start-Menu}
        }
}
elseif($List -eq 2){

}
elseif($List -eq 3){
gwmi win32_userprofile | select @{LABEL="last used";EXPRESSION={$_.ConvertToDateTime($_.lastusetime)}}, LocalPath, SID|ft -a

}
elseif($List -eq 4){
echo 'Thank you for using FMT. Goodbye!'
exit
}

#gwmi win32_userprofile | select @{LABEL="last used";EXPRESSION={$_.ConvertToDateTime($_.lastusetime)}}, LocalPath, SID|ft -a



<#prompt 'Which user files would you like to copy?'
echo $Env:UserProfile
$FolderExists = Test-Path C:\Users\$User\Documents\


if($FolderExists -eq $true){ 
$Path = C:\Users\$User\Documents\
Write-Host = "Copying files from '$User'..."
Copy-Item $Path -Destination C:\Users\$User\Desktop\NewFolder -Recurse
}
else{
Write-Host("The specified user cannot be found. Would you like to continue?")
}
    $Readhost = Read-Host " ( y / n ) "
    Switch($Readhost)
        {
            Y {Write-host "Okay, which user would you like to copy files from?"; Read-Host}

            N {Write-host "Okay, closing. Thank you for using File Migration Tool."}
            }#>