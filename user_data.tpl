SafeModeAdministratorPassword=${SafeModeAdministratorPassword}  
AutoLoginUser=${AutoLoginUser}
AutoLoginPassword=${AutoLoginPassword}

<<EOF
<powershell>
$DomainName = "acirrustech.com"
$NetBIOSName = "acirrustech"
$DomainMode = "WinThreshold"
$ForestMode = "WinThreshold"
$LogPath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"

## Autologon configuration including: username, password,domain name and times to try autologon
    Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String
    Set-ItemProperty $RegPath "DefaultUsername" -Value "$AutoLoginUser" -type String
    Set-ItemProperty $RegPath "DefaultPassword" -Value "$AutoLoginPassword" -type String
    Set-ItemProperty $RegPath "DefaultDomainName" -Value "$NetBIOSName" -type String
    Set-ItemProperty $RegPath "AutoLogonCount" -Value "3" -type DWord

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

<powershell>
EOF