$OrganizationalUnit = "TestUser"
$Domain = "acirrustech"
$DomainEnding = "com"

# Configures script to run once on next logon
#Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'AD_add_users' -Value "c:\windows\system32\cmd.exe /c C:\scripts\ad_add_domain_users.bat"

Import-Module ActiveDirectory

New-ADOrganizationalUnit -path "dc=$Domain, dc=$DomainEnding" -name $OrganizationalUnit -ProtectedFromAccidentalDeletion:$false
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Admin" -AccountPassword (ConvertTo-SecureString "test123-Admin!!!8" -AsPlaintext -Force) -Description "Acirrustech Setup Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -PassThru | Enable-ADAccount
#New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Test" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech test user" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -PassThru | Enable-ADAccount

Add-ADGroupMember 'Domain Admins' Admin


#Restart-Computer -Force
#update

