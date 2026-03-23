################################################################################
# BACKEND CONFIGURATION - Remote State Management
################################################################################

# CONCEPT: Remote Backends
# By default, Terraform stores state locally in 'terraform.tfstate'. 
# In professional environments, we store this state in S3 for collaboration and durability.

terraform {
  backend "s3" {
    # Unique bucket name created in the 'Remote_Backend' workshop step
    bucket         = "terraform-state-bucket-s3-029733046209"
    
    # Path where the state file will be stored inside the bucket
    key            = "ec2/terraform.tfstate"
    
    region         = "ap-south-1"
    
    # AES256 encryption for the state file
    encrypt        = true
    
    # DynamoDB table for State Locking
    # This prevents two people from running 'terraform apply' at the same time and corrupting the state.
    dynamodb_table = "terraform-state-lock"
  }
}
