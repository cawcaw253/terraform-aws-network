locals {
  public_subnet_map = merge([
    for key, cidr_list in var.public_subnets : {
      for cidr in cidr_list : "${key}-${index(cidr_list, cidr)}" => {
        index  = index(cidr_list, cidr)
        module = key
        cidr   = cidr
      }
    }
  ]...)
  private_subnet_map = merge([
    for key, cidr_list in var.private_subnets : {
      for cidr in cidr_list : "${key}-${index(cidr_list, cidr)}" => {
        index  = index(cidr_list, cidr)
        module = key
        cidr   = cidr
      }
    }
  ]...)
  nat_deploy_subnet = var.nat_deploy_module != null ? {
    for key, value in local.public_subnet_map : key => value
    if contains(values(value), var.nat_deploy_module)
  } : local.public_subnet_map

  public_subnet_abbreviation  = "pub"
  private_subnet_abbreviation = "pri"
  nat_gateway_abbreviation    = "nat"
}

################################################################################
# VPC
################################################################################
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true      # Indicates whether the DNS resolution is supported
  enable_dns_hostnames = true      # Indicates whether instances with public IP addresses get corresponding public DNS hostnames.
  instance_tenancy     = "default" # The VPC runs on shared hardware by default,

  tags = merge(var.default_tags, {
    "Name" = module.namer.virtual_private_cloud
  })
}

################################################################################
# IGW
################################################################################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.default_tags, {
    "Name" = module.namer.internet_gateway
  })
}

################################################################################
# EIP
################################################################################
resource "aws_eip" "nat" {
  count = var.without_nat ? 0 : (var.create_nat_per_az ? length(var.availability_zones) : 1)

  tags = merge(var.default_tags, {
    "Name" = format(module.namer.elastic_ip, element(var.availability_zones, count.index), local.nat_gateway_abbreviation)
  })
}

################################################################################
# NAT Gateways
################################################################################
resource "aws_nat_gateway" "this" {
  count = var.without_nat ? 0 : (var.create_nat_per_az ? length(var.availability_zones) : 1)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[keys(local.nat_deploy_subnet)[count.index]].id

  tags = merge(var.default_tags, {
    "Name" = format(module.namer.nat_gateway, element(var.availability_zones, count.index))
  })
}
