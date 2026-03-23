################################################################################
# PROVIDERS - Remote Backend Setup
################################################################################

provider "aws" {
  region = var.aws_region

  # Default tags apply to the bucket and the DynamoDB table
  default_tags {
    tags = {
      Project   = "TerraformWorkshop"
      Component = "RemoteState"
      ManagedBy = "Terraform"
    }
  }
}
