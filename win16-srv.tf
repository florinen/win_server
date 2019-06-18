
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("~/.ssh/my-keys/bastion_key.pub")}"
}
resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${aws_key_pair.my_key.key_name}"
    availability_zone = "${var.AZ}"
    
 
tags = {
    name = "Win16-SRV"
}

 
connection {
    host = "${self.public_ip}"
    type = "winrm"
    timeout = "10m"
    user = "${var.INSTANCE_USERNAME}"
    password = "${var.INSTANCE_PASSWORD}"
  }
vpc_security_group_ids=["${aws_security_group.allowed-ports.id}"]

}