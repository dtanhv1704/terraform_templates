terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.23"
    }
  }
}

provider "aws" {
    profile = var.profile
    region  = var.region
}
