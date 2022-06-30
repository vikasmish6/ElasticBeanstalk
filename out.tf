output "beanstalk_env_url" {
  value = aws_elastic_beanstalk_environment.env.cname
}

output "elastic_load_balancers" {
  value = aws_elastic_beanstalk_environment.env.load_balancers
}

output "beanstalk_security_group_id" {
  value = aws_security_group.elastic_beanstalk_app_sg.id
}

output "beanstalk_service_role_arn" {
  value = aws_iam_role.service_role.arn
}
