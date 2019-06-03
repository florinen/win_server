
resource "aws_key_pair" "win_key" {
    key_name = "win_key"
    public_key = "${file("/home/fnenciu/windows/win_key.pub")}"
}
resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "${aws_key_pair.win_key.key_name}"
    availability_zone = "${var.AZ}"
    user_data = "$"
    
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
