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
  source                                = "github.com/terraform-aws-modules/terraform-aws-s3-bucket?ref=v4.1.2"
  tags                                  = var.tags
  bucket_prefix                         = "lambda-newrelic-resource"
  attach_deny_insecure_transport_policy = true
}

resource "aws_s3_object" "newrelic_log_ingestion_zip" {
  bucket = module.lambda_newrelic_resource_bucket.s3_bucket_id
  key    = "newrelic-log-ingestion-2.3.5.zip"
  source = "${path.module}/newrelic-log-ingestion.zip"
  etag   = filemd5("${path.module}/newrelic-log-ingestion.zip")
}

resource "aws_cloudformation_stack" "newrelic_log_ingestion" {
  name          = "${local.name}-log-ingestion"
  template_body = file("${path.module}/newrelic-log-ingestion.yaml")
  capabilities  = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  parameters = {
    Bucket             = module.lambda_newrelic_resource_bucket.s3_bucket_id
    Key                = aws_s3_object.newrelic_log_ingestion_zip.id
    NewRelicLicenseKey = data.aws_ssm_parameter.newrelic_license_key.value
  }
}

resource "aws_cloudformation_stack" "newrelic_license_key_secret" {
  name          = "NewRelicLicenseKeySecret"
  template_body = file("${path.module}/nr-license-key-secret.yaml")
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    Region     = var.region
    LicenseKey = data.aws_ssm_parameter.newrelic_license_key.value
  }
}

output "newrelic_log_ingestion_lambda_arn" {
  value = lookup(aws_cloudformation_stack.newrelic_log_ingestion.outputs, "LambdaArn")
}

resource "aws_cloudformation_stack" "newrelic_lambda_integration" {
  name          = "${local.name}-lambda-integration"
  template_body = file("${path.module}/nr-lambda-integration-role.yaml")
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    NewRelicAccountNumber = data.aws_ssm_parameter.newrelic_account_number.value
    PolicyName            = ""
  }
}
