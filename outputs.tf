################################################################################
# VPC
################################################################################
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

################################################################################
# Internet Gateway
################################################################################
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

################################################################################
# NAT Gateway
################################################################################
output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways created"
  value       = aws_nat_gateway.this.*.id
}

################################################################################
# Availability Zones
################################################################################
output "availability_zones" {
  description = "List of Availability Zones where subnets were created"
  value       = module.region.availability_zone_names
}

################################################################################
# Public Subnets
################################################################################
output "public_subnet_ids" {
  description = "ID list of public subnets"
  value = {
    for subnet_key, cidr_list in var.public_subnets : subnet_key => [
      for key, value in local.public_subnet_map : aws_subnet.public_subnet[key].id if value.module == subnet_key
    ]
  }
}

output "public_subnet_cidrs" {
  description = "CIDR list of public subnets"
  value = {
    for subnet_key, cidr_list in var.public_subnets : subnet_key => [
      for key, value in local.public_subnet_map : value.cidr if value.module == subnet_key
    ]
  }
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value = {
    for subnet_key, cidr_list in var.public_subnets : subnet_key => [
      for key, value in local.public_subnet_map : aws_route_table.public_route[key].id if value.module == subnet_key
    ]
  }
}

################################################################################
# Private Subnets
################################################################################
output "private_subnet_ids" {
  description = "ID list of private subnets"
  value = {
    for subnet_key, cidr_list in var.private_subnets : subnet_key => [
      for key, value in local.private_subnet_map : aws_subnet.private_subnet[key].id if value.module == subnet_key
    ]
  }
}

output "private_subnet_cidrs" {
  description = "CIDR list of private subnets"
  value = {
    for subnet_key, cidr_list in var.private_subnets : subnet_key => [
      for key, value in local.private_subnet_map : value.cidr if value.module == subnet_key
    ]
  }
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value = {
    for subnet_key, cidr_list in var.private_subnets : subnet_key => [
      for key, value in local.private_subnet_map : aws_route_table.private_route[key].id if value.module == subnet_key
    ]
  }
}

