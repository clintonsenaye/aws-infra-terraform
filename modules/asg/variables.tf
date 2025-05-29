variable "launch_template_name_prefix" {}
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "iam_instance_profile" {}
variable "security_group_id" {}
variable "instance_name" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "subnet_ids" { type = list(string) }
variable "target_group_arn" {}
variable "asg_name" {}
variable "user_data" {
  description = "User data script to run on launch"
  type        = string
  default     = ""
}
