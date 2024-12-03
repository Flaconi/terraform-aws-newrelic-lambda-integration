# Terraform NewRelic integration
This module will create lambda for new relic log ingestion.


<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.78 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_MODULES_START -->
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_newrelic_resource_bucket"></a> [lambda\_newrelic\_resource\_bucket](#module\_lambda\_newrelic\_resource\_bucket) | github.com/terraform-aws-modules/terraform-aws-s3-bucket | v4.1.2 |

<!-- TFDOCS_MODULES_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.78 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_newrelic_license_key_path"></a> [newrelic\_license\_key\_path](#input\_newrelic\_license\_key\_path)

Description: n/a

Type: `string`

Default: `""`

### <a name="input_newrelic_account_number"></a> [newrelic\_account\_number](#input\_newrelic\_account\_number)

Description: n/a

Type: `string`

Default: `""`

### <a name="input_create_license_key_stack"></a> [create\_license\_key\_stack](#input\_create\_license\_key\_stack)

Description: n/a

Type: `bool`

Default: `true`

### <a name="input_create_log_ingestion_stack"></a> [create\_log\_ingestion\_stack](#input\_create\_log\_ingestion\_stack)

Description: n/a

Type: `bool`

Default: `true`

### <a name="input_create_lambda_integration_stack"></a> [create\_lambda\_integration\_stack](#input\_create\_lambda\_integration\_stack)

Description: n/a

Type: `bool`

Default: `true`

### <a name="input_region"></a> [region](#input\_region)

Description: n/a

Type: `string`

Default: `"eu-central-1"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Map of custom tags for the provisioned resources

Type: `map(string)`

Default: `{}`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_newrelic_log_ingestion_lambda_arn"></a> [newrelic\_log\_ingestion\_lambda\_arn](#output\_newrelic\_log\_ingestion\_lambda\_arn) | n/a |

<!-- TFDOCS_OUTPUTS_END -->
