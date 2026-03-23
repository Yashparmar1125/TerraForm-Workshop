################################################################################
# VERSIONS - Terraform & Provider Constraints
################################################################################

# CONCEPT: Version Constraints
# Always specify the minimum Terraform version and provider versions to ensure consistency.

terraform {
  # Minimum version of Terraform required to run this code (Standard is >= 1.0.0)
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
      # CONCEPT: Semantic Versioning (~>)
      # ~> 5.0 means "any version 5.x", but not 6.0. 
      # This allows bug fixes and minor features while preventing breaking changes.
      version = "~> 5.0"
    }
  }
}
