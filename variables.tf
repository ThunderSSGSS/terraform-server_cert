
variable "domain_name" { type = string }

variable "environment" {
    type    = string
    default = ""
}

variable "managed_by" {
    type    = string
    default = ""
}

variable "cert_validation_timeout" {
    type        = number
    default     = 10
    description = "Number of minutes to wait for certificate validation"
}

# Locals

locals {
    tags = {
        Environment = var.environment
        Managed_by  = var.managed_by
    }
}

