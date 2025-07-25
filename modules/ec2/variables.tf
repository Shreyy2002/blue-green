variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "name_prefix" {
  type    = string
  default = "blue"
}

variable "user_data_path" {
  type    = string
  default = ""
  description = "Absolute path to user-data.sh; if empty, no user data is used"
}
