<powershell>
$Username = "${USER}"
$Password = "${Password}"
$group = "Administrators"
& NET USER $Username $Password /add /y /expires:never
& NET LOCALGROUP $group $Username /add
& WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE

# Enable PSRemoting
Enable-PSRemoting -SkipNetworkProfileCheck -Force
winrm quickconfig -q
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'


netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
