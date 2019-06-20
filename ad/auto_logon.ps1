$AutoLoginUser = "acirrustech\Administrator"
$AutoLoginPassword = "test123-Admin"


Set-AutoLogon -DefaultUsername $AutoLoginUser -DefaultPassword $AutoLoginPassword 
# Registry path for Autologon configuration
 

Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'Set-AutoLogon' -Value "c:\windows\system32\cmd.exe /c C:\scripts\auto_logon.bat"

 