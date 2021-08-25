resource "aws_subnet" "public" {
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "Training Public Subnet (${var.environment_name})"
  }
}

resource "aws_subnet" "private_a" {
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "Training Private Subnet A (${var.environment_name})"
  }
}

resource "aws_subnet" "private_b" {
  availability_zone       = "${var.region}b"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "Training Private Subnet B (${var.environment_name})"
  }
}
