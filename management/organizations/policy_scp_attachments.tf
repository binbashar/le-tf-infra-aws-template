#
# Organizational Units' Policies
#
resource "aws_organizations_policy_attachment" "security" {
  policy_id = aws_organizations_policy.default.id
  target_id = aws_organizations_organizational_unit.security.id
}
