variable "newrelic_license_key_path" {
  type    = string
  default = ""
}

variable "newrelic_account_number" {
  type    = string
  default = ""
}

variable "create_license_key_stack" {
  type    = bool
  default = true
}

variable "create_log_ingestion_stack" {
  type    = bool
  default = true
}

variable "create_lambda_integration_stack" {
  type    = bool
  default = true
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "tags" {
  description = "Map of custom tags for the provisioned resources"
  type        = map(string)
  default     = {}
}
