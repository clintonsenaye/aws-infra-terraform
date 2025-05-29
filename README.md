# AWS Infrastructure as Code with Terraform

## Overview
This project provisions a secure, auto-scaling, and production-ready AWS infrastructure using Terraform. It is designed to be modular, reusable, and easy to manage, following best practices similar to those used by DevOps teams at Amazon. The infrastructure supports scalable web applications, automated monitoring, and stress testing for performance validation.

## Architecture Diagram & Data Flow
![Architecture Diagram](https://github.com/user-attachments/assets/8eaf2dfb-79d8-4236-b8e0-605100b0f7c3)

**Data Flow Explanation:**
- Users access the application via the Application Load Balancer (ALB).
- The ALB distributes traffic across EC2 instances in multiple Availability Zones (AZs) for high availability.
- EC2 instances are managed by an Auto Scaling Group (ASG) and are provisioned with Nginx and stress testing tools via user data.
- All resources are deployed within a custom VPC with public and private subnets.
- S3 is used for storage, and IAM roles/policies ensure secure access.
- CloudWatch and SNS provide monitoring and alerting for key metrics (e.g., CPU utilization).

## Technologies Used
- **Terraform** (modular, production-grade)
- **AWS**: VPC, EC2, S3, IAM, ALB, ASG, CloudWatch, SNS
- **Nginx** (web server)
- **stress / stress-ng** (performance testing tools)
- **Amazon Linux 2** (AMI)

## Module Overview
- `modules/vpc`: VPC, subnets, route tables, and internet gateway
- `modules/ec2`: Security group, S3 bucket, key pair, and standalone EC2 instance
- `modules/alb`: Application Load Balancer, target group, and listener
- `modules/asg`: Launch template and Auto Scaling Group (with user data for Nginx and stress tools)
- `modules/monitoring`: CloudWatch alarms and SNS notifications

## How to Deploy
1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd aws-infra-terraform
   ```
2. **Configure AWS credentials:**
   ```bash
   aws configure
   # Or export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
   ```
3. **Initialize Terraform:**
   ```bash
   terraform init
   ```
4. **Review and customize variables (optional):**
   - Edit `variables.tf` for CIDR blocks, region, etc.
   - Edit `user_data.sh` to customize server bootstrapping.
5. **Plan the deployment:**
   ```bash
   terraform plan
   ```
6. **Apply the deployment:**
   ```bash
   terraform apply
   ```
7. **Access your application:**
   - Find the ALB DNS name in Terraform outputs or AWS Console.
   - Visit the DNS in your browser to see the Nginx welcome page.

## Screenshots
> _Add screenshots of your AWS Console, ALB, EC2 instances, monitoring dashboards, etc. Use the template below:_

**Example:**
```
### EC2 Instances
![EC2 Instances Screenshot](path/to/ec2-screenshot.png)

### Load Balancer
![ALB Screenshot](path/to/alb-screenshot.png)

### CloudWatch Alarms
![CloudWatch Screenshot](path/to/cloudwatch-screenshot.png)
```

## Key Learnings & Takeaways
- **Modular Terraform**: Building reusable, maintainable infrastructure-as-code.
- **AWS Best Practices**: Multi-AZ, auto-scaling, least-privilege IAM, and monitoring.
- **Automated Bootstrapping**: Using user data to install and configure software on launch.
- **Stress Testing**: Integrating performance tools for validation.
- **Production-Readiness**: Clean separation of concerns, outputs, and variable management.

---
_This project is a template for scalable, secure, and observable AWS infrastructure, ready for real-world workloads and extensible for future needs._
