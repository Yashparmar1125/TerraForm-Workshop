variable "env" {
  description = "The environment for which to create resources"
  type        = string
  default     = terraform.workspace
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
  default     = "infra_bucket_029733046209"
}
