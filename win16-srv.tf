
resource "aws_key_pair" "win_key" {
    key_name = "win_key"
    public_key = "${file("/home/fnenciu/windows/win_key.pub")}"
}
resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${aws_key_pair.win_key.key_name}"
    availability_zone = "${var.AZ}"
    user_data = <<EOF
<powershell>
net user ${var.INSTANCE_USERNAME} ‘${var.INSTANCE_PASSWORD}’ /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add

winrm quickconfig -q
winrm set winrm/config/winrs ‘@{MaxMemoryPerShellMB=”300″}’
winrm set winrm/config ‘@{MaxTimeoutms=”1800000″}’
winrm set winrm/config/service ‘@{AllowUnencrypted=”true”}’
winrm set winrm/config/service/auth ‘@{Basic=”true”}’

netsh advfirewall firewall add rule name=”WinRM 5985″ protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name=”WinRM 5986″ protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF
    tags = {
      Name = "Win16-SRV"
    }

# The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    host = "${self.public_ip}"
    type = "winrm"
    timeout = "10m"
    user = "${var.INSTANCE_USERNAME}"
    password = "${var.INSTANCE_PASSWORD}"
    
    }
    vpc_security_group_ids=["${aws_security_group.Allow-RDP.id}"]

  }
