variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
}

variable "lb_type" {
  description = "The type of the load balancer (application or network)"
  type        = string
}

variable "security_groups" {
  description = "The security groups to associate with the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "The subnets to associate with the load balancer"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The idle timeout for connections in seconds"
  type        = number
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  description = "Whether to enable cross-zone load balancing"
  type        = bool
  default     = false
}