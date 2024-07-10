resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    { "Name" = var.table_name },
    var.route_table_tags
  )
}

resource "aws_route" "this" {
  for_each   = var.routes
  depends_on = [aws_route_table.this]

  route_table_id = aws_route_table.this.id

  /* One of the following destination arguments must be supplied: */
  destination_cidr_block     = try(each.value.destination_cidr_block, null)
  destination_prefix_list_id = try(each.value.destination_prefix_list_id, null)

  /* One of the following destination arguments must be supplied: */
  gateway_id                = try(each.value.gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}