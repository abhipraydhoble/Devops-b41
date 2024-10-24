variable "vpc_cidr_block" {
  type = string
  description = "Use this VPC CIDR block"
}

variable "subnet_cidr_block" {
  type = string
  description = "Subnet CIDR block for public subnet"
}

variable "public_ip" {
    type = bool
    description = "Assign Public ip"
}

variable "az" {
  type = list(string)
  description = "Availability zones"
}

variable "port_no" {
  type = list(number)
  description = "List of ports for security group"
}

variable "ami_id" {
  type = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type = string
  description = "Instance type for the EC2 instance"
}

variable "key" {
  type = string
  description = "Key pair for SSH access"
}

variable "tags" {
  type = map(string)
  description = "Tags to be applied to all resources"
}
