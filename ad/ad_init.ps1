#Reference: http://technet.microsoft.com/en-us/library/hh472162.aspx
#DomainMode / ForestMode - Server 2003: 2 or Win2003 / Server 2008: 3 or Win2008 / Server 2008 R2: 4 or Win2008R2 / Server 2012: 5 or Win2012 / Server 2012 R2: 6 or Win2012R2 / Windows Server 2016: 7 or WinThreshold
$DomainName = "acirrustech.com"
$NetBIOSName = "acirrustech"
$DomainMode = "WinThreshold"
$ForestMode = "WinThreshold"
$SafeModeAdministratorPassword = ConvertTo-SecureString "test123-Admin" -AsPlaintext -Force  #This is the Directory Services Restore Mode (DSRM)
$AutoLoginUser = "Administrator"
$AutoLoginPassword = "test123-Admin"
$LogPath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"

## Configures script to run once on next logon
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'AD_Create' -Value "c:\windows\system32\cmd.exe /c C:\scripts\ad_init.bat"

## Registry path for Autologon configuration
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"


# Autologon configuration including: username, password,domain name and times to try autologon
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String
Set-ItemProperty $RegPath "DefaultUsername" -Value "$AutoLoginUser" -type String
Set-ItemProperty $RegPath "DefaultPassword" -Value "$AutoLoginPassword" -type String
Set-ItemProperty $RegPath "DefaultDomainName" -Value "$NetBIOSName" -type String
Set-ItemProperty $RegPath "AutoLogonCount" -Value "1" -type DWord

## Add users

$OrganizationalUnit = "Acirrustech"
$ChildOU = "Users"
$Domain = "acirrustech"
$DomainEnding = "com"
$City = "Chicago"
$Group = "Administrators"
$Groups = 'Domain Admins','Domain Users','Administrators','Enterprise Admins','Group Policy Creator Owners','Schema Admins'
$User = "Admin"
$AccountPassword = "Summer-01!!!*"

Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name $OrganizationalUnit -City $City -path "dc=$Domain,dc=$DomainEnding"
New-ADOrganizationalUnit -Name $ChildOU -path "OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding" 
New-ADUser -Name $User -AccountPassword $AccountPassword -Description "Acirrustech Admin User" -ChangePasswordAtLogon:$False -CannotChangePassword:$True -PasswordNeverExpires:$True -Path "OU=$ChildOU,OU=$OrganizationalUnit,DC=$Domain,DC=$DomainEnding"  -Enabled:$True

ForEach ($Group in $Groups){
    Add-ADGroupMember -Identity $Group -Members $User
}

Add-ADPrincipalGroupMembership $User -MemberOf $Group

## Change computer name
$NewComputerName = "win-dc01"
Rename-Computer -NewName $NewComputerName
Start-Sleep -Seconds 5

Restart-Computer -Force
update

#Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'AD_Create' -Value "c:\windows\system32\cmd.exe /c C:\scripts\ad_add_domain_users.bat"
#Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'Change_hostname' -Value "c:\windows\system32\cmd.exe /c C:\scripts\change_hostname.bat"
 



Write-Host "Windows Server 2016 - Active Directory Installation"

Write-Host " - Installing AD-Domain-Services..."
Install-WindowsFeature -Name GPMC,RSAT-AD-PowerShell,RSAT-AD-AdminCenter,RSAT-ADDS-Tools,RSAT-DNS-Server
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment

Write-Host " - Creating new AD-Domain-Services Forest..."
Install-ADDSForest -CreateDNSDelegation:$False -SafeModeAdministratorPassword $SafeModeAdministratorPassword -DomainName $DomainName -DomainMode $DomainMode -ForestMode $ForestMode -DomainNetBiosName $NetBIOSName -InstallDNS:$True -NoRebootOnCompletion:$True -LogPath:$LogPath -SysvolPath:$SysvolPath -Confirm:$False

Write-Host " - Done. Restarting now `n"
Restart-Computer -Force

#Restart-Computer -ComputerName $ComputerName -Wait -For PowerShell -Timeout 300 -Delay 2

#update