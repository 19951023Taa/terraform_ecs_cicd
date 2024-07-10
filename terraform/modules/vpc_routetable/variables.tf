variable "routes" {}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "route_table_tags" {
  description = "route table tags"
  type        = map(any)
  default     = {}
}

variable "table_name" {
  description = "route table tags"
  type        = string
  default     = ""
}