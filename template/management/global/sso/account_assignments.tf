#
# IMPORTANT:
# Since the module below looks up the given pricipal (group or user) to get
# its id, it is mandatory that such principal exists beforehand, otherwise it
# will throw an error and cancel the execution. Because of that, whenever you
# create a new group and a permission set that references it, you need to run
# a 2-step procedure in which you first create the group and then create the
# permission set that uses it. The same applies to when you remove or rename
# a group (or user) that is referenced by a permission set.
#
# module "account_assignments" {
#   source = "github.com/binbashar/terraform-aws-sso.git//modules/account-assignments?ref=1.1.1"

#   account_assignments = [
#     # -------------------------------------------------------------------------
#     # Administrators Permissions
#     # -------------------------------------------------------------------------
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["Administrator"].arn
#       permission_set_name = "Administrator"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["administrators"].name
#       account             = var.accounts.management.id
#     },

#     # -------------------------------------------------------------------------
#     # DevOps Permissions
#     # -------------------------------------------------------------------------
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["DevOps"].arn
#       permission_set_name = "DevOps"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["devops"].name
#       account             = var.accounts.security.id
#     },
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["DevOps"].arn
#       permission_set_name = "DevOps"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["devops"].name
#       account             = var.accounts.shared.id
#     },

#     # -------------------------------------------------------------------------
#     # FinOps Permissions
#     # -------------------------------------------------------------------------
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["FinOps"].arn,
#       permission_set_name = "FinOps",
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["finops"].name
#       account             = var.accounts.management.id,
#     },

#     # -------------------------------------------------------------------------
#     # SecurityAuditor Permissions
#     # -------------------------------------------------------------------------
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["SecurityAuditor"].arn
#       permission_set_name = "SecurityAuditor"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["securityauditor"].name
#       account             = var.accounts.security.id
#     },
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["SecurityAuditor"].arn
#       permission_set_name = "SecurityAuditor"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["securityauditor"].name
#       account             = var.accounts.shared.id
#     },

#     # -------------------------------------------------------------------------
#     # ReadOnly Permissions
#     # -------------------------------------------------------------------------
#     {
#       permission_set_arn  = module.permission_sets.permission_sets["ReadOnly"].arn
#       permission_set_name = "ReadOnly"
#       principal_type      = local.principal_type_group
#       principal_name      = local.groups["readonly"].name
#       account             = var.accounts.shared.id
#     },

#   ]
# }
