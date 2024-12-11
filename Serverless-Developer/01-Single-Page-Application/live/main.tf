data "aws_caller_identity" "stage" {}

locals {
    account_id = data.aws_caller_identity.stage.account_id
}

module web-app {
    source = "../modules/web-app"
    account_id = local.account_id
}

output "web_app_cloudfront_distribution_domain_name" {
    value = module.web-app.cloudfront_distribution_domain_name
}

output "web_app_cloudfront_distribution_id" {
    value = module.web-app.cloudfront_distribution_id
}
