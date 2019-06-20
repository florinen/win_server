$AutoLoginUser = "Administrator"
$AutoLoginPassword = "test123-Admin"
$NetBIOSName = "acirrustech"


# Registry path for Autologon configuration
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'AD_Autologon' -Value "c:\windows\system32\cmd.exe /c C:\scripts\auto_logon.bat"

# Autologon configuration including: username, password,domain name and times to try autologon
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String
Set-ItemProperty $RegPath "DefaultUsername" -Value "$AutoLoginUser" -type String
Set-ItemProperty $RegPath "DefaultPassword" -Value "$AutoLoginPassword" -type String
Set-ItemProperty $RegPath "DefaultDomainName" -Value "$NetBIOSName" -type String
Set-ItemProperty $RegPath "AutoLogonCount" -Value "1" -type DWord