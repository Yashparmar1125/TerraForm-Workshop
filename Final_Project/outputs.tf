output "web_server_ips" {
  value = aws_instance.web[*].public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_data.id
}

output "current_workspace" {
  value = terraform.workspace
}
