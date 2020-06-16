output "beanstalk_env_url" {
  value = aws_elastic_beanstalk_environment.env.cname
}

output "elastic_load_balancers" {
  value = aws_elastic_beanstalk_environment.env.load_balancers
}
