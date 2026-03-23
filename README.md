# 🚀 Terraform Infrastructure-as-Code (IaC) Workshop (Dev Branch)

This is the **Development** branch of the workshop.

## 🎓 Branch Strategy

- **`main`**: Production environment (3 instances, high availability).
- **`dev`**: Development environment (1 instance, cost-optimized).

## 📁 Repository Structure

- [Remote_Backend](./Remote_Backend): Shared state infrastructure (S3/DynamoDB).
- [EC2_TerraForm](./EC2_TerraForm): Development EC2 configuration (scaled down).

## 🚀 Dev Workflow

1. Ensure you are on the `dev` branch.
2. Use the `dev` terraform workspace.
3. Use the `dev-server` instance for testing.

---
*Switch to the `main` branch for the Production configuration.*
