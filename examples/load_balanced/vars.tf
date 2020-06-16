variable "aws_profile" {
  type        = string
  description = "AWS profile for running the TF scripts"
}

variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region for running the TF scripts"
}

variable "service_name" {}
variable "env" {}
variable "vpc_cidr_block" {}
variable "vpc_public_subnets" {}
variable "vpc_private_subnets" {}
variable "vpc_database_subnets" {}
variable "vpc_availability_zones" {}
variable eb_solution_stack_name {
  type = string
  default = "64bit Amazon Linux 2 v3.0.1 running Ruby 2.7"
}