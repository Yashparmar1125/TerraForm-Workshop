################################################################################
# EC2 INSTANCE AND SECURITY CONFIGURATION
################################################################################

# CONCEPT: Key Pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.project_name}-key-${terraform.workspace}"
  public_key = file("terraform_key.pub")
}

# CONCEPT: Security Group
resource "aws_security_group" "web_ssh" {
  name        = "${var.project_name}-sg-${terraform.workspace}"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from allowed IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg-${terraform.workspace}"
    Environment = terraform.workspace # Dynamic tag based on workspace
  }
}

# CONCEPT: Resource Scaling with for_each
# Instead of a single instance, we iterate over the 'instance_config' map.
# This creates one instance for each entry in the map.
resource "aws_instance" "web_server" {
  for_each = var.instance_config

  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = each.value.instance_type
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  user_data              = file("setup.sh")

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
    tags = {
      Name        = "${var.project_name}-${each.key}-root"
      Environment = terraform.workspace
    }
  }

  tags = {
    Name        = "${var.project_name}-${each.key}"
    Environment = terraform.workspace
  }
}
