resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.zone
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = var.enable_ipv6

  ipv6_cidr_block = var.enable_ipv6 ? cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, coalesce(each.value.ipv6_cidr_index, 1)) : null

  tags = var.module_tags ? merge(local.module_tags, var.tags, { "Name" : each.value.name, "aws_vpc/subnet_id" : each.value.id, "aws_vpc/vpc_name" : aws_vpc.vpc.tags["Name"] }) : var.tags
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.zone
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = false

  tags = var.module_tags ? merge(local.module_tags, var.tags, { "Name" : each.value.name, "aws_vpc/subnet_id" : each.value.id, "aws_vpc/vpc_name" : aws_vpc.vpc.tags["Name"] }) : var.tags
}
