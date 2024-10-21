resource "aws_vpc" "network" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "vpc-41"
    }
  
}


resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.network.id
    cidr_block = "192.168.0.0/21"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public-Subnet"
    }
  
}

resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.network.id 
    cidr_block = "192.168.8.0/21"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet"
    }
}


resource "aws_internet_gateway" "int" {
    vpc_id = aws_vpc.network.id
    tags = {
        Name = "igw-41"
    }

}

resource "aws_route_table" "rt-pub" {
 vpc_id = aws_vpc.network.id

 route {
    gateway_id = aws_internet_gateway.int.id
    cidr_block = "0.0.0.0/0"
 }

}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.rt-pub.id
  
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.network.id
    name = "b41-firewall"


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


resource "aws_instance" "web" {
    ami = "ami-06b21ccaeff8cd686"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.sub1.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    key_name = "b39"
    tags = {
        Name = "VM-b41"
    }

  
}

