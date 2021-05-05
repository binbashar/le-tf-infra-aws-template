#
# users.tf sensitive data output
#
output "user_example_user_name" {
  description = "The user's name"
  value       = module.user_example_user.this_iam_user_name
}

output "user_example_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.user_example_user.this_iam_user_login_profile_encrypted_password
  sensitive   = true
}
