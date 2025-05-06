locals {
  primary_name = var.CLUSTER_NAMES.primary
  standby_name = var.CLUSTER_NAMES.standby
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}