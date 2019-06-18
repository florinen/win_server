
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("~/.ssh/my-keys/bastion_key.pub")}"
}
data "template_file" "userdata" {
  template =   <<EOF
   <script>
     winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"} & winrm/config @{MaxEnvelopeSizekb="8000kb"}
   </script>
   <powershell>
     netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
     $admin = [ADSI]("WinNT://./administrator, user")
     $admin.SetPassword("${var.INSTANCE_PASSWORD}")
   </powershell>
EOF
  vars = {
      INSTANCE_PASSWORD = "${var.INSTANCE_PASSWORD}"
  }
}

resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${aws_key_pair.my_key.key_name}"
    availability_zone = "${var.AZ}"
    user_data = "${data.template_file.userdata.rendered}" 
    vpc_security_group_ids=["${aws_security_group.allowed-ports.id}"]
tags = {
    name = "Win16-SRV"
}
### Allow AWS infrastructure metadata to propagate ###
  provisioner "local-exec" {
    command = "sleep 60"
  }
  ### Copy Scripts to EC2 instance ###
  provisioner "file" {
    source      = "${path.module}/ad/"
    destination = "C:\\scripts"
    connection   = {
     type        = "winrm"
     user        = "${var.INSTANCE_USERNAME}"
     password    = "${var.INSTANCE_PASSWORD}"
     agent       = "false"
    }
  }















provisioner "remote-exec" {
    #when = "destroy"
    inline = ["C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Unrestricted -File C:/shutdown.ps1"]

connection {
    host = "${self.public_ip}"
    port     = 5986
    type = "winrm"
    timeout = "10m"
    user = "${var.INSTANCE_USERNAME}"
    password = "${var.INSTANCE_PASSWORD}"
  }
 }
 
}
