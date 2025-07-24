variable "ami_id" {}
variable "instance_type" { default = "t2.micro" }
variable "instance_count" { default = 1 }
variable "subnet_id" {}
variable "security_group_id" {}
variable "key_name" {}
variable "name_prefix" { default = "blue" }
