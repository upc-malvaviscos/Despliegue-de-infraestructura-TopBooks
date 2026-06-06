locals {
  tags_obligatorios = {
    Project     = "topbooks"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Group       = "malvaviscos"
  }
}

resource "aws_vpc" "main_vpc_topbooks_malvaviscos" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-vpc"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc_topbooks_malvaviscos.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-public-subnet-1a"
  })
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc_topbooks_malvaviscos.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-private-subnet-1b"
  })
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc_topbooks_malvaviscos.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-private-subnet-1c"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc_topbooks_malvaviscos.id

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-igw"
  })
}

resource "aws_route_table" "public_rt_topboks" {
  vpc_id = aws_vpc.main_vpc_topbooks_malvaviscos.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-public-rt"
  })
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt_topboks.id
}

resource "aws_vpc_endpoint" "s3_endpoint_topbooks" {
  vpc_id            = aws_vpc.main_vpc_topbooks_malvaviscos.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-s3-endpoint"
  })
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_assoc" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint_topbooks.id
  route_table_id  = aws_route_table.public_rt_topboks.id
}

