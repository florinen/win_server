Import-Module activedirectory
$ADUsers = Import-Csv -Path "C:\scripts\ansible_scripts\add_multiple_users.csv"            

foreach ($User in $ADUsers)
{
       $Firstname   = $User.FirstName
       $Lastname    = $User.LastName
       $Username    = $User.UserName
       $Phone       = $User.Phone
       $Email       = $User.Email
       $Password    = $User.Password
       $Description = $User.Description 
       $Department  = $User.Department
       $OU          = $User.OU


       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }
       else
       {
              #If a user does not exist then create a new user account
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
              New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@devopnet.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -EmailAddress $Email`
            -MobilePhone $Phone `
            -Description $Description `
            -ChangePasswordAtLogon $True `
            -DisplayName "$Lastname, $Firstname" `
            -Department $Department `
            -Path $OU `
            -AccountPassword (convertTo-securestring $Password -AsPlainText -Force) `
            -PassThru | Enable-ADAccount

       }
}