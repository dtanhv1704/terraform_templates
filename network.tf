# VPC
resource "aws_vpc" "vpc" {
    cidr_block                       = var.vpc_cidr
    enable_dns_hostnames             = true
    enable_dns_support               = true
    instance_tenancy                 = "default"
    tags                             = merge(
      var.additional_tags,
      {
        Name  = "${var.project_name}-vpc"
      }
    ) 
}

# VPC Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id  = aws_vpc.vpc.id
    tags    = merge(
      var.additional_tags,
      {
      Name  = "${var.project_name}-gw"
    }
  )
}

# Public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-public-rt"
    }
  )
}

# Private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-private-rt"
    }
  )

  lifecycle {
    ignore_changes = [route]
  }
}

# Public subnet
resource "aws_subnet" "public-subnet" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidr,count.index)
<<<<<<< HEAD:network.tf
  # availability_zone = element(var.azs,count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
=======
  availability_zone = element(var.azs,count.index)
>>>>>>> 52b9370188405708ae8d99eacc27fda74743fcc0:template_network.tf

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-public-subnet-${count.index+1}"
    }
  )
}

# Private subnet
resource "aws_subnet" "private-subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidr,count.index)
<<<<<<< HEAD:network.tf
  # availability_zone = element(var.azs,count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
=======
  availability_zone = element(var.azs,count.index)
>>>>>>> 52b9370188405708ae8d99eacc27fda74743fcc0:template_network.tf

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-private-subnet-${count.index+1}"
    }
  )
}

# Associate route table to subnet
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public-subnet.*.id,count.index)
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private-subnet.*.id,count.index)
  route_table_id = aws_route_table.private-rt.id
}

# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "eip-nat-gw" {
  vpc = true

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-eip-nat-gw"
    }
  )
}

# NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip-nat-gw.id
  subnet_id     = element(aws_subnet.public-subnet.*.id, 0)

  tags = merge(
    var.additional_tags,
    {
      Name  = "${var.project_name}-nat-gw"
    }
  )
}
