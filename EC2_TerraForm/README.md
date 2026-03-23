# 🎓 Workshop: Deploying a Scalable Web Server with EC2

This directory contains the Terraform configuration for deploying a secured EC2 web server using industry-standard practices.

## 🏗 Architecture Overview

- **Compute**: AWS EC2 Instance (t3.micro) running Amazon Linux 2023.
- **Security**: Security Group acting as a virtual firewall allowing SSH (Port 22), HTTP (Port 80), and HTTPS (Port 443).
- **Automation**: `setup.sh` script to configure the web server automatically upon boot.
- **State Management**: Remote storage in S3 with DynamoDB locking (see `backend.tf`).

## 📁 File Structure & Concepts

Each file in this workshop serves a specific purpose following the "Separation of Concerns" principle:

- `main.tf`: Core logic (EC2, SG, Key Pairs).
- `variables.tf`: Input parameters to make the module reusable.
- `outputs.tf`: Values returned after the run (IP addresses, IDs).
- `data.tf`: Dynamic lookups for the latest AMIs and existing VPCs.
- `providers.tf`: Global AWS provider settings and default tagging.
- `versions.tf`: Version pinning for infrastructure reliability.
- `backend.tf`: Configuration for remote state storage.

## 🚀 How to Use

1. **Initialize**: Prepare the environment and download providers.
   ```bash
   terraform init
   ```
2. **Plan**: See what changes will be made before applying them.
   ```bash
   terraform plan
   ```
3. **Apply**: Deploy the infrastructure to AWS.
   ```bash
   terraform apply
   ```
4. **Access**: Once deployment is complete, use the `ec2_public_ip` output to visit your server in a browser.

## 💡 Key Lessons for Inudstry Alignment

- **Never Hardcode Secrets**: Use variables and SSH key files.
- **Use Dynamic Lookups**: Avoid hardcoding AMI IDs; use `data` sources instead.
- **Default Tagging**: Use the `default_tags` feature to keep your AWS account organized.
- **Remote State**: Store your `terraform.tfstate` in S3, not locally, for team collaboration.
- **Encryption**: Always encrypt your root EBS volumes.
