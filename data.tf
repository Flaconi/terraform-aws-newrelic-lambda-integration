data "aws_ssm_parameter" "newrelic_license_key" {
  name            = var.newrelic_license_key_path
  with_decryption = true
}

data "aws_ssm_parameter" "newrelic_account_number" {
  name            = var.newrelic_account_number
  with_decryption = true
}
