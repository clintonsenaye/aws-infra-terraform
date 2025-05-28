resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
    Name = "main-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
    Name = "main-igw"
    }
}

resource "aws_subnet" "public" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.public_subnet_cidr
    availability_zone = "eu-west-2a"
    tags = {
    Name = "public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_cidr
    availability_zone = "eu-west-2a"
    tags = {
    Name = "private-subnet"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
    Name = "public-route-table"
    }
}

resource "aws_route_table_association" "public_assoc" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "web_server" {
    ami                         = "ami-0fc32db49bc3bfbb1"
    instance_type               = "t2.micro"
    subnet_id                   = aws_subnet.public.id
    vpc_security_group_ids      = [aws_security_group.web_sg.id]
    associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
    key_name = aws_key_pair.generated_key.key_name


    tags = {
    Name = "web-server"
    }
}

resource "aws_security_group" "web_sg" {
    name        = "web-sg"
    description = "Allow HTTP and SSH traffic"
    vpc_id      = aws_vpc.main.id
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
    Name = "web-sg"
    }
}

resource "aws_s3_bucket" "app_bucket" {
    bucket = "clinton-app-bucket-${random_id.bucket_suffix.hex}"
    tags = {
    Name = "app-bucket"
    }
}

resource "random_id" "bucket_suffix" {
    byte_length = 4
}

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
        Effect   = "Allow"
        Resource = [
            aws_s3_bucket.app_bucket.arn,
            "${aws_s3_bucket.app_bucket.arn}/*"
        ]
        }
    ]
    })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "ec2_instance_profile"
    role = aws_iam_role.ec2_role.name
}

resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
    key_name   = "clinton-key"
    public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
    content  = tls_private_key.ssh_key.private_key_pem
    filename = "${path.module}/clinton-key.pem"
    file_permission = "0400"
}
