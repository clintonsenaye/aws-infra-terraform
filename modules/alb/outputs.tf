output "alb_arn" {
  value = aws_lb.web_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.web_target_group.arn
} 
