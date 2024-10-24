module "vpc" {
    source = "./VPC"
    vpc_cidr_block = var.vpc_cidr_block
    subnet_cidr_block = var.subnet_cidr_block
    az = var.az
    public_ip = var.public_ip
    port_no = var.port_no
    tags = var.tags

 
}




module "ec2" {
    source = "./EC2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    az = var.az
    key = var.key
    tags = var.tags

}
