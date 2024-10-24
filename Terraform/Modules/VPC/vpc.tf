
# VPC resource
resource "aws_vpc" "net" {
  cidr_block = var.vpc_cidr_block
  tags = var.tags
}

# Subnet resource
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.net.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.az[0]
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "Public-Subnet" })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.net.id
  tags = merge(var.tags, { Name = "vpc-internet-gateway" })
}

# Route Table
resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.net.id
  tags = merge(var.tags, { Name = "RT-Public" })

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.rt-pub.id
}

# Security Group
resource "aws_security_group" "sg" {
  name = "firewall-vnet"
  vpc_id = aws_vpc.net.id

  ingress {
    from_port = var.port_no[1]
    to_port = var.port_no[1]
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = var.port_no[0]
    to_port = var.port_no[0]
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "Security-Group" })
}


