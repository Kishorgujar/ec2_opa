provider "aws" {
  region = var.region
}

# VPC Resource
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

# Subnet Resource
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "main_subnet"
  }
}

# Security Group Resource
resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "main_sg"
  }
}

# EC2 Instance Resource
resource "aws_instance" "main_instance" {
  ami                         = "ami-0dee22c13ea7a9a67" # Example AMI (update to match your requirements)
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main_subnet.id
  associate_public_ip_address  = true
  key_name                    = var.key_pair_name        # Key Pair name added here
  vpc_security_group_ids       = [aws_security_group.main_sg.id]  # Use SG ID instead of name

  tags = {
    Name        = "MainInstance"
    Environment = "DevOps"
  }

  # Ensure the security group is fully created before launching the instance
  depends_on = [
    aws_security_group.main_sg
  ]
}

# Outputs
output "instance_id" {
  value = aws_instance.main_instance.id
}

output "public_ip" {
  value = aws_instance.main_instance.public_ip
}
