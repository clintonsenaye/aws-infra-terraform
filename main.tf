module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = "main-vpc"
  igw_name            = "main-igw"
  public_subnet_cidr  = var.public_subnet_cidr
  public_subnet_cidr2 = "10.0.3.0/24"
  public_subnet_az1   = "eu-west-2a"
  public_subnet_az2   = "eu-west-2b"
  public_subnet_name1 = "public-subnet-1"
  public_subnet_name2 = "public-subnet-2"
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_az   = "eu-west-2a"
  private_subnet_name = "private-subnet"
  route_table_name    = "public-route-table"
}

module "ec2" {
  source               = "./modules/ec2"
  sg_name              = "web-sg"
  sg_description       = "Allow HTTP and SSH traffic"
  vpc_id               = module.vpc.vpc_id
  s3_bucket_name       = "app-bucket"
  key_name             = "clinton-key"
  ami                  = "ami-0fc32db49bc3bfbb1"
  instance_type        = "t2.micro"
  public_subnet_id     = module.vpc.public_subnet_id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  instance_name        = "web-server"
}

module "alb" {
  source            = "./modules/alb"
  alb_name          = "clinton-alb"
  security_group_id = module.ec2.web_sg_id
  subnet_ids        = [module.vpc.public_subnet_id, module.vpc.public_subnet2_id]
  target_group_name = "clinton-target-group"
  vpc_id            = module.vpc.vpc_id
}

module "asg" {
  source                      = "./modules/asg"
  launch_template_name_prefix = "web-launch-"
  ami                         = "ami-0fc32db49bc3bfbb1"
  instance_type               = "t2.micro"
  key_name                    = module.ec2.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  security_group_id           = module.ec2.web_sg_id
  instance_name               = "web-instance"
  desired_capacity            = 2
  max_size                    = 3
  min_size                    = 1
  subnet_ids                  = [module.vpc.public_subnet_id, module.vpc.public_subnet2_id]
  target_group_arn            = module.alb.target_group_arn
  asg_name                    = "web-asg"
  user_data                   = file("${path.module}/user_data.sh")
}

module "monitoring" {
  source         = "./modules/monitoring"
  sns_topic_name = "cpu-alerts-topic"
  alert_email    = "clintonsenaye@gmail.com"
  alarm_name     = "HighCPUAlarm"
  asg_name       = module.asg.asg_name
}

# IAM resources (shared)
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "EC2S3AccessPolicy"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${module.ec2.s3_bucket_name}",
          "arn:aws:s3:::${module.ec2.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

