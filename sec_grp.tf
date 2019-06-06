resource "aws_security_group" "Allowed_Ports" {
    name    ="allow-ports"
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
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "-1"
    security_groups = "${var.SG_GRP}"
    #cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allowed-Ports"
  }
}