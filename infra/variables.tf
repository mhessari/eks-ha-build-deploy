variable "AWS_REGION" {
  type    = string
  default = "ca-central-1"
}

variable "VPC_CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "AVAILABILITY_ZONES" {
  type = list(string)
  default = ["ca-central-1a",
    "ca-central-1b",
  "ca-central-1d"]
}

variable "CLUSTER_NAMES" {
  type = map(string)
  default = {
    primary = "eks-ha-primary"
    standby = "eks-ha-standby"
  }
}

variable "NODE_INSTANCE_TYPES" {
  type    = string
  default = "t3.medium"
}

variable "NODE_DESIRED_SIZE" {
  type    = number
  default = 1
}

variable "NODE_MAX_SIZE" {
  type    = number
  default = 1
}

variable "NODE_MIN_SIZE" {
  type    = number
  default = 1
}