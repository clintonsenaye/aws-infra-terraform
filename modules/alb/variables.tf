variable "alb_name" {}
variable "security_group_id" {}
variable "subnet_ids" { type = list(string) }
variable "target_group_name" {}
variable "vpc_id" {} 
