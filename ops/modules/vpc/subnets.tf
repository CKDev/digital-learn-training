resource "aws_subnet" "public" {
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id
}