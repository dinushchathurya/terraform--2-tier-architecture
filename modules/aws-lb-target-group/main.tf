resource "aws_lb_target_group" "alb-tg" {
    name     = var.alb-name
    port     = var.port
    protocol = var.protocol
    vpc_id   = var.vpc-id

    tags = var.tags
}

