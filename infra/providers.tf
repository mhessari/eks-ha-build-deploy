terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region     = var.AWS_REGION

  default_tags {
    tags = {
      Project   = "eks-ha-build-deploy"
      ManagedBy = "Terraform"
    }
  }
}