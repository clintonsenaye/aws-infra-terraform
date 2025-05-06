# AWS Infrastructure as Code with Terraform

## Overview

This project provisions a secure, auto-scaling AWS infrastructure using Terraform.

## Architecture

- VPC with public & private subnets
- EC2 instance with secure security group
- S3 bucket with versioning
- IAM roles and policies
- Auto-scaling group and Launch Template

![Architecture Diagram](https://imagekit.io/tools/asset-public-link?detail=%7B%22name%22%3A%22Screenshot%202025-05-06%20at%203.26.20%E2%80%AFAM.png%22%2C%22type%22%3A%22image%2Fpng%22%2C%22signedurl_expire%22%3A%222028-05-05T02%3A31%3A26.949Z%22%2C%22signedUrl%22%3A%22https%3A%2F%2Fmedia-hosting.imagekit.io%2Fae0a69fd70e94b5f%2FScreenshot%25202025-05-06%2520at%25203.26.20%25E2%2580%25AFAM.png%3FExpires%3D1841106687%26Key-Pair-Id%3DK2ZIVPTIP2VGHC%26Signature%3D1uqL17N13xNjXcRcOa~plzGbPHOp9SHBpjJ6-9BaUet90czmH2kR4LsmdLeC4AygL2i16nOZuWyhhLsN-SqkkKO9s~muSqnxbfLSVugqmSqDnI5-2mrAClzJSpaAoqMdMYKndI0~RvFfWLh3ARDiEZESevRYS7RCTdM6cVHGtB3HlS7pCrvUdRabaO9XEgo94-cfXsFYUW-dJQkP5vISlwhsT3WbUqGdlsV0L-yAalVJld2O8gMJpLx5P9YRyVrCscxTNh59Dx3reqJ1Zvy~0O2MNB3ZjqXbEzumih7~Q0tWGb6IqlI8I5K99MxFQzXtRMoTstBndo4FA1UgtRg3gg__%22%7D)

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
