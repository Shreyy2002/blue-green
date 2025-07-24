output "instance_ids" {
  value = aws_instance.api[*].id
}
output "private_ips" {
  value = aws_instance.api[*].private_ip
}
