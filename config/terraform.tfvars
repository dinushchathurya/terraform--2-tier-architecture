vpc_config = {

    vpc-one = {
        vpc_cidr         = "10.0.0.0/16"
        instance_tenancy = "default"
        tags = {
            Name = "main"
        }
    }

}

subnet_config = {

    public-subnet-one = {
        vpc_name                = "vpc-one"
        cidr_block              = "10.0.1.0/24"
        map_public_ip_on_launch = true
        availability_zone       = "us-east-1a"
        tags = {
            Name = "public-subnet-one"
        }
    }

    public-subnet-two = {
        vpc_name                = "vpc-one"
        cidr_block              = "10.0.2.0/24"
        map_public_ip_on_launch = true
        availability_zone       = "us-east-1b"
        tags = {
            Name = "public-subnet-two"
        }
    }

    private-subnet-one = {
        vpc_name                = "vpc-one"
        cidr_block              = "10.0.3.0/24"
        map_public_ip_on_launch = false
        availability_zone       = "us-east-1a"
        tags = {
            Name = "private-subnet-one"
        }
    }

    private-subnet-two = {
        vpc_name                = "vpc-one"
        cidr_block              = "10.0.4.0/24"
        map_public_ip_on_launch = false
        availability_zone       = "us-east-1b"
        tags = {
            Name = "private-subnet-two"
        }
    }

}

igw_config = {

    igw-one = {
        vpc_name = "vpc-one"
        tags = {
            Name = "igw-one"
        }
    }

}

route_table_config = {

    public-table-one = {
        vpc_name   = "vpc-one"
        cidr_block = "0.0.0.0/0"
        igw_name   = "igw-one"
        tags = {
            Name = "public-one"
        }
    }

}

route_table_association_config = { 

    public-subnet-one = {
        subnet_name = "public-subnet-one"
        table_name  = "public-table-one"
    }

    public-subnet-two = {
        subnet_name = "public-subnet-two"
        table_name  = "public-table-one"
    }

}

security_group_config = { 

    security_one = { 
        vpc_name = "vpc-one"
        security_group_name     = "application-security-group"
    }

    security_Two = {
        vpc_name            = "vpc-one"
        security_group_name = "db-security-group"
    }

}

lb_target_group_config = {

    target_group_one = {
        alb-name = "target-group-one"
        port     = 80
        protocol = "HTTP"
        vpc_name = "vpc-one"
        tags = {
            Name = "target-group-one"
        }
    }

}

lb_config = {

    alb-one = {
        name            = "alb-one"
        security_groups = "security_one"
        subnet_one      = "public-subnet-one"
        subnet_two      = "public-subnet-two"
    }

}

lb_listener_config = {

    listener_one = {
        alb-name          = "alb-one"
        target_group_name = "target_group_one"
    }

}

lb_target_group_attachment_config = {

    target_group_one = {
        alb-name          = "alb-one"
        target_group_name = "target_group_one"
        instance_id       = "instance_one"
    }

}

instance_config = {

    instance_one = {
        ami_id             = "ami-0c2b8ca1dad447f8a"
        instance_type      = "t2.micro"
        security_groups    = "security_one"
        subnet_name        = "public-subnet-one"
        user_data          = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Code finally Worked.EC2 instance launched in us-west-2a!!!</h1>" > var/www/html/index.html
            EOF
    }

    instance_two = {
        ami_id             = "ami-0c2b8ca1dad447f8a"
        instance_type      = "t2.micro"
        security_groups    = "security_one"
        subnet_name        = "public-subnet-two"
        user_data          = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Code finally Worked.EC2 instance launched in us-west-2b!!!</h1>" > var/www/html/index.html
            EOF
    }

}

db_instance_config = {

    db_instance_one = {
        allocated_storage    = 10
        db_name              = "testdb"
        engine               = "mysql"
        engine_version       = "5.7"
        instance_class       = "db.t2.micro"
        username             = "admin"
        password             = "admin123"
        parameter_group_name = "default.mysql5.7"
        db_subnet_group_name = "db_subnet_group_one"
        skip_final_snapshot  = true
        security_groups      = "security_one"
    }

}

db_subnet_group_config = { 
    
        db_subnet_group_one = {
            name        = "db_subnet_group_one"
            subnet_one  = "private-subnet-one"
            subnet_two  = "private-subnet-two"
        }
    
}