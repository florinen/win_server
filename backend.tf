terraform {
 backend "s3" {
    bucket = "acirrustech-iaac" 
    region = "us-east-1" 
    key    = "win-dc01/infra"
  }
}
