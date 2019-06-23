Import-Module activedirectory
$Users = Import-Csv -Path "C:\scripts\ansible_scripts\add_multiple_users.csv"            
foreach ($User in $Users)            
{            
    $Displayname = $User.FirstName + " " + $User.LastName            
    $UserFirstname = $User.FirstName            
    $UserLastname = $User.LastName            
    $OU = "$User.OU"            
    $SAM = $User.SamAccountName            
    $UPN = $User.FirstName + "." + $User.LastName + "@" + $User.Email            
    $Description = $User.Description            
    $Password = $User.Password            
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName $SAM -UserPrincipalName $UPN -GivenName "$UserFirstname" -Surname "$UserLastname" -Description "$Description" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $true -server  win-dc01.devopnet.com        
}