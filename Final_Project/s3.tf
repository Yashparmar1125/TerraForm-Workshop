################################################################################
# APP DATA STORAGE - Environment Specific S3 Bucket
################################################################################

# CONCEPT: Dynamic Bucket Naming
# Every environment needs its own bucket. We use the workspace name in the bucket title.
resource "aws_s3_bucket" "app_data" {
  bucket = "yash-workshop-data-${local.current_env.env_suffix}-029733046209"

  tags = merge(local.common_tags, {
    Name = "App Data Storage - ${terraform.workspace}"
  })
}

# Ensure the bucket is private (Security Best Practice)
resource "aws_s3_bucket_public_access_block" "app_data_access" {
  bucket                  = aws_s3_bucket.app_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning for the app data
resource "aws_s3_bucket_versioning" "app_data_versioning" {
  bucket = aws_s3_bucket.app_data.id
  versioning_configuration {
    status = "Enabled"
  }
}
