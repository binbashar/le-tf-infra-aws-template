#
# NOTE: In order to enable AccessAnalyzer with the Organization at the zone of
# of trust in the Security account, this account needs to be set as a delegated
# administrator. Such step cannot be performed by Terraform yet so it was set
# up manually as described below:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-settings.html
#

# NOTE: Check if this can be done purely in Terraform
resource "aws_accessanalyzer_analyzer" "default" {
  analyzer_name = local.access_analyzer_name
  type          = "ORGANIZATION"
  tags          = local.tags
}
