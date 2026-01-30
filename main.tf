#step 1) - create a vpc

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyTerraformvpc"
  }

}

#step 2) - create a public subnet

resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
}

#step 3) - create a private subnet

resource "aws_subnet" "PrivateSubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
}

#step 4) -  create internet gatway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

#step 5)- create routetable for publicsubnet

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

#step 6)- routetable asociation public subnet

resource "aws_route_table_association" "publicRTassociation" {
  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.publicRT.id
}


