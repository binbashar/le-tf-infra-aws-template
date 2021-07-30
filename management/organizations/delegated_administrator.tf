resource "null_resource" "enable_delegated_administrator" {
    provisioner "local-exec" {
        command = "aws organizations enable-aws-service-access --service-principal=access-analyzer.amazonaws.com --profile ${var.profile}"
    }
}

resource "aws_organizations_delegated_administrator" "access_analyzer_administrator" {
    account_id = aws_organizations_account.accounts["security"].id
    service_principal = "access-analyzer.amazonaws.com"

    depends_on = [
        aws_organizations_account.accounts["security"],
        null_resource.enable_delegated_administrator
    ]
}
