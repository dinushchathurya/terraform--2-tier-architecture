resource "aws_lb_target_group_attachment" "my-aws-alb" {
    target_group_arn = var.target_group_arn
    target_id        = var.target_id
    port             = 80
}


