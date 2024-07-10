variable "load_balancer_arn" {
  description = "The load_balancer_arn"
  type        = string
}

variable "listener_port" {
  description = "The port for the listener"
  type        = number
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID for the target group"
  type        = string
}

variable "health_check_interval" {
  description = "The interval for health checks"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "The path for health checks"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "The protocol for health checks"
  type        = string
  default     = "HTTP"
}

variable "health_check_timeout" {
  description = "The timeout for health checks"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The number of successful checks before considering the target healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of failed checks before considering the target unhealthy"
  type        = number
  default     = 3
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "target_type" {
  description = "The target_type"
  type        = string
}