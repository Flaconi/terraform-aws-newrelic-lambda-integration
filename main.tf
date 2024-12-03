moved {
  from = aws_s3_bucket.lambda_newrelic_resource
  to   = module.lambda_newrelic_resource_bucket.aws_s3_bucket.this[0]
}

locals {
  name = "newrelic-${random_string.this.result}"
}

resource "random_string" "this" {
  length  = 5
  special = false
}

module "lambda_newrelic_resource_bucket" {
  create_bucket                         = var.create_log_ingestion_stack
  source                                = "github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=v4.1.2"
  tags                                  = var.tags
  bucket_prefix                         = "lambda-newrelic-resource"
  attach_deny_insecure_transport_policy = true
}

resource "aws_s3_object" "newrelic_log_ingestion_zip" {
  count  = var.create_log_ingestion_stack ? 1 : 0
  bucket = module.lambda_newrelic_resource_bucket.s3_bucket_id
  key    = "newrelic-log-ingestion-2.3.5.zip"
  source = "${path.module}/newrelic-log-ingestion.zip"
  etag   = filemd5("${path.module}/newrelic-log-ingestion.zip")
}

resource "aws_cloudformation_stack" "newrelic_log_ingestion" {
  count         = var.create_log_ingestion_stack ? 1 : 0
  name          = "${local.name}-log-ingestion"
  template_body = file("${path.module}/newrelic-log-ingestion.yaml")
  capabilities  = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  parameters = {
    Bucket             = module.lambda_newrelic_resource_bucket.s3_bucket_id
    Key                = aws_s3_object.newrelic_log_ingestion_zip[0].id
    NewRelicLicenseKey = data.aws_ssm_parameter.newrelic_license_key.value
  }
}

output "newrelic_log_ingestion_lambda_arn" {
  value = var.create_log_ingestion_stack ? lookup(aws_cloudformation_stack.newrelic_log_ingestion[0].outputs, "LambdaArn") : null
}

moved {
  from = aws_cloudformation_stack.newrelic_license_key_secret
  to   = aws_cloudformation_stack.newrelic_license_key_secret[0]
}

resource "aws_cloudformation_stack" "newrelic_license_key_secret" {
  count         = var.create_license_key_stack ? 1 : 0
  name          = "NewRelicLicenseKeySecret"
  template_body = file("${path.module}/nr-license-key-secret.yaml")
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    Region     = var.region
    LicenseKey = data.aws_ssm_parameter.newrelic_license_key.value
  }
}

moved {
  from = aws_cloudformation_stack.newrelic_lambda_integration
  to   = aws_cloudformation_stack.newrelic_lambda_integration[0]
}

resource "aws_cloudformation_stack" "newrelic_lambda_integration" {
  count         = var.create_lambda_integration_stack ? 1 : 0
  name          = "${local.name}-lambda-integration"
  template_body = file("${path.module}/nr-lambda-integration-role.yaml")
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    NewRelicAccountNumber = data.aws_ssm_parameter.newrelic_account_number.value
    PolicyName            = ""
  }
}
