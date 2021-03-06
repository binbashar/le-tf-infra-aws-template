#
# Assumable Role Cross-Account: OrganizationAccountAccessRole
#
module "iam_assumable_role_oaar" {
  source = "github.com/binbashar/terraform-aws-iam.git//modules/iam-assumable-role?ref=v4.1.0"

  # Consider that the root is a reserved declaration to refer to every user and role in a certain account
  # (or the root level of a certain account).
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html
  trusted_role_arns = [
    "arn:aws:iam::${var.management_account_id}:root" 
  ]

  create_role           = true
  role_name             = "OrganizationAccountAccessRole"
  admin_role_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  attach_admin_policy   = true
  role_path             = "/"

  #
  # MFA setup
  #
  role_requires_mfa    = false 
  mfa_age              = 3600 # Maximum CLI/API session duration in seconds between 3600 and 43200
  max_session_duration = 7200 # Max age of the session (in seconds) when assuming roles

  tags = local.tags
}
