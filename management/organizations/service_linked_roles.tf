resource "aws_iam_service_linked_role" "access_analyzer" {
    aws_service_name = "access-analyzer.amazonaws.com"
}