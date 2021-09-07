# Terraform NewRelic integration

This module will create lambda for new relic log ingestion.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.57 |
| random | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.57 |
| random | >= 3.1 |

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
