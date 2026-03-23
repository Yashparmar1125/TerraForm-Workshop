################################################################################
# OUTPUTS - Exporting Resource Information
################################################################################

# CONCEPT: Outputs
# Use outputs to retrieve information about the resources you've created. 
# This is useful for connecting other parts of your infrastructure.

output "instance_id" {
  description = "The unique ID assigned by AWS to the EC2 instance."
  value       = aws_instance.web_server.id
}

output "ec2_public_ip" {
  description = "The public IP address to access the web server over the internet."
  value       = aws_instance.web_server.public_ip
}

output "ec2_public_dns" {
  description = "The auto-generated AWS DNS name for the public IP."
  value       = aws_instance.web_server.public_dns
}