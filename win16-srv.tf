
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("~/.ssh/my-keys/bastion_key.pub")}"
}
data "template_file" "userdata" {
  template = "${file("userdata.tpl")}"  

vars = {
    password = "${var.INSTANCE_PASSWORD}"
   }
vars = {
    user     = "${var.INSTANCE_USERNAME}"
   } 
}

resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${aws_key_pair.my_key.key_name}"
    availability_zone = "${var.AZ}"
   # user_data = "${data.template_file.userdata.rendered}" 

tags = {
    name = "Win16-SRV"
}

provisioner "remote-exec" {
    when = "destroy"
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
 vpc_security_group_ids=["${aws_security_group.allowed-ports.id}"]
}
