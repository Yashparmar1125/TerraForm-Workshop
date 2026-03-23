# 🎓 Workshop: Deploying a Scalable Web Server with EC2 (Production)

This is the **Production** version of the infrastructure, located on the `main` branch.

## 🏗 Production Architecture

- **Compute**: AWS EC2 Instances (t3.micro).
- **Scaling**: High Availability. **3 instances** are deployed in the production environment using `for_each`.
- **Environment Tag**: `Environment = default` (automatically applied via the `default` terraform workspace).

## 📁 Environment-Specific Files

- `variables.tf`: Contains the `instance_config` map with 3 instances (`web-server-1`, `web-server-2`, `web-server-3`).
- `main.tf`: Uses `for_each` and dynamic tagging based on `terraform.workspace`.

## 🚀 How to Deploy Production

1. **Switch to Main Branch**:
   ```bash
   git checkout main
   ```
2. **Select Default Workspace**:
   ```bash
   terraform workspace select default
   ```
3. **Apply**:
   ```bash
   terraform init
   terraform apply
   ```

## 💡 Key Lessons for Production Environment

- **High Availability**: Always deploy multiple instances across various availability zones for better uptime.
- **Dynamic Scaling**: Use maps and `for_each` to manage multiple instances efficiently without repeating code.
- **Organization**: Ensure production state is kept in the `default` workspace to separate it from experimental environments.
