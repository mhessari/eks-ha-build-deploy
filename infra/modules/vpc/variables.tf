variable "VPC_CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "AVAILABILITY_ZONES" {
  type    = list(string)
}