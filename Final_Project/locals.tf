################################################################################
# LOCALS - The Environment Configuration Brain
################################################################################

locals {
  # CONCEPT: Workspace-based Configuration Mapping
  # This map defines the differences between our environments.
  # 'default' is our production environment.
  env_config = {
    default = {
      instance_count = 3
      instance_type  = "t3.micro"
      env_suffix     = "prod"
    }
    dev = {
      instance_count = 1
      instance_type  = "t3.micro"
      env_suffix     = "dev"
    }
  }

  # Select the configuration based on the current terraform workspace
  # Fallback to 'dev' if the workspace is unknown (safety measure)
  current_env = lookup(local.env_config, terraform.workspace, local.env_config["dev"])

  # Common tags for all resources in this project
  common_tags = {
    Project     = "TerraformFinalProject"
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
  }
}
