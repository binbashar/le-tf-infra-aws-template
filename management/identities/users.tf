#
# AWS IAM Users
#
#============================#
# User: Example User         #
#============================#
module "user_example_user" {
  source = "github.com/binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.20.0"

  name                    = "example.user"
  force_destroy           = true
  password_reset_required = true
  password_length         = 30

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = file("keys/example.user")
}
