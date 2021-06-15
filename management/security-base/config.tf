#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/${var.project}/config"
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.14.4"

  required_providers {
    aws = "~> 3.2"
  }

  backend "s3" {
    key = "management/security-base/terraform.tfstate"
  }
}