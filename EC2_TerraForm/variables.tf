################################################################################
# VARIABLES - Input Parameters
################################################################################

variable "aws_region" {
  description = "The AWS region where resources will be created. Mumbai (ap-south-1) is used by default."
  type        = string
  default     = "ap-south-1"
}

# CONCEPT: Map Variable for for_each
# This map defines our production instances. 
# We can easily add or remove instances by modifying this map.
variable "instance_config" {
  description = "Map of instance names to their specific configurations"
  type        = map(any)
  default = {
    "web-server-1" = { instance_type = "t3.micro" }
    "web-server-2" = { instance_type = "t3.micro" }
    "web-server-3" = { instance_type = "t3.micro" }
  }
}

variable "my_ip" {
  description = "Your public IP address. Used to restrict SSH access to ONLY your machine."
  type        = string
  default     = "0.0.0.0/0"
}

variable "project_name" {
  description = "A prefix for naming resources, making them easy to identify in the AWS Console."
  type        = string
  default     = "TerraformStandardization"
}
