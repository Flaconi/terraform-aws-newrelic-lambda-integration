locals {
  name = "newrelic-${random_string.this.result}"
}

resource "random_string" "this" {
  length  = 5
  special = false
}

resource "aws_s3_bucket" "lambda_newrelic_resource" {
  bucket_prefix = "lambda-newrelic-resource"
  acl           = "private"

  tags = {
    Name = "Created by Terraform"
  }
}

resource "aws_s3_bucket_object" "newrelic_log_ingestion_zip" {
  bucket = aws_s3_bucket.lambda_newrelic_resource.id
  key    = "newrelic-log-ingestion-2.3.5.zip"
  source = "${path.module}/newrelic-log-ingestion.zip"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/newrelic-log-ingestion.zip")
}

resource "aws_cloudformation_stack" "newrelic_log_ingestion" {
  name          = "${local.name}-log-ingestion"
  template_body = file("${path.module}/newrelic-log-ingestion.yaml")
  capabilities  = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  parameters = {
    Bucket             = aws_s3_bucket.lambda_newrelic_resource.id
    Key                = aws_s3_bucket_object.newrelic_log_ingestion_zip.id
    NewRelicLicenseKey = "${data.aws_ssm_parameter.newrelic_license_key.value}"
  }
}

resource "aws_cloudformation_stack" "newrelic_license_key_secret" {
  name          = "NewRelicLicenseKeySecret"
  template_body = file("${path.module}/nr-license-key-secret.yaml")
  capabilities  = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    Region     = var.region
    LicenseKey = "${data.aws_ssm_parameter.newrelic_license_key.value}"
  }
}

output "newrelic_log_ingestion_lambda_arn" {
  value = lookup(aws_cloudformation_stack.newrelic_log_ingestion.outputs, "LambdaArn")
}

resource "aws_cloudformation_stack" "newrelic_lambda_integration" {
  name          = "${local.name}-lambda-integration"
  template_body = file("${path.module}/nr-lambda-integration-role.yaml")
  capabilities  = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_IAM", "CAPABILITY_NAMED_IAM"]
  parameters = {
    NewRelicAccountNumber = "${data.aws_ssm_parameter.newrelic_account_number.value}"
    PolicyName            = ""
  }
}
