output "natgateway_id" {
  description = "ID of the EIP allocated to the selected Nat Gateway."
  value       = aws_nat_gateway.this.id
}