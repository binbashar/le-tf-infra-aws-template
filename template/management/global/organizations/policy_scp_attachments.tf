#
# Organizational Units' Policies
#
resource "aws_organizations_policy_attachment" "policy_attachments" {
  for_each = local.organizational_units

  policy_id = each.value.policy.id
  target_id = aws_organizations_organizational_unit.units[each.key].id

  depends_on = [
    aws_organizations_organizational_unit.units
  ]
}
