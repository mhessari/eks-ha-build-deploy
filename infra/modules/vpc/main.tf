resource "aws_vpc" "main" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-ha-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.AVAILABILITY_ZONES)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.VPC_CIDR, 4, count.index)
  availability_zone = var.AVAILABILITY_ZONES[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  count = length(var.AVAILABILITY_ZONES)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.VPC_CIDR, 4, count.index + length(var.AVAILABILITY_ZONES))
  availability_zone = var.AVAILABILITY_ZONES[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "eks-ha-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = {
    Name = "eks-ha-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "eks-ha-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.AVAILABILITY_ZONES)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.AVAILABILITY_ZONES)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}