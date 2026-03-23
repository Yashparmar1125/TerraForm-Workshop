################################################################################
# VARIABLES - Infrastructure Configuration
################################################################################

variable "aws_region" {
  description = "AWS region for the state storage. Should usually be the same as your app resources."
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
  default     = "terraform-state-bucket-s3-029733046209"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking."
  type        = string
  default     = "terraform-state-lock"
}
