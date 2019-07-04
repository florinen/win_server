variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "eu-west-1" }
variable "VPC_ID" {}
variable "AZ" {}
variable "WIN_AMIS" { }
variable "INSTANCE_TYPE" { }
variable "PATH_TO_PRIVATE_KEY" { default = "~/.ssh/id_rsa" } 
variable "PATH_TO_PUBLIC_KEY" { default = "~/.ssh/id_rsa.pub" } 
variable "admin_user" { } 
variable "admin_password" {
    description = "Windows Administrator password to login as"
 }


