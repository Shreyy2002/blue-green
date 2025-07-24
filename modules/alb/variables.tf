variable "subnet_ids" { type = list(string) }
variable "security_group_id" {}
variable "tg_name" { default = "api-tg" }
variable "vpc_id" {}
