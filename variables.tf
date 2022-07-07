variable "service_name" {
  type        = string
  description = ""
}

variable "description" {
  type        = string
  description = ""
}

variable "environment" {
  type        = string
  description = "Environment Name like Prod, Testing"
}

variable "vpc_id" {
  type        = string
  description = ""
}

variable "eb_app_name" {
  type        = string
  description = ""
}

variable "aws_acm_certificate_arn" {
  description = "ACM Certificate ARN"
  default     = ""
}

variable "public_subnets" {
  type        = list(string)
  default     = []
  description = "CIDRs for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "CIDR for private subnet vpc"
}

variable "aws_key_pair_name" {
  type        = string
  default     = ""
  description = "SSH key for elastic beanstalk ec2 instances"
}

variable "healthcheck_url" {
  type        = string
  default     = "/"
  description = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for EB"
}

variable instance_type {
  type        = string
  default     = "t2.micro"
  description = ""
}

variable asg_max_count {
  type        = string
  default     = "1"
  description = ""
}

variable asg_min_count {
  type        = string
  default     = "1"
  description = ""
}

variable notification_email {
  type        = string
  default     = ""
  description = ""
}

variable "autoscale_breach_duration" {
  default = "1"
}

variable "autoscale_lower_breach_scale_increment" {
  default = "-1"
}

variable "autoscale_lower_threshold" {
  default = "20"
}

variable "autoscale_measure_name" {
  default = "CPUUtilization"
}

variable "autoscale_period" {
  default = "1"
}

variable "evaluation_periods" {
  default = "1"
}

variable "statistic" {
  default = "Minimum"
}

variable "autoscale_unit" {
  default = "Percent"
}

variable "autoscale_upper_breach_scale_increment" {
  default = "1"
}

variable "autoscale_upper_threshold" {
  default = "80"
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "extra_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))
  default = []
}

variable elb_scheme {
  type    = string
  default = "public"
}

variable "application_port" {
  default = "80"
}

variable "enable_ssl" {
  default = false
}

variable "tier" {
  default = "WebServer"
}

variable solution_stack_name {
  type = string
}

variable "environment_type" {
  default = "LoadBalanced"
}

variable load_balancer_type {
  type    = string
  default = "application"
}

variable availability_zones {
  type    = string
  default = "Any"
}

variable wait_for_ready_timeout {
  type    = string
  default = "20m"
}

variable "disable_ignore_4xx_errors" {
  type    = bool
  default = false
}

variable "enable_enhanced_healthreporting" {
  type    = bool
  default = false
}

variable log_retention_in_days {
  type    = string
  default = "3"
}

variable health_log_retention_in_days {
  type    = string
  default = "3"
}

variable enable_logs_streaming {
  type    = bool
  default = true
}

variable enable_health_logs_streaming {
  type    = string
  default = true
}

variable enable_delete_logs_on_terminate {
  type    = string
  default = true
}

variable enable_delete_health_logs_on_terminate {
  type    = string
  default = true
}

variable instance_port {
  type    = string
  default = "80"
}
