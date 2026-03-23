# 🎓 Workshop: Deploying a Scalable Web Server with EC2 (Development)

This is the **Development** version of the infrastructure, located on the `dev` branch.

## 🏗 Development Architecture

- **Compute**: AWS EC2 Instance (t3.micro).
- **Scaling**: Optimized for cost. Only **1 instance** is deployed in the development environment.
- **Environment Tag**: `Environment = dev` (automatically applied via the `dev` terraform workspace).

## 📁 Environment-Specific Files

- `variables.tf`: Contains the `instance_config` map with only 1 instance (`dev-server`).
- `main.tf`: Uses `for_each` and dynamic tagging based on `terraform.workspace`.

## 🚀 How to Deploy Dev

1. **Switch to Dev Branch**:
   ```bash
   git checkout dev
   ```
2. **Select/Create Dev Workspace**:
   ```bash
   terraform workspace select dev || terraform workspace new dev
   ```
3. **Apply**:
   ```bash
   terraform init
   terraform apply
   ```

## 💡 Key Lessons for Dev Environment

- **Cost Optimization**: Always scale down resources in non-production environments.
- **Isolation**: Use Terraform Workspaces (`dev`) to ensure that your development state doesn't interfere with production.
