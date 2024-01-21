##################
# Public Subnets #
##################
resource "aws_subnet" "public_subnet" {
  for_each = local.public_subnet_map

  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = false

  cidr_block        = try(each.value["cidr"], null)
  availability_zone = element(module.region.availability_zone_names, each.value.index)

  tags = merge(
    var.default_tags,
    try(var.public_subnets_tag[each.value.module], {}),
    { "Name" = format(module.namer.subnet, each.value.module, local.public_subnet_abbreviation, element(var.availability_zones, each.value.index)) }
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
    { "Name" = format(module.namer.route_table, each.value.module, local.public_subnet_abbreviation, element(var.availability_zones, each.value.index)) }
  )
}

resource "aws_route" "internet_gateway" {
  for_each = local.public_subnet_map

  route_table_id         = aws_route_table.public_route[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
