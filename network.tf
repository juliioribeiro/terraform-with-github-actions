resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-terraform"
  }
}
# https://www.terraform.io/language/meta-arguments/count
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"

  count = 3

  tags = {
    "Name" = "subnet-terraform-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "internet-gateway-terraform"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "route-table-terraform"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.0.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "security_group" {
  name   = "security-group-terraform"
  vpc_id = aws_vpc.vpc.id


  dynamic "ingress" {
    for_each = var.portas
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}