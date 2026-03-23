# 🚀 Terraform Infrastructure-as-Code (IaC) Workshop (Production Branch)

This is the **Production** branch of the workshop.

## 🎓 Branch Strategy

- **`main`**: Production environment (3 instances, high availability).
- **`dev`**: Development environment (1 instance, cost-optimized).

## 📁 Repository Structure

- [Remote_Backend](./Remote_Backend): Shared state infrastructure (S3/DynamoDB).
- [EC2_TerraForm](./EC2_TerraForm): Production EC2 configuration (scale: 3 instances).

## 🚀 Production Workflow

1. Ensure you are on the `main` branch.
2. Use the `default` terraform workspace.
3. Use the 3 web servers for handling live traffic.

---
*Switch to the `dev` branch for the Development configuration.*
