# AWS Infrastructure as Code with Terraform

## Overview

This project provisions a secure, auto-scaling AWS infrastructure using Terraform.

## Architecture

- VPC with public & private subnets
- EC2 instance with secure security group
- S3 bucket with versioning
- IAM roles and policies
- Auto-scaling group and Launch Template

## Architecture Diagram: 

<img width="832" alt="Screenshot 2025-05-06 at 3 26 20 AM" src="https://github.com/user-attachments/assets/607c2250-c420-4c43-9b83-d7e0229037c9" />


## Tech Stack

- Terraform
- AWS (EC2, S3, VPC, IAM)
- GitHub

## Getting Started

1. Configure AWS CLI with credentials
2. Clone the repo
3. Run:
   '''bash
   terraform init
   terraform plan
   terraform apply
