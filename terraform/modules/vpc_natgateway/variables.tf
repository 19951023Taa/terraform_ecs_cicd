variable "subnet_id" {
  description = "The Subnet ID of the subnet in which to place the gateway."
  type        = string
  default     = ""
}

variable "connectivity_type" {
  description = "Connectivity type for the gateway."
  type        = string
  default     = ""
}

variable "name" {
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map
  default     = {}
}


variable "domain" {
  description = "nat domain"
  type        = string
  default     = "vpc"
}