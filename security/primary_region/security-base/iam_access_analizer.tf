#
# Access Analyzer
#
resource "aws_accessanalyzer_analyzer" "default" {
  analyzer_name = "${var.project}-${var.environment}-access-analyzer"
  type          = "ORGANIZATION"
  tags          = local.tags
}
