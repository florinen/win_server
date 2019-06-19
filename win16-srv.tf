
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("~/.ssh/my-keys/bastion_key.pub")}"
}
data "template_file" "userdata" {
  template =   "${file("~/windows/win_server/data.tpl")}"
  vars = {
      admin_password = "${var.admin_password}"
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
    source      = "~/windows/win_server/ad/"
    destination = "C:\\scripts"
  }
   connection {
    host        = "${self.public_ip}"
    #port       = 5986
    type        = "winrm"
    timeout     = "10m"
    user        = "${var.admin_user}"
    password    = "${var.admin_password}"
    agent       = "false"
    }

### Set Execution Policy to Remote-Signed, Configure Active Directory ###
  provisioner "remote-exec" {
    inline = [
      "powershell.exe Set-ExecutionPolicy RemoteSigned -force",
      "powershell.exe -version 4 -ExecutionPolicy Bypass -File C:\\scripts\\ad_init.ps1",
      "powershell.exe -ExecutionPolicy Bypass -NoProfile -File C:\\Scripts\\ad_add_domain_users.ps1"
    ]
  }
  
    connection = {
      host        = "${self.public_ip}"
      type        = "winrm"
      user        = "Administrator"
      password    = "${var.admin_password}"
      agent       = "false"
     }
    
  }














#provisioner "remote-exec" {
    #when = "destroy"
 #   inline = ["C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Unrestricted -File C:/shutdown.ps1"]


 