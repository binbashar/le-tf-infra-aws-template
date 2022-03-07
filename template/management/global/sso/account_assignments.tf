module "account_assignments" {
  source = "github.com/binbashar/terraform-aws-sso.git//modules/account-assignments?ref=0.6.1"

  account_assignments = [
    # -------------------------------------------------------------------------
    # AWS_Administrators Permissions
    # -------------------------------------------------------------------------
    {
      account             = var.management_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["Administrator"].arn,
      permission_set_name = "Administrator",
      principal_type      = "GROUP",
      principal_name      = "AWS_Administrators"
    },
    {
      account             = var.shared_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["Administrator"].arn,
      permission_set_name = "Administrator",
      principal_type      = "GROUP",
      principal_name      = "AWS_Administrators"
    },
    {
      account             = var.security_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["Administrator"].arn,
      permission_set_name = "Administrator",
      principal_type      = "GROUP",
      principal_name      = "AWS_Administrators"
    },

    # -------------------------------------------------------------------------
    # AWS_DevOps Permissions
    # -------------------------------------------------------------------------
    {
      account             = var.shared_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["DevOps"].arn,
      permission_set_name = "DevOps",
      principal_type      = "GROUP",
      principal_name      = "AWS_DevOps"
    },
    {
      account             = var.security_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["DevOps"].arn,
      permission_set_name = "DevOps",
      principal_type      = "GROUP",
      principal_name      = "AWS_DevOps"
    },

    # -------------------------------------------------------------------------
    # AWS_FinOps Permissions
    # -------------------------------------------------------------------------
    {
      account             = var.management_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["FinOps"].arn,
      permission_set_name = "FinOps",
      principal_type      = "GROUP",
      principal_name      = "AWS_FinOps"
    },

    # -------------------------------------------------------------------------
    # AWS_Guests Permissions
    # -------------------------------------------------------------------------
    {
      account             = var.shared_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["ReadOnly"].arn,
      permission_set_name = "ReadOnly",
      principal_type      = "GROUP",
      principal_name      = "AWS_Guests"
    },
    {
      account             = var.security_account_id,
      permission_set_arn  = module.permission_sets.permission_sets["ReadOnly"].arn,
      permission_set_name = "ReadOnly",
      principal_type      = "GROUP",
      principal_name      = "AWS_Guests"
    }
  ]
}
