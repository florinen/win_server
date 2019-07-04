## Pass variable in template 
admin_password=${admin_password}  
SafeModeAdministratorPassword=${SafeModeAdministratorPassword}  
AutoLoginUser=${AutoLoginUser}
AutoLoginPassword=${AutoLoginPassword}


## Script 
<<EOF
   <script>
     winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"} & winrm/config @{MaxEnvelopeSizekb="8000kb"}
   </script>
   <powershell>
     netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
     $admin = [ADSI]("WinNT://./administrator, user")
     $admin.SetPassword("${admin_password}")

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
   </powershell>
EOF