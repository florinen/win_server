variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { 
default = "eu-west-1" 
}
variable "WIN_AMIS" {
type = "map" default = { 
#us-east-1 = "ami-30540427"
#us-west-2 = "ami-9f5efbff"
eu-west-1 = "ami-09437ffdb4f64a361" 
} 
} 
variable "PATH_TO_PRIVATE_KEY" { default = "id_rsa" } 
variable "PATH_TO_PUBLIC_KEY" { default = "id_rsa.pub" 
} 
variable "INSTANCE_USERNAME" { default = "admin" } 
variable "INSTANCE_PASSWORD" { }
