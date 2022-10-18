resource "aws_instance" "instance" {
    ami                         = var.ami
    instance_type               = var.instance_type
    associate_public_ip_address = true
    subnet_id                   = var.subnet_id
    security_groups             = var.security_groups

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Code finally Worked.EC2 instance launched in us-west-2a!!!</h1>" > var/www/html/index.html
    EOF
}

