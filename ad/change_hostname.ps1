$NewComputerName = "win-dc01"
Rename-Computer -NewName $NewComputerName
Start-Sleep -Seconds 5

Restart-Computer -Force
update

#$Domain = "acirrustech"
# Configures script to run once on next logon
#Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'Change_hostname' -Value "c:\windows\system32\cmd.exe /c C:\scripts\change_hostname.bat"
