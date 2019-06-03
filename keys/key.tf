resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("/root/acirrustech.com/windows/config/my_key.pub")}"
}