# terraform-aws-elastic-beanstalk-environment
Terraform Module for AWS elastic beanstalk environment creation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.50 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.50 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elastic_beanstalk_environment.env](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_environment) | resource |
| [aws_iam_instance_profile.ec2_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policy_attachment_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy_attachment_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy_attachment_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy_attachment_4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.elastic_beanstalk_app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | n/a | `string` | `"80"` | no |
| <a name="input_asg_max_count"></a> [asg\_max\_count](#input\_asg\_max\_count) | n/a | `string` | `"1"` | no |
| <a name="input_asg_min_count"></a> [asg\_min\_count](#input\_asg\_min\_count) | n/a | `string` | `"1"` | no |
| <a name="input_autoscale_breach_duration"></a> [autoscale\_breach\_duration](#input\_autoscale\_breach\_duration) | n/a | `string` | `"1"` | no |
| <a name="input_autoscale_lower_breach_scale_increment"></a> [autoscale\_lower\_breach\_scale\_increment](#input\_autoscale\_lower\_breach\_scale\_increment) | n/a | `string` | `"-1"` | no |
| <a name="input_autoscale_lower_threshold"></a> [autoscale\_lower\_threshold](#input\_autoscale\_lower\_threshold) | n/a | `string` | `"20"` | no |
| <a name="input_autoscale_measure_name"></a> [autoscale\_measure\_name](#input\_autoscale\_measure\_name) | n/a | `string` | `"CPUUtilization"` | no |
| <a name="input_autoscale_period"></a> [autoscale\_period](#input\_autoscale\_period) | n/a | `string` | `"1"` | no |
| <a name="input_autoscale_unit"></a> [autoscale\_unit](#input\_autoscale\_unit) | n/a | `string` | `"Percent"` | no |
| <a name="input_autoscale_upper_breach_scale_increment"></a> [autoscale\_upper\_breach\_scale\_increment](#input\_autoscale\_upper\_breach\_scale\_increment) | n/a | `string` | `"1"` | no |
| <a name="input_autoscale_upper_threshold"></a> [autoscale\_upper\_threshold](#input\_autoscale\_upper\_threshold) | n/a | `string` | `"80"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `string` | `"Any"` | no |
| <a name="input_aws_acm_certificate_arn"></a> [aws\_acm\_certificate\_arn](#input\_aws\_acm\_certificate\_arn) | ACM Certificate ARN | `string` | `""` | no |
| <a name="input_aws_key_pair_name"></a> [aws\_key\_pair\_name](#input\_aws\_key\_pair\_name) | SSH key for elastic beanstalk ec2 instances | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | n/a | yes |
| <a name="input_disable_ignore_4xx_errors"></a> [disable\_ignore\_4xx\_errors](#input\_disable\_ignore\_4xx\_errors) | n/a | `bool` | `false` | no |
| <a name="input_eb_app_name"></a> [eb\_app\_name](#input\_eb\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_elb_scheme"></a> [elb\_scheme](#input\_elb\_scheme) | n/a | `string` | `"public"` | no |
| <a name="input_enable_delete_health_logs_on_terminate"></a> [enable\_delete\_health\_logs\_on\_terminate](#input\_enable\_delete\_health\_logs\_on\_terminate) | n/a | `string` | `true` | no |
| <a name="input_enable_delete_logs_on_terminate"></a> [enable\_delete\_logs\_on\_terminate](#input\_enable\_delete\_logs\_on\_terminate) | n/a | `string` | `true` | no |
| <a name="input_enable_enhanced_healthreporting"></a> [enable\_enhanced\_healthreporting](#input\_enable\_enhanced\_healthreporting) | n/a | `bool` | `false` | no |
| <a name="input_enable_health_logs_streaming"></a> [enable\_health\_logs\_streaming](#input\_enable\_health\_logs\_streaming) | n/a | `string` | `true` | no |
| <a name="input_enable_logs_streaming"></a> [enable\_logs\_streaming](#input\_enable\_logs\_streaming) | n/a | `bool` | `true` | no |
| <a name="input_enable_ssl"></a> [enable\_ssl](#input\_enable\_ssl) | n/a | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | n/a | `string` | `"LoadBalanced"` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | n/a | `map(string)` | `{}` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | n/a | `string` | `"1"` | no |
| <a name="input_extra_settings"></a> [extra\_settings](#input\_extra\_settings) | n/a | <pre>list(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>  }))</pre> | `[]` | no |
| <a name="input_health_log_retention_in_days"></a> [health\_log\_retention\_in\_days](#input\_health\_log\_retention\_in\_days) | n/a | `string` | `"3"` | no |
| <a name="input_healthcheck_url"></a> [healthcheck\_url](#input\_healthcheck\_url) | n/a | `string` | `"/"` | no |
| <a name="input_instance_port"></a> [instance\_port](#input\_instance\_port) | n/a | `string` | `"80"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | n/a | `string` | `"application"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | n/a | `string` | `"3"` | no |
| <a name="input_notification_email"></a> [notification\_email](#input\_notification\_email) | n/a | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | CIDR for private subnet vpc | `list(string)` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | CIDRs for public subnets | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_solution_stack_name"></a> [solution\_stack\_name](#input\_solution\_stack\_name) | n/a | `string` | n/a | yes |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | n/a | `string` | `"Minimum"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for EB | `map(string)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | n/a | `string` | `"WebServer"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_wait_for_ready_timeout"></a> [wait\_for\_ready\_timeout](#input\_wait\_for\_ready\_timeout) | n/a | `string` | `"20m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_beanstalk_env_url"></a> [beanstalk\_env\_url](#output\_beanstalk\_env\_url) | n/a |
| <a name="output_beanstalk_security_group_id"></a> [beanstalk\_security\_group\_id](#output\_beanstalk\_security\_group\_id) | n/a |
| <a name="output_beanstalk_service_role_arn"></a> [beanstalk\_service\_role\_arn](#output\_beanstalk\_service\_role\_arn) | n/a |
| <a name="output_elastic_load_balancers"></a> [elastic\_load\_balancers](#output\_elastic\_load\_balancers) | n/a |
<!-- END_TF_DOCS -->
