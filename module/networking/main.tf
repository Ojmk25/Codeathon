resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
    Name = "ojmkvpc" 
 }
}

resource "aws_internet_gateway" "my_vpc" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
    Name = "ojmkigw" 
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone  = var.availability_zone

    tags = {
    Name = "ojmkpubsub" 
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
    Name = "ojmkpubrt" 
    }
}

resource "aws_route" "public_internet_access" {
    route_table_id  = aws_route_table.public.id
    destination_cidr_block = var.destination_cidr_block
    gateway_id = aws_internet_gateway.my_vpc.id
}

resource "aws_route_table_association" "public_subnet" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = false
    availability_zone  = var.availability_zone


    tags = {
    Name = "ojmkprivsub" 
    }
}

resource "aws_eip" "my_natgw" {
    domain= "vpc"
}

resource "aws_nat_gateway" "my_natgw" {
    allocation_id = aws_eip.my_natgw.id
    subnet_id = aws_subnet.public.id

    tags = {
    Name = "ojmknatgw" 
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
    Name = "ojmkprivrt" 
    }
}

resource "aws_route" "private_nat_access" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.my_natgw.id
}

resource "aws_route_table_association" "private_subnet" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
}


