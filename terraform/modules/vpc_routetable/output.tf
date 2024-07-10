output "table_id" {
  description = "route table"
  value       = aws_route_table.this.id
}

output "routes" {
  description = "routes"
  value = {
    for routes in aws_route.this : routes.id => routes
  }
}