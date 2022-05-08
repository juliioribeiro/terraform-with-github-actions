terraform {
  required_version = ">= 1.1.9"

  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "4.13.0"
      }
  }

  backend "s3" {
      bucket = "engineer-remote-state"
      key = "aws-pipeline/terraform.tfstate"
      region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
        owner = "JulioRibeiro"
        managed-by = "terraform"
    }
  }
}