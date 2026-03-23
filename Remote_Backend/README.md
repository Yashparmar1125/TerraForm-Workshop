# 🎓 Workshop: Building the Foundation - Remote State Storage

This directory contains the initial "Bootstrap" configuration. It sets up the AWS infrastructure needed to store your Terraform state files securely.

## 🏗 Why do we need this?

In a professional environment, you never store the `terraform.tfstate` file on your laptop. Why?
1. **Teammates**: If it's on your machine, your team can't collaborate.
2. **Durability**: If your laptop dies, your infrastructure state is lost.
3. **Locking**: If two people run `terraform apply` at once, everything breaks.

## 🔒 Security & Safety Features

I've implemented several "Industry Standard" guards here:
- **S3 Versioning**: Keeps a history of every change to your state.
- **S3 Encryption**: Automatically encrypts your state at rest using AES256.
- **S3 Public Access Block**: Ensures that your state file (which may contain passwords) is nunca exposed to the internet.
- **DynamoDB Locking**: Terraform uses this table as a "semaphore" to ensure only one person is editing the infrastructure at a time.
- **Lifecycle Guard**: Added `prevent_destroy = true` so you don't accidentally delete your entire state history.

## 🚀 Deployment Sequence

1. **Step 1: Bootstrap the Backend**
   Go into this directory and run:
   ```bash
   terraform init
   terraform apply
   ```
   *Note: This particular configuration stores its OWN state locally until the bucket is created.*

2. **Step 2: Connect the Application**
   Once these resources exist, other modules (like `EC2_TerraForm`) can use the S3 bucket to store their state.

## 📁 File Structure

- `main.tf`: Creates the S3 bucket and DynamoDB table.
- `variables.tf`: Configuration parameters for names and regions.
- `providers.tf`: AWS connection settings.
- `versions.tf`: Pins Terraform version for stability.
