variable "ami_id" {
  type        = string
  description = "AMI for EC2 instances"
  default     = "ami-0b8607d2721c94a77"
}

variable "key_name" {
  type        = string
  description = "SSH key for EC2"
  default     = "singapore_keys"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to deploy"
  default     = 2
}

variable "user_data_path" {
  type        = string
  description = "Path to the EC2 user-data script"
  default     = ""
}
