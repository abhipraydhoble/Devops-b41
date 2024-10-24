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



variable "tags" {
  type = map(string)
  description = "Tags to be applied to all resources"
}
