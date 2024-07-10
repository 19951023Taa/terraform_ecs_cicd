/* Common */
variable "ENV" {
  description = "PD/DV/"
  type        = string
  default     = "dev"
}

variable "subnet_cidrs" {}

variable "rds_password" {}