resource "aws_s3_bucket" "infra_bucket" {
    bucket = "${var.bucket_name}-${var.env}"
    
    tags = {
        Name        = "Terraform State Bucket"
        Environment = var.env
    }
  
}