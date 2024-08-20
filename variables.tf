variable "newrelic_license_key_path" {
  type    = string
  default = ""
}

variable "newrelic_account_number" {
  type    = string
  default = ""
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
