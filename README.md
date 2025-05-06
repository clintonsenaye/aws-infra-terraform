# AWS Infrastructure as Code with Terraform

## Overview

This project provisions a secure, auto-scaling AWS infrastructure using Terraform.

## Architecture

- VPC with public & private subnets
- EC2 instance with secure security group
- S3 bucket with versioning
- IAM roles and policies
- Auto-scaling group and Launch Template

![Architecture Diagram](https://github.com/user-attachments/assets/8eaf2dfb-79d8-4236-b8e0-605100b0f7c3)

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
