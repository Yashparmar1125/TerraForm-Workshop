################################################################################
# REMOTE STATE INFRASTRUCTURE - AWS S3 & DynamoDB
################################################################################

# CONCEPT: Terraform State Storage
# The 'state' file is the source of truth for your infrastructure. 
# We store it in S3 so that it's accessible to multiple team members.

resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name

  # CONCEPT: prevent_destroy
  # Industry Best Practice: Use lifecycle guards to prevent accidental deletion 
  # of critical resources like your state bucket.
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

# CONCEPT: State Versioning
# Enabling versioning allows you to roll back to a previous state file 
# if the current one becomes corrupted or accidentally changed.
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# CONCEPT: Encryption at Rest
# State files can contain sensitive information (like passwords or private keys). 
# We MUST encrypt them before they hit the disk in S3.
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# CONCEPT: Public Access Block
# Security Best Practice: Explicitly block all public access to the bucket.
resource "aws_s3_bucket_public_access_block" "state_bucket_public_access" {
  bucket                  = aws_s3_bucket.state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CONCEPT: State Locking with DynamoDB
# When using a remote state, two people might try to 'apply' at the same time.
# Terraform uses a DynamoDB table to "lock" the state during an operation.
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" # Terraform expects this exact attribute name

  attribute {
    name = "LockID"
    type = "S" # String type
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
