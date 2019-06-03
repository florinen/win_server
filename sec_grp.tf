resource "aws_security_group" "Allow-RDP" {
    name    ="allow-rdp"
    vpc_id  = "${var.VPC_ID}"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "Allow-RDP"
  }
}