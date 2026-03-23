################################################################################
# VARIABLES - Input Parameters
################################################################################

# CONCEPT: Input Variables
# Variables allow you to customize your configuration without editing the main code.

variable "aws_region" {
  description = "The AWS region where resources will be created. Mumbai (ap-south-1) is used by default."
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The size of the virtual machine. t3.micro is usually eligible for Free Tier."
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your public IP address. Used to restrict SSH access to ONLY your machine."
  type        = string
  default     = "0.0.0.0/0" # WARNING: This allows SSH from anywhere. Update with your real IP for security.
}

variable "project_name" {
  description = "A prefix for naming resources, making them easy to identify in the AWS Console."
  type        = string
  default     = "TerraformStandardization"
}
