terraform {
  required_version = "<= 1.11.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.79.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.profile
}
