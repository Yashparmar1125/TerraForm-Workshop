################################################################################
# PROVIDERS - AWS Configuration
################################################################################

# CONCEPT: Providers
# Providers are plugins that Terraform uses to communicate with various cloud platforms or APIs.

provider "aws" {
  # Looking up the region from our variables.tf file
  region = var.aws_region

  # CONCEPT: Default Tags
  # Industry Best Practice: Use default_tags in the provider block. 
  # This automatically applies these tags to EVERY resource created in this module.
  default_tags {
    tags = {
      Project   = "TerraformWorkshop"
      ManagedBy = "Terraform"
      Owner     = "Yash"
      Environment = "Development"
    }
  }
}
