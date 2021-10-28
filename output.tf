output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_ids" {
  value = {
    for k, v in aws_subnet.public_subnets : k => v.id
  }
}

output "private_subnets_ids" {
  value = {
    for k, v in aws_subnet.private_subnets : k => v.id
  }
}

output "public_subnets_arns" {
  value = {
    for k, v in aws_subnet.public_subnets : k => v.arn
  }
}

output "private_subnets_arns" {
  value = {
    for k, v in aws_subnet.private_subnets : k => v.arn
  }
}
