output "lb_listener_arn" {
  description = "The ARN of the load balancer listener"
  value       = aws_lb_listener.this.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.name
}