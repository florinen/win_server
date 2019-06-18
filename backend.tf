terraform {
  backend "s3" {
    bucket = "kube.omegnet.com"
    key    = "windows/win16-srv.tfstate"
    region = "eu-west-1"
  }
}