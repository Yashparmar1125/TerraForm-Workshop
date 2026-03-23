# 🚀 Terraform Infrastructure-as-Code (IaC) Workshop

Welcome to the Terraform Workshop! This repository is designed to teach you how to build production-ready AWS infrastructure using industry best practices.

## 🎓 What's Inside?

The workshop is divided into two logical sections:

### 1. [Remote Backend](./Remote_Backend)
**The Foundation**: Learn how to set up secure, collaborative state management using S3 and DynamoDB.
- S3 Versioning & Encryption.
- DynamoDB State Locking (preventing race conditions).
- Security Public Access Blocks.

### 2. [EC2 Infrastructure](./EC2_TerraForm)
**The Application**: Deploy a secured web server with automated provisioning.
- Dynamic AMI and VPC Lookups (no more hardcoding!).
- Security Groups (Virtual Firewalls).
- Key Pair management.
- User Data scripts for boot-time configuration.

## 🛠 Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed.
- [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials.
- An AWS account (Free Tier recommended).

## 🚀 Getting Started

Follow the workshop in this specific order:

1. **Bootstrap the Backend**: Navigate to `Remote_Backend` and run `terraform init` followed by `apply`. 
2. **Deploy the App**: Navigate to `EC2_TerraForm` and repeat the process. This module will automatically use the backend created in step 1.

---
*Created with ❤️ for future learning and industry alignment.*
