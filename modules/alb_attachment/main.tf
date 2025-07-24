resource "aws_lb_target_group_attachment" "api_attachment" {
  count            = length(var.instance_ids)
  target_group_arn = var.target_group_arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}
