resource "aws_accessanalyzer_analyzer" "default" {
  analyzer_name = "${var.project}-access-analyzer"
  type          = "ORGANIZATION"
  tags          = local.tags
}
