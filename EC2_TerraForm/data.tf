################################################################################
# DATA SOURCES - Fetching External Information
################################################################################

# CONCEPT: Data Sources
# Data sources allow Terraform to use information defined outside of Terraform, 
# or by other separate Terraform configurations.

# Fetching the Default VPC in the region
data "aws_vpc" "default" {
  default = true
}

# Fetching Subnets belonging to the Default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# CONCEPT: Dynamic AMI Selection
# Instead of hardcoding an AMI ID (which changes frequently), we search for the latest one.
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  # Searching for Amazon Linux 2023 64-bit AMI
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
