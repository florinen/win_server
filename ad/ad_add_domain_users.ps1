$OrganizationalUnit = "Acirrustech"
$ChildOU = "Users"
$Domain = "acirrustech"
$DomainEnding = "com"
$City = "Chicago"
$Group = "Administrators"
$Groups = 'Domain Admins','Domain Users','Administrators','Enterprise Admins','Group Policy Creator Owners','Schema Admins'
$User = "Admin"
$AccountPassword = "Summer-01!!!*"
# Configures script to run once on next logon
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'AD_Create_users' -Value "c:\windows\system32\cmd.exe /c C:\scripts\ad_add_domain_users.bat"

Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name $OrganizationalUnit -City $City -path "dc=$Domain,dc=$DomainEnding"
New-ADOrganizationalUnit -Name $ChildOU -path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" 
New-ADUser -Name $User -AccountPassword $AccountPassword -Description "Acirrustech Admin User" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Path "OU=$ChildOU,OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding"  -Enabled:$True
#New-ADUser -Path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" -Name "Test" -AccountPassword (ConvertTo-SecureString "Summer01!" -AsPlaintext -Force) -Description "Acirrustech test user" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -PassThru | Enable-ADAccount
#New-ADOrganizationalUnit  -Name $OrganizationalUnit -ProtectedFromAccidentalDeletion:$false -path "dc=$Domain,dc=$DomainEnding"

ForEach ($Group in $Groups){
    Add-ADGroupMember -Identity $Group -Members $User
}

Add-ADPrincipalGroupMembership $User -MemberOf $Group

#Add-ADGroupMember 'Domain Admins' Admin


#Restart-Computer -Force
#update

