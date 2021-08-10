#
# Organization accounts
#
# Uncomment after first `apply`
#resource "aws_organizations_account" "management" {
#  name  = "${var.project_long}-management"
#  email = local.management_account.email
#}

resource "aws_organizations_account" "accounts" {
  for_each = local.accounts

  name      = "${var.project_long}-${each.key}"
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.units[each.value.parent_ou].id
}