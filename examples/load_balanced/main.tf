provider "aws" {
  region  = var.region
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

 
resource "aws_elastic_beanstalk_application" "testapp" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}


//Error 1
#Error: InvalidParameterValue: Health transition option settings require enhanced SystemType.
//status code: 400, request id: 1f25b699-a4f8-4269-b0b1-3654c25de702yes
//
//on ../../main.tf line 138, in resource "aws_elastic_beanstalk_environment" "env":
//138: resource "aws_elastic_beanstalk_environment" "env" {


//Error 2
//Error: ConfigurationValidationException: Configuration validation exception: Invalid option value: 'null' (Namespace: 'aws:ec2:vpc', OptionName: 'Subnets'): Specify the subnets for the VPC.
//status code: 400, request id: c06491c6-35e0-4119-b702-c95edd1ea632
//
//on ../../main.tf line 138, in resource "aws_elastic_beanstalk_environment" "env":
//138: resource "aws_elastic_beanstalk_environment" "env" {


module "elastic_beanstalk_environment" {
  source                          = "../../"
  eb_app_name                     = "tf-test-name"
  env                             = var.env
  service_name                    = var.service_name
  description                     = "My Dotnet test Env"
  solution_stack_name             = var.eb_solution_stack_name
  vpc_id                          = "vpc-214f0a48"
  enable_enhanced_healthreporting = true
  private_subnets                 = ["subnet-eb4e0882","subnet-63b60e2e"]
  public_subnets                  = ["subnet-eb4e0882","subnet-63b60e2e"]
  asg_max_count                   = "2"
  asg_min_count                   = "1"
}
