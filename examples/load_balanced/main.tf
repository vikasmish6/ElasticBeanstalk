provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

module "vpc" {
  source             = "scalereal/vpc/aws"
  version            = "0.0.1"
  availability_zones = var.vpc_availability_zones
  cidr_block         = var.vpc_cidr_block
  database_subnets   = var.vpc_database_subnets
  environment                = var.environment
  private_subnets    = var.vpc_private_subnets
  public_subnets     = var.vpc_public_subnets
  service_name       = var.service_name
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["elasticbeanstalk.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "this" {
  name               = "eb_appversion_deletion_role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

module "elastic_beanstalk_application" {
  source                      = "scalereal/elastic-beanstalk-application/aws"
  version                     = "0.0.1"
  name                        = "Ruby App"
  appversion_service_role_arn = aws_iam_role.this.arn
  appversion_max_age_in_days  = 90
}

//Error 1
#Error: InvalidParameterValue: Health transition option settings require enhanced SystemType.
//status code: 400, request id: 1f25b699-a4f8-4269-b0b1-3654c25de702yes
//
//on ../../main.tf line 138, in resource "aws_elastic_beanstalk_environment" "environment":
//138: resource "aws_elastic_beanstalk_environment" "environment" {


//Error 2
//Error: ConfigurationValidationException: Configuration validation exception: Invalid option value: 'null' (Namespace: 'aws:ec2:vpc', OptionName: 'Subnets'): Specify the subnets for the VPC.
//status code: 400, request id: c06491c6-35e0-4119-b702-c95edd1ea632
//
//on ../../main.tf line 138, in resource "aws_elastic_beanstalk_environment" "environment":
//138: resource "aws_elastic_beanstalk_environment" "environment" {


module "elastic_beanstalk_environment" {
  source                          = "../../"
  eb_app_name                     = module.elastic_beanstalk_application.name
  environment                             = var.environment
  service_name                    = var.service_name
  description                     = "My Ruby test environment"
  solution_stack_name             = var.eb_solution_stack_name
  vpc_id                          = module.vpc.id
  enable_enhanced_healthreporting = true
  private_subnets                 = module.vpc.private_subnets_ids
  public_subnets                  = module.vpc.public_subnet_ids
  asg_max_count                   = "2"
  asg_min_count                   = "1"
}
