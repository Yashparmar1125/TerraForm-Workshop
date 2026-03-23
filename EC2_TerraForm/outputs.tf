################################################################################
# OUTPUTS - Exporting Resource Information
################################################################################

# CONCEPT: Output with for_each
# Since we now have multiple instances, we use a loop to return information for all of them.

output "instance_details" {
  description = "Map of instance names to their details"
  value = {
    for name, instance in aws_instance.web_server : name => {
      id        = instance.id
      public_ip = instance.public_ip
      dns       = instance.public_dns
    }
  }
}