variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { 
default = "eu-west-1" 
}
variable "WIN_AMIS" { }  
variable "PATH_TO_PRIVATE_KEY" { default = "~/.ssh/id_rsa" } 
variable "PATH_TO_PUBLIC_KEY" { default = "~/.ssh/id_rsa.pub" } 
variable "INSTANCE_USERNAME" { default = "admin" } 
variable "INSTANCE_PASSWORD" { }
