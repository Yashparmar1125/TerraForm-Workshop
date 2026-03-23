################################################################################
# EC2 INSTANCE AND SECURITY CONFIGURATION
################################################################################

# CONCEPT: Key Pair
# We need an SSH key to log into the EC2 instance. 
# Here, we upload our existing public key to AWS so it can be injected into the instance.
resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.project_name}-key"
  public_key = file("terraform_key.pub") # reading from a local file
}

# CONCEPT: Security Group
# A Security Group acts as a virtual firewall for your EC2 instance.
# It controls inbound (ingress) and outbound (egress) traffic.
resource "aws_security_group" "web_ssh" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = data.aws_vpc.default.id # Linking to the VPC found in data.tf

  # Inbound rule for SSH (Port 22)
  # Industry Best Practice: Restrict this to your specific IP address.
  ingress {
    description = "SSH from allowed IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Inbound rule for HTTP (Port 80)
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule for HTTPS (Port 443)
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  # By default, Security Groups block all inbound but allow all outbound.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# CONCEPT: EC2 Instance
# The main virtual machine resource.
resource "aws_instance" "web_server" {
  # Dynamic lookup of the AMI ID from data.tf
  ami             = data.aws_ami.amazon_linux_2023.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh_key.key_name
  
  # Using VPC Security Group IDs is preferred over security_groups (which is for EC2-Classic)
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  
  # user_data: A script that runs once during the first boot of the instance.
  user_data       = file("setup.sh")

  # Storage configuration
  root_block_device {
    volume_size = 8
    volume_type = "gp3" # General Purpose SSD (gp3 is newer and more cost-effective than gp2)
    encrypted   = true  # Industry standard: ALWAYS encrypt your storage
    tags = {
      Name = "${var.project_name}-root-volume"
    }
  }

  tags = {
    Name = "${var.project_name}-web-server"
  }
}
