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
  required_version = ">= 0.12.28"

  required_providers {
    aws = "~> 2.69"
  }

  backend "s3" {
    key = "management/identities/terraform.tfstate"
  }
}
