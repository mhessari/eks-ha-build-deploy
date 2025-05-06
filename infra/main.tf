locals {
  primary_name = var.CLUSTER_NAMES.primary
  standby_name = var.CLUSTER_NAMES.standby
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

module "vpc" {
  source = "./modules/vpc"
  
  VPC_CIDR          = "10.0.0.0/16"
  AVAILABILITY_ZONES = ["ca-central-1a", "ca-central-1b", "ca-central-1d"]
}