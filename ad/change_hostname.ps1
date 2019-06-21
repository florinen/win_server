$NewComputerName = "win-dc01"
Rename-Computer -NewName $NewComputerName
Start-Sleep -Seconds 5

Restart-Computer -Force
update

 
