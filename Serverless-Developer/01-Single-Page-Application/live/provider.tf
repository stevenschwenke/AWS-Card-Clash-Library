terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
