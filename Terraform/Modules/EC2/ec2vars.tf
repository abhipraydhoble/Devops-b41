
variable "az" {
  type = list(string)
  description = "Availability zones"
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
