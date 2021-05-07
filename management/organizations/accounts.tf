#
# Organization accounts
#
resource "aws_organizations_account" "management" {
  name  = "leverage-management"
  email = "aws@leverage.com"
}

resource "aws_organizations_account" "security" {
  name      = "leverage-security"
  email     = "aws+security@leverage.com"
  parent_id = aws_organizations_organizational_unit.security.id
}
