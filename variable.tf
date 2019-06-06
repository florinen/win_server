variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "eu-west-1" }
variable "VPC_ID" {}
variable "AZ" {}
variable "WIN_AMIS" { }  
variable "PATH_TO_PRIVATE_KEY" { default = "/home/fnenciu/windows/win_key" } 
variable "PATH_TO_PUBLIC_KEY" { default = "/home/fnenciu/windows/win_key.pub" } 
variable "INSTANCE_USERNAME" { default = "Administrator" } 
variable "INSTANCE_PASSWORD" { }
variable "INSTANCE_TYPE" {}
variable "SG_GRP" { default = "sg-0bcbc6322afe76fec" }



