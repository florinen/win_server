$OrganizationalUnit = "Devopnet"
$ChildOU = "Users"
$Domain = "devopnet"
$DomainEnding = "com"
$City = "Chicago"
$Groups = @('Domain Admins','Domain Users','Administrators','Enterprise Admins','Group Policy Creator Owners','Schema Admins')
$User = "Admin"
$AccountPassword = "Summer-01!!!*"

Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name $OrganizationalUnit -City $City -path "dc=$Domain,dc=$DomainEnding"
New-ADOrganizationalUnit -Name $ChildOU -path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" 
New-ADUser -Name $User -AccountPassword (ConvertTo-SecureString $AccountPassword -AsPlaintext -Force) -PasswordNeverExpires:$True -Path "OU=$ChildOU,OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding"  -Enabled $True
#New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Test" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech test user" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -PassThru | Enable-ADAccount

foreach($Group in $Groups) {
    Add-ADPrincipalGroupMembership $User -MemberOf $Group
}

#Add-ADGroupMember 'Domain Admins' $User




