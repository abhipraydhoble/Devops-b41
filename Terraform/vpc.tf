resource "aws_vpc" "net" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "Virtual-Network"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.net.id
    cidr_block = "192.168.0.0/22"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet"
    }
  
}

resource "aws_subnet" "private" {
     vpc_id = aws_vpc.net.id
    cidr_block = "192.168.4.0/22"
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet"
    }
  
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.net.id
    tags = {
        Name = "vpc-internet-gateway"
    }
  
}


resource "aws_eip" "elastic" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "natgw" {
    subnet_id = aws_subnet.public.id
    allocation_id = aws_eip.elastic.id
    tags = {
        Name = "Nat-Gateway"
    }
  
}

resource "aws_route_table" "rt-pri" {
    vpc_id = aws_vpc.net.id 
    tags = {
        Name = "RT-Private"
    }

    route {
        nat_gateway_id = aws_nat_gateway.natgw.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "rtapi" {
    route_table_id = aws_route_table.rt-pri.id
    subnet_id = aws_subnet.private.id
  
}



resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.net.id
  tags = {
    Name = "RT-Public"
  }

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.rt-pub.id
  
}

resource "aws_security_group" "sg" {
    name = "firewall-vnet"
    vpc_id = aws_vpc.net.id

    ingress {
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}


resource "aws_instance" "server" {
    ami = "ami-04b6019d38ea93034"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    availability_zone = "ap-southeast-1a"
    vpc_security_group_ids = [aws_security_group.sg.id]
    key_name = "keypair-se1"
    tags = {
        Name = "Public-Instance"
    }
}

resource "aws_instance" "engine" {
    ami = "ami-04b6019d38ea93034"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private.id
    availability_zone = "ap-southeast-1b"
    key_name = "keypair-se1"
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "Private-Instance"
    }
}
