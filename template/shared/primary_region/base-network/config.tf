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
  required_version = ">= 0.14.11"

  required_providers {
    aws = "~> 3.0"
  }

  backend "s3" {
    key = "shared/network/terraform.tfstate"
  }
}

#=============================#
# Data sources                #
#=============================#

# Tools VPN Server remote states
# To be used after `tools-vpn-server` layer is deployed
# data "terraform_remote_state" "tools-vpn-server" {
#   backend = "s3"

#   config = {
#     region  = var.region
#     profile = var.profile
#     bucket  = var.bucket
#     key     = "${var.environment}/vpn/terraform.tfstate"
#   }
# }
