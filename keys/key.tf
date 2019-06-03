resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = "${file("/home/fnenciu/windows/win_key.pub")}"
}