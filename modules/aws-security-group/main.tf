resource "aws_security_group" "public" {
    name   = var.security-group-name
    vpc_id = var.vpc-id  
}
 
resource "aws_security_group_rule" "public_out" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
    security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group_rule" "public_in_ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

    security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group_rule" "public_in_http" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

    security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group_rule" "public_in_https" {
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

    security_group_id = aws_security_group.public.id
}
 
resource "aws_security_group" "private" {
    name   = var.security-group-name
    vpc_id = var.vpc-id   

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.public.id]
    }  
}
 
resource "aws_security_group_rule" "private_out" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.private.id
}
 