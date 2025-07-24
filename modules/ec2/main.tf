resource "aws_instance" "api" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.key_name
  user_data     = file("${path.module}/scripts/user-data.sh")
  tags = {
    Name = "${var.name_prefix}-api-${count.index}"
  }
}
