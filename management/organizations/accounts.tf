#
# Organization accounts
#
resource "aws_organizations_account" "management" {
  name  = "example-project-management"
  email = "aws@example.com"
}

resource "aws_organizations_account" "security" {
  name      = "example-project-security"
  email     = "aws+security@example.com"
  parent_id = aws_organizations_organizational_unit.security.id
}
