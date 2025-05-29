output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "public_subnet2_id" {
  value = module.vpc.public_subnet2_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "ec2_public_ip" {
  value = module.ec2.web_server_public_ip
}

output "s3_bucket_name" {
  value = module.ec2.s3_bucket_name
}

output "load_balancer_dns" {
  value = module.alb.alb_dns_name
}

output "sns_topic_arn" {
  value = module.monitoring.sns_topic_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "asg_name" {
  value = module.asg.asg_name
}
