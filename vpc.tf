provider "aws" {
  reigon = ""
  access_key = 
  secret_access_key = 
}

resource "aws_vpc" "myvpc" {
  CIDR_BLOCK = 10.0.0.0/16
}

resource "aws_internet_gateway" "my_igw" {
vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id
  aws_gateway = aws_internet_gateway.my_igw.id
}

resource "aws_routetable_association" "public_route" {
  route_table.id = aws_route_table.myroute.id
  route = {
    CIDR_BLOCK = 0.0.0.0/0
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id = aws_vpc.myvpc.id
  count = 2
  CIDR_BLOCK = {aws_vpc.myvpc.CIDR_BLOCK, 8 , count.index}
  map_public_ip_on_launch = true
}

resource "aws_subnet" "publicsubnet" {
  vpc_id = aws_vpc.myvpc.id
  CIDR_BLOCK = {aws_vpc.myvpc.CIDR_BLOCK, 8}
  map_public_ip_on_launch = true
  tag = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id = aws_vpc.myvpc.id
  CIDR_BLOCK = {aws_vpc.myvpc.CIDR_BLOCK, 8}
  tag = {
    Name = "PrivateSubnet"
  }
}
