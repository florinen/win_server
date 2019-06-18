$OrganizationalUnit = "Users"
$Domain = "acirrustech"
$DomainEnding = "com"

Import-Module ActiveDirectory

New-ADOrganizationalUnit -path "dc=$Domain, dc=$DomainEnding" -name $OrganizationalUnit -ProtectedFromAccidentalDeletion:$false
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Admin" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech Setup Account" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True
New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Test" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech test user" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Enabled:$True

Add-ADGroupMember 'Domain Admins' Admin


Restart-Computer -Force
