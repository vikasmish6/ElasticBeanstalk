locals {
  elb_settings = [
    {
      namespace = "aws:elb:loadbalancer"
      name      = "CrossZone"
      value     = "true"
      resource  = ""
    },
    {
      namespace = "aws:ec2:vpc"
      name      = "ELBSubnets"
      value     = join(",", var.public_subnets)
      resource  = ""
    },
    //        {
    //            namespace = "aws:elb:loadbalancer"
    //            name      = "SecurityGroups"
    //            value     = join(",", var.loadbalancer_security_groups)
    //        },
    //        {
    //            namespace = "aws:elb:loadbalancer"
    //            name      = "ManagedSecurityGroup"
    //            value     = var.loadbalancer_managed_security_group
    //        },
    {
      namespace = "aws:elb:listener"
      name      = "ListenerProtocol"
      value     = "HTTP"
      resource  = ""
    },
    {
      namespace = "aws:elb:listener"
      name      = "InstancePort"
      value     = var.application_port
      resource  = ""
    },
    {
      namespace = "aws:ec2:vpc"
      name      = "ELBScheme"
      value     = var.elb_scheme
      resource  = ""
    },
    {
      namespace = "aws:elb:listener"
      name      = "ListenerEnabled"
      value     = "true"
      resource  = ""
    },
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "HealthCheckPath"
      value     = var.healthcheck_url
      resource  = ""
    },
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Port"
      value     = var.application_port
      resource  = ""
    },
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Protocol"
      value     = "HTTP"
      resource  = ""
    },
    {
      namespace = "aws:elbv2:listener:default"
      name      = "ListenerEnabled"
      value     = true
      resource  = ""
    },
    {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "StickinessEnabled"
      value     = "true"
      resource  = ""
    }
  ]

  ssl_settings = [
    {
      namespace = "aws:elb:listener:443"
      name      = "ListenerProtocol"
      value     = "HTTPS"
      resource  = ""
    },
    {
      namespace = "aws:elb:listener:443"
      name      = "InstancePort"
      value     = "80"
      resource  = ""
    },
    {
      namespace = "aws:elb:listener:443"
      name      = "SSLCertificateArns"
      value     = var.aws_acm_certificate_arn
      resource  = ""
    },
    {
      namespace = "aws:elb:listener:443"
      name      = "ListenerEnabled"
      value     = "true"
      resource  = ""
    },
    {
      namespace = "aws:elbv2:listener:443"
      name      = "ListenerEnabled"
      value     = true
      resource  = ""
    },
    {
      namespace = "aws:elbv2:listener:443"
      name      = "Protocol"
      value     = "HTTPS"
      resource  = ""
    },
    {
      namespace = "aws:elbv2:listener:443"
      name      = "SSLCertificateArns"
      value     = var.aws_acm_certificate_arn
      resource  = ""
    }
  ]

  elb_settings_acc = var.enable_ssl && var.aws_acm_certificate_arn != "" ? concat(local.elb_settings, local.ssl_settings) : local.elb_settings

  elb_settings_to_use = var.tier == "Worker" ? [] : local.elb_settings_acc
}


resource "aws_security_group" "elastic_beanstalk_app_sg" {
  vpc_id = var.vpc_id
  name   = "${var.service_name}-${var.environment}-elastic-beanstalk-app-sg"
  tags   = var.tags
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                   = "${var.service_name}-${var.environment}-environment"
  description            = var.description
  application            = var.eb_app_name
  solution_stack_name    = var.solution_stack_name
  wait_for_ready_timeout = var.wait_for_ready_timeout
  tags                   = var.tags
  tier                   = var.tier

  #=============================================VPC=========================================================

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
    resource  = ""
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.environment_type != "LoadBalanced" ? var.public_subnets : var.private_subnets)
    resource  = ""
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = var.environment_type != "LoadBalanced" ? true : false
    resource  = ""
  }

  #=============================================Autoscaling================================================


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2_iam_instance_profile.name
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.elastic_beanstalk_app_sg.id
    resource  = ""
  }

  setting {
    name      = "EC2KeyName"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.aws_key_pair_name
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.asg_min_count
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = var.availability_zones
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.asg_max_count
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "BreachDuration"
    value     = var.autoscale_breach_duration
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = var.autoscale_lower_breach_scale_increment
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = var.autoscale_lower_threshold
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = var.autoscale_measure_name
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Period"
    value     = var.autoscale_period
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "EvaluationPeriods"
    value     = var.evaluation_periods
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = var.statistic
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = var.autoscale_unit
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = var.autoscale_upper_breach_scale_increment
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = var.autoscale_upper_threshold
    resource  = ""
  }

  #================================================eb environment=========================================


  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = var.load_balancer_type
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.service_role.id
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.environment_type
    resource  = ""
  }

  #==============================================elb======================================================

  dynamic "setting" {
    for_each = local.elb_settings_to_use
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
      resource  = ""
    }
  }

  #==============================================cloudwatch & health=======================================


  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = var.enable_logs_streaming
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "HealthStreamingEnabled"
    value     = var.enable_health_logs_streaming
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = var.enable_enhanced_healthreporting ? "enhanced" : "basic"
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "ConfigDocument"
    value     = jsonencode({ "Rules" : { "Environment" : { "ELB" : { "ELBRequests4xx" : { "Enabled" : var.disable_ignore_4xx_errors } }, "Application" : { "ApplicationRequests4xx" : { "Enabled" : var.disable_ignore_4xx_errors } } } }, "Version" : 1 })
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = var.enable_delete_logs_on_terminate
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "DeleteOnTerminate"
    value     = var.enable_delete_health_logs_on_terminate
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "RetentionInDays"
    value     = var.log_retention_in_days
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "RetentionInDays"
    value     = var.health_log_retention_in_days
    resource  = ""
  }

  #===============================================SNS======================================

  setting {
    namespace = "aws:elasticbeanstalk:sns:topics"
    name      = "Notification Endpoint"
    value     = var.notification_email
    resource  = ""
  }

  #===============================================Extra===================================

  dynamic "setting" {
    for_each = var.extra_settings
    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
      resource  = ""
    }
  }

  #==============================================environment_variables====================

  dynamic "setting" {
    for_each = var.environment_variables
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
      resource  = ""
    }
  }
}
