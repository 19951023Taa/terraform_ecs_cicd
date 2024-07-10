output "subnet_id" {
  description = "subnet ID"
  value       = aws_subnet.this.id
}

output "subnet_arn" {
  description = "subnetARN"
  value       = aws_subnet.this.arn
}