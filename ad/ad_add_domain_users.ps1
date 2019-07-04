$OrganizationalUnit = "Acirrustech"
$ChildOU = "Users"
$Domain = "acirrustech"
$DomainEnding = "com"
$City = "Chicago"
$Groups = @('Domain Admins','Domain Users','Administrators','Enterprise Admins','Group Policy Creator Owners','Schema Admins')
$User = "Admin"
$AccountPassword = "Summer-01!!!*"
$OU = "OU=$ChildOU,OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding"



Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name $OrganizationalUnit -City $City -path "DC=$Domain,DC=$DomainEnding"
New-ADOrganizationalUnit -Name $ChildOU -path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" 
New-ADUser -Name $User `
            AccountPassword (ConvertTo-SecureString $AccountPassword -AsPlaintext -Force) `
            Path $OU `
            Description "Acirrustech test user" `
            ChangePasswordAtLogon:$False `
            CannotChangePassword:$True `
            PasswordNeverExpires:$True `
            Enabled $True 


foreach($Group in $Groups) {
    Add-ADPrincipalGroupMembership $User -MemberOf $Group
}

#Add-ADGroupMember 'Domain Admins' $User

#New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Test" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech test user" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -PassThru | Enable-ADAccount


