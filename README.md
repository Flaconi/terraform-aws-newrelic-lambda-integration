# Terraform NewRelic integration

This module will create lambda for new relic log ingestion.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.57 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.newrelic_lambda_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack.newrelic_license_key_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack.newrelic_log_ingestion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_s3_bucket.lambda_newrelic_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.newrelic_log_ingestion_zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_ssm_parameter.newrelic_account_number](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.newrelic_license_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_newrelic_account_number"></a> [newrelic\_account\_number](#input\_newrelic\_account\_number) | n/a | `string` | `""` | no |
| <a name="input_newrelic_license_key_path"></a> [newrelic\_license\_key\_path](#input\_newrelic\_license\_key\_path) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_newrelic_log_ingestion_lambda_arn"></a> [newrelic\_log\_ingestion\_lambda\_arn](#output\_newrelic\_log\_ingestion\_lambda\_arn) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
