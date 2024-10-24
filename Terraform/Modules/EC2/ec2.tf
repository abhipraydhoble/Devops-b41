# EC2 Instance
resource "aws_instance" "server" {
  ami = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.az[0]
  key_name = var.key
  tags = merge(var.tags, { Name = "Public-Instance" })
}
