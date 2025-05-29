# AWS Infrastructure as Code with Terraform

## Overview
This project provisions a secure, auto-scaling, and production-ready AWS infrastructure using Terraform. It is designed to be modular, reusable, and easy to manage, following best practices similar to those used by DevOps teams at Amazon. The infrastructure supports scalable web applications, automated monitoring, and stress testing for performance validation.

## Architecture Diagram & Data Flow
![Architecture Diagram](https://github.com/user-attachments/assets/f3e0e337-2efc-47c4-b6f4-590e41336842)

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
   git clone https://github.com/clintonsenaye/aws-infra-terraform.git 
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

## Project Screenshots
> _Below are screenshots of the progress of the project:_

### VS Code Terminal Showing terraform apply success
![Terminal Terraform Apply](https://github.com/user-attachments/assets/2aa0cb41-ba6e-405d-95e1-54456e80276e)

### AWS Console - EC2 Dashboard 
![EC2 Insrance lunched](https://github.com/user-attachments/assets/cb1b5a10-fb77-40f4-a064-e4084e6b41ee)

### AWS Console - Security Groups 
![Seccurity Groups](https://github.com/user-attachments/assets/8183268c-375d-4937-9c28-2bdab5a3f4a0)

### AWS Console - VPC + Subnets
![VPC and Subnets](https://github.com/user-attachments/assets/fca86951-20cb-4e41-8b44-cb6f40151eb4)

### AWS Console -  S3 Bucket
![S3 Bucket](https://github.com/user-attachments/assets/85670510-0d8a-49c8-9ac9-453331011cfe)

### IAM Role + Policy
![IAM Role and Policy](https://github.com/user-attachments/assets/9bd6d246-1489-4864-a1ea-f6cda3c69577)

### SSH into EC2 
![SSH into EC2](https://github.com/user-attachments/assets/d0e84cc2-2274-447b-bde5-4853ce5adec8)

### Terraform Apply Terminal Output After Adding Load Balancer, ASG and Launch Template 
![ASG-LB-LT-TG](https://github.com/user-attachments/assets/6953075e-b453-4064-9294-3784458494ef)

### AWS Console - Auto-Scaling Group
![ASG](https://github.com/user-attachments/assets/72ef41fe-bd5c-44f6-ad90-146847100562)

### AWS Console - Launch Template 
![Launch Template](https://github.com/user-attachments/assets/65b0eda6-eea0-4abf-8277-06a2b154f644)

### AWS Console - Load Balancer
![Load Balancer](https://github.com/user-attachments/assets/6b801fdb-1636-406b-bb54-3099de6707e9)

### AWS Console - Load Balancer -> Target Group
![LB - TG](https://github.com/user-attachments/assets/fbe61680-0e80-4e31-af3b-1e5091d30d01)

### Load Balancer DNS (Web Test)
![Web Test](https://github.com/user-attachments/assets/6e1876b0-a8fe-46a6-9cf6-69ec63bf87af)

### AWS Console - Cloudwatch Alarm
![CloudWatch Screenshot](https://github.com/user-attachments/assets/59973156-ed97-4c7d-9947-9a7d4eb2ac96)

### AWS Console -  SNS Topic
![SNS](https://github.com/user-attachments/assets/6477747d-b1dd-49bc-8f4a-e634f6d20b25)

### SNS Subscription Confirmation Email
![SNS Email](https://github.com/user-attachments/assets/d8db2ea3-6387-48f1-957b-a4b0acdef640)

### Stress Test To Set Alarm OFF
![Stress Test](https://github.com/user-attachments/assets/a2147e79-c03c-40a6-9000-e5bee2dff79c)

### Alarm State Chnages To ALARM
![ALARM](https://github.com/user-attachments/assets/7302352c-6a29-4255-97f3-02bd7c408c1f)

### Email Alert (When Triggered)
![Email Alert](https://github.com/user-attachments/assets/4226dbdd-76dd-4924-8902-d5614f394f51)

### VS Code Terminal - Terraform Apply Success After Modularisation of Code 
![Modularisation](https://github.com/user-attachments/assets/b2bcd8d7-b353-43b5-8192-c681d6ccd084)


## Key Learnings & Takeaways
- **Modular Terraform**: Building reusable, maintainable infrastructure-as-code.
- **AWS Best Practices**: Multi-AZ, auto-scaling, least-privilege IAM, and monitoring.
- **Automated Bootstrapping**: Using user data to install and configure software on launch.
- **Stress Testing**: Integrating performance tools for validation.
- **Production-Readiness**: Clean separation of concerns, outputs, and variable management.

---
_This project is for scalable, secure, and observable AWS infrastructure, ready for real-world workloads and extensible for future needs._
