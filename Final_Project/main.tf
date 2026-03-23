################################################################################
# WEB SERVER INFRASTRUCTURE
################################################################################

# Key pair for the environment
resource "aws_key_pair" "ssh_key" {
  key_name   = "final-project-key-${terraform.workspace}"
  public_key = file("../EC2_TerraForm/terraform_key.pub") # reusing the existing pub key path
}

# Security group
resource "aws_security_group" "web_sg" {
  name        = "final-project-sg-${terraform.workspace}"
  description = "Allow inbound web and ssh traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In a real project, restrict this!
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

# EC2 Instance(s) using count based on locals
resource "aws_instance" "web" {
  count = local.current_env.instance_count

  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = local.current_env.instance_type
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = file("../EC2_TerraForm/setup.sh") # reusing setup script

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = merge(local.common_tags, {
    Name = "Web-Server-${terraform.workspace}-${count.index + 1}"
  })
}
