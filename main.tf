####################################################################
# VPC
####################################################################
resource "aws_vpc" "vpc" {
  #checkov:skip=CKV2_AWS_11:"Ensure VPC flow logging is enabled in all VPCs"
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name = "${var.environment}-vpc"
    },
    var.tags,
    var.vpc_tags
  )
}

####################################################################
# Internet Gateway
####################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    {
      Name = "${var.environment}-igw"
    },
    var.tags,
    var.igw_tags
  )
}

####################################################################
# EIP For Nat Gateway
####################################################################
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw] # Wait for IGW creation
  tags = merge(
    {
      Name = "${var.environment}-eip"
    },
    var.tags
  )
}

####################################################################
# NAT Gateway
####################################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id # Bind EIP
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)

  tags = merge(
    {
      Name = "${var.environment}-ngw"
    },
    var.tags,
    var.nat_tags
  )
}
####################################################################
# Public subnet(s)
####################################################################
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
    },
    var.tags,
    var.pubsubs_tags
  )
}

####################################################################
# Private subnet(s)
####################################################################
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnets_cidr)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      Name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
    },
    var.tags,
    var.privsubs_tags
  )
}

####################################################################
# Routing Table For Private Subnets
####################################################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = "${var.environment}-private-route-table"
    },
    var.tags,
    var.privrt_tags
  )
}

####################################################################
# Routing Table For Public Subnets
####################################################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = "${var.environment}-public-route-table"
    },
    var.tags,
    var.pubrt_tags
  )
}

####################################################################
# Route For Internet Gateway
####################################################################
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

####################################################################
# Route For NAT Gateway
####################################################################
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

####################################################################
# Route Table Associations
####################################################################
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

####################################################################
# Default Security Group For VPC
####################################################################
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

  tags = {
    Name = "${var.environment}-default_SG"
  }
}
