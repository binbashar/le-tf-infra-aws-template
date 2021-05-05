#
# Organizational Units
#
resource "aws_organizations_organizational_unit" "security" {
  name      = "security"
  parent_id = aws_organizations_organization.main.roots.0.id
}
