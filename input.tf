variable "name" {
  type        = string
  description = "The name of the new Virtual Private Cloud"

  validation {
    condition     = can(regex("[a-z]([-a-z0-9]*[a-z0-9])?", var.name)) && length(var.name) <= 63
    error_message = "The name of the new VPC should be only letters and dashes."
  }
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the new Virtual Private Cloud"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the new Virtual Private Cloud"
}

variable "enable_ipv6" {
  type        = bool
  default     = true
  description = "Enable IPv6 support"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}

variable "module_tags" {
  type        = bool
  default     = true
  description = "Include module tags"
}

variable "public_subnets" {
  type = map(object({
    id              = string
    name            = string
    cidr_block      = string
    zone            = string
    ipv6_cidr_index = optional(number)
  }))
  default     = {}
  description = "Public subnet map"
}

variable "private_subnets" {
  type = map(object({
    id              = string
    name            = string
    cidr_block      = string
    zone            = string
    ipv6_cidr_index = optional(number)
  }))
  default     = {}
  description = "Private subnet map"
}

locals {
  module_tags = {
    "aws_vpc/version" = "1.0.0"
  }
}
