# 🎓 Final Project: Unified Multi-Environment Web Server & Storage

This directory contains the final integrated project for the Terraform Workshop. It demonstrates how to use a single codebase to deploy infrastructure across multiple environments (`dev` and `prod`) using Terraform Workspaces.

## 🏗 Integrated Architecture

Each environment consists of:
- **Networking**: Integrated with the Default AWS VPC.
- **Compute**: Web Server(s) (EC2) with scaling defined per environment.
- **Storage**: A dedicated S3 bucket for application data, uniquely named per environment.
- **Security**: Environment-specific Security Groups and SSH keys.

## 🧠 The "One Code" Logic (`locals.tf`)

The magic happens in `locals.tf`, where we map the `terraform.workspace` to specific configurations:

```hcl
locals {
  env_config = {
    default = { # Production
      instance_count = 3
      env_suffix     = "prod"
    }
    dev = { # Development
      instance_count = 1
      env_suffix     = "dev"
    }
  }
}
```

## 🚀 Deployment Instructions

### 1. Development Environment
```bash
git checkout dev
cd Final_Project
terraform init
terraform workspace select dev || terraform workspace new dev
terraform plan
terraform apply
```

### 2. Production Environment
```bash
git checkout main
cd Final_Project
terraform init
terraform workspace select default
terraform plan
terraform apply
```

## 💡 Key Takeaways

1. **Workspace Isolation**: Your `dev` state and `prod` state are completely separate.
2. **DRY (Don't Repeat Yourself)**: One set of files manages all your resources.
3. **Dynamic Tagging**: Every resource is automatically tagged with its environment name.
4. **Cloud Storage Integration**: Each environment gets its own S3 bucket for data persistence.
