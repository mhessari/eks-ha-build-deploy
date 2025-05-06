terraform {
  backend "s3" {
    bucket  = "eks-ha-terraform-state"
    key     = "eks-ha-build-deploy/infra/terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
  }
}