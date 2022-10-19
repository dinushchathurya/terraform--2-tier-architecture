resource "aws_db_subnet_group" "db_sub_grp" {
    name       = var.name
    subnet_ids = var.subnet_ids
}

