
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region for running the TF scripts"
}

variable "service_name" {}
variable "env" {}
variable eb_solution_stack_name {
  type = string
  default = "64bit Amazon Linux 2 v3.0.1 running Ruby 2.7"
}