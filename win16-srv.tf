
resource "aws_key_pair" "win_key" {
    key_name = "win_key"
    public_key = "${file("~/.ssh/win-dc01.pub")}"
}

### Bootstrap instance for WinRM over HTTP with basic authentication
data "template_file" "userdata" {
  template =   "${file("data.tpl")}"
  vars = {
      admin_password = "${var.admin_password}"   #pass variables into template
       
  }
}
 
resource "aws_instance" "win16-srv" {
    ami = "${var.WIN_AMIS}"
    instance_type = "${var.INSTANCE_TYPE}"
    key_name = "win_key"
    availability_zone = "${var.AZ}"
    user_data = "${data.template_file.userdata.rendered}"
    vpc_security_group_ids=["${aws_security_group.allowed-ports.id}"]

    root_block_device {
        volume_size = "60"
      }
  

### Allow AWS infrastructure metadata to propagate ###
  provisioner "local-exec" {
    command = "sleep 60"
  }
  ### Copy Scripts to EC2 instance ###
  provisioner "file" {
    source      = "~/win_server/ad"
    destination = "C:\\scripts"
 
    connection {
      host        = "${self.public_ip}"
    #port       = 5986
      type        = "winrm"
      timeout     = "10m"
      user        = "${var.admin_user}"
      password    = "${var.admin_password}"
      agent       = "false"
      }
  }

### Set Execution Policy to Remote-Signed, Configure Active Directory ###
  provisioner "remote-exec" {
    
    connection {
      host        = "${self.public_ip}"
      type        = "winrm"
      user        = "Administrator"
      password    = "${var.admin_password}"
      agent       = "false"
     }
     inline = [
      "powershell.exe Set-ExecutionPolicy RemoteSigned -force",
      "powershell.exe -version 4 -ExecutionPolicy Bypass -File C:\\scripts\\ad_init.ps1  "
            
    ]
  }
  
  tags = {
      Name = "Win16-SRV"
  }
}
resource "aws_eip" "eip" {
    instance = "${aws_instance.win16-srv.id}"
    
    tags = {
      Name = "Static IP Win16-srv"
  }
   }

















 