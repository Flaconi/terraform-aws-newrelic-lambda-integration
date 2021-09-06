# Terraform NewRelic integration

This module will create lambda for new relic log ingestion.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| commercetools | >= 3 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| newrelic\_account\_number | n/a | `string` | `""` | no |
| newrelic\_license\_key\_path | n/a | `string` | `""` | no |
| region | n/a | `string` | `"eu-central-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| newrelic\_log\_ingestion\_lambda\_arn | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
