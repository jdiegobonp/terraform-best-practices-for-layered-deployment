terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.87"
    }
  }

  backend "s3" {
    bucket         = "<bucket-name>" 
    key            = "sandbox/use1/networking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<dynamodb-table-name>" 
  }
}
