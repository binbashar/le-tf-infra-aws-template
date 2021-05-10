#
# Groups
#
module "iam_group_admins" {
  source = "github.com/binbashar/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v3.16.0"
  name   = "admins_management_org"

  group_users = [
    module.user_example_user.this_iam_user_name
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

module "iam_group_finops" {
  source = "github.com/binbashar/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v3.16.0"
  name   = "finops_management_org"

  group_users = [
    module.user_example_user.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
  ]
}
