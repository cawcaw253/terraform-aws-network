##################
# Public Subnets #
##################
locals {
  # public_subnet_map = merge([
  #   for key, cidr_list in var.public_subnets : {
  #     for cidr in cidr_list : "${key}-${index(cidr_list, cidr)}" => {
  #       index  = index(cidr_list, cidr)
  #       module = key
  #       cidr   = cidr
  #     }
  #   }
  # ]...)

  public_subnet_map = merge([
    for subnet in var.public_subnets : {
      for cidr in subnet.cidr_list : "${subnet.name}-${base64sha256(join("", [subnet.name, cidr]))}" => {
        index = index(subnet.cidr_list, cidr)
        name = subnet.name
        cidr = cidr
        tag = subnet.tag
        map_public_ip_on_launch = subnet.map_public_ip_on_launch
      }
    }
  ]...)
}

resource "aws_subnet" "public_subnet" {
  for_each = local.public_subnet_map

  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = try(each.value.map_public_ip_on_launch, true)

  cidr_block        = try(each.value["cidr"], null)
  availability_zone = element(module.region.availability_zone_names, each.value.index)

  tags = merge(
    var.default_tags,
    try(each.value.tag, {}),
    { "Name" = format(module.namer.subnet, each.value.name, local.public_subnet_abbreviation, element(var.availability_zones, each.value.index)) }
  )
}

resource "aws_route_table_association" "public_route" {
  for_each = local.public_subnet_map

  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route[each.key].id
}

resource "aws_route_table" "public_route" {
  for_each = local.public_subnet_map

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.default_tags,
    { "Name" = format(module.namer.route_table, each.value.name, local.public_subnet_abbreviation, element(var.availability_zones, each.value.index)) }
  )
}

resource "aws_route" "internet_gateway" {
  for_each = local.public_subnet_map

  route_table_id         = aws_route_table.public_route[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
