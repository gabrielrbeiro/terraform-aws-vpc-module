resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.module_tags ? merge(local.module_tags, var.tags, { "Name" : "${var.name} Internet Gateway", "aws_vpc/vpc_name" : aws_vpc.vpc.tags["Name"] }) : var.tags
}

resource "aws_egress_only_internet_gateway" "ipv6_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.module_tags ? merge(local.module_tags, var.tags, { "Name" : "${var.name} IPv6 Internet Gateway", "aws_vpc/vpc_name" : aws_vpc.vpc.tags["Name"] }) : var.tags
}

resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.ipv6_gateway.id
  }

  depends_on = [
    aws_internet_gateway.gateway
  ]

  tags = var.module_tags ? merge(local.module_tags, var.tags, { "Name" : "${var.name} Route Table", "aws_vpc/vpc_name" : aws_vpc.vpc.tags["Name"] }) : var.tags
}

resource "aws_route_table_association" "public_association" {
  for_each       = { for k, v in aws_subnet.public_subnets : k => v.id }
  subnet_id      = each.value
  route_table_id = aws_default_route_table.route_table.id
}
