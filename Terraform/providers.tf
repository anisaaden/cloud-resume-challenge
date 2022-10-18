terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.23.0"
    }
  }

backend "s3" {
    bucket = "anisaaden.com-terraform"
    key = "prod/terraform.tfstate"
    region = "us-east-1"
}
}

provider "aws" {
  region = "us-east-1"
}

