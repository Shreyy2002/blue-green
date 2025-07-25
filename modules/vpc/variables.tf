variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
}
