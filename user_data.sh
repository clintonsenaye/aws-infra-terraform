#!/bin/bash
# Install nginx
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx

# Install stress (for stress testing)
sudo yum install -y epel-release
sudo yum install -y stress

# install stress-ng (for more advanced stress testing)
sudo yum install -y stress-ng || true

# Simple index page
echo "<h1>Welcome to Nginx on $(hostname)</h1>" | sudo tee /usr/share/nginx/html/index.html 