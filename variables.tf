variable "region" {
  description = "The AWS region to deploy the instance"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to use for the instance"
  type        = string
  default     = "BomBay_Linux"  # Replace with your actual key pair name
}

