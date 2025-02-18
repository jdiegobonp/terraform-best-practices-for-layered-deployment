data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket = "<bucket-name>"
    key    = "sandbox/use1/networking/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "container_orchestration" {
  backend = "s3"

  config = {
    bucket = "<bucket-name>"
    key    = "sandbox/use1/container_orchestration/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id
}