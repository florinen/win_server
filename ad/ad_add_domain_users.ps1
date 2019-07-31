$OrganizationalUnit = "Acirrustech"
$ChildOU = "Users"
$Domain = "acirrustech"
$DomainEnding = "com"
$City = "Chicago"
#$Groups = @('Domain Admins','Domain Users','Administrators','Enterprise Admins','Group Policy Creator Owners','Schema Admins')
#$User = "Admin"
#$AccountPassword = "Summer-01!!!*"
$OU = "OU=$ChildOU,OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding"
#$Username = "UserName"


Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name $OrganizationalUnit -City $City -path "DC=$Domain,DC=$DomainEnding"
New-ADOrganizationalUnit -Name $ChildOU -path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" 

 
$UserList = Import-Csv -Path "C:\scripts\add_multiple_users.csv"  

foreach ($User in $UserList) {

     $Attributes = @{

        Enabled = $true
        ChangePasswordAtLogon = $true
        Path = $OU

        Name = "$($User.FirstName) $($User.LastName)"
        UserPrincipalName = "$($User.FirstName).$($User.LastName)@$Domain.$DomainEnding"
        SamAccountName = $User.UserName
        EmailAddress = $User.Email
        GivenName = $User.FirstName
        Surname = $User.LastName

        Company = $User.Company
        Department = $User.Department
        
        AccountPassword = $User.Password | ConvertTo-SecureString -AsPlainText -Force

     }

    New-ADUser @Attributes

}

# foreach($Group in $Groups) {
#     Add-ADPrincipalGroupMembership $User -MemberOf $Group
# }

#Add-ADGroupMember 'Domain Admins' $User



