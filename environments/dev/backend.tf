terraform {
  backend "s3" {
    bucket         = "iac.tfstate.dev"
    key            = "dev/ec2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "iac-state-lock"
  }
}