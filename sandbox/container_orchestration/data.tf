data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket = "<bucket-name>"
    key    = "sandbox/use1/networking/terraform.tfstate"
    region = "us-east-1"
  }
}
