data "aws_availability_zones" "azs" {

}

resource "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_nat_gateway" "nat-subnet-a" {
  subnet_id     = aws_subnet.public-subnet-a.id
  allocation_id = aws_eip.eip-a.id

  tags = {
    Name = "terraform-nat-subnet-a"
  }
}

resource "aws_nat_gateway" "nat-subnet-b" {
  subnet_id     = aws_subnet.public-subnet-b.id
  allocation_id = aws_eip.eip-b.id

  tags = {
    Name = "terraform-nat-subnet-b"
  }
}

resource "aws_eip" "eip-a" {

  vpc = true

  tags = {
    Name = "terraform-nat-a-ip"
  }
}

resource "aws_eip" "eip-b" {

  vpc = true

  tags = {
    Name = "terraform-nat-b-ip"
  }
}

resource "aws_route_table" "public-subnet-a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-subnet-a"
  }
}

resource "aws_route_table" "public-subnet-b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-subnet-b"
  }
}

resource "aws_route_table" "app-subnet-a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-subnet-a.id
  }

  tags = {
    Name = "terraform-app-subnet-a"
  }
}

resource "aws_route_table" "app-subnet-b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-subnet-b.id
  }

  tags = {
    Name = "terraform-app-subnet-b"
  }
}

resource "aws_route_table_association" "public-subnet-a" {
  route_table_id = aws_route_table.public-subnet-a.id
  subnet_id      = aws_subnet.public-subnet-a.id
}

resource "aws_route_table_association" "public-subnet-b" {
  route_table_id = aws_route_table.public-subnet-b.id
  subnet_id      = aws_subnet.public-subnet-b.id
}

resource "aws_route_table_association" "app-subnet-a" {
  route_table_id = aws_route_table.app-subnet-a.id
  subnet_id      = aws_subnet.app-subnet-a.id
}

resource "aws_route_table_association" "app-subnet-b" {
  route_table_id = aws_route_table.app-subnet-b.id
  subnet_id      = aws_subnet.app-subnet-b.id
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.31.16.0/20"
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "terraform-public-subnet-a"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.64.0/20"

  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "terraform-public-subnet-b"
  }
}

resource "aws_subnet" "app-subnet-a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.32.0/20"

  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "terraform-app-subnet-a"
  }
}

resource "aws_subnet" "app-subnet-b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.80.0/20"

  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "terraform-app-subnet-b"
  }
}

resource "aws_subnet" "data-subnet-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "terraform-data-subnet-a"
  }
}

resource "aws_subnet" "data-subnet-b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.31.96.0/20"
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "terraform-data-subnet-b"
  }
}

resource "aws_db_subnet_group" "subnet-group" {
  name       = "main"
  subnet_ids = [aws_subnet.data-subnet-a.id, aws_subnet.data-subnet-b.id]

  tags = {
    Name = "terraform-subnet-group"
  }
}
