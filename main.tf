module "aws_vpc" {
    source                  = "./modules/aws-vpc"
    for_each                = var.vpc_config
    vpc_cidr                = each.value.vpc_cidr
    instance_tenancy        = each.value.instance_tenancy
    tags                    = each.value.tags
}

module "subnet" {
    source                  = "./modules/aws-subnet"
    for_each                = var.subnet_config
    vpc_id                  = module.aws_vpc[each.value.vpc_name].vpc_id
    cidr_block              = each.value.cidr_block
    map_public_ip_on_launch = each.value.map_public_ip_on_launch
    availability_zone       = each.value.availability_zone
    tags                    = each.value.tags
}

module "igw" {
    source                  = "./modules/aws-igw"
    for_each                = var.igw_config
    vpc_id                  = module.aws_vpc[each.value.vpc_name].vpc_id
    tags                    = each.value.tags
}

module "route_table" {
    source                  = "./modules/aws-route-table"
    for_each                = var.route_table_config
    vpc_id                  = module.aws_vpc[each.value.vpc_name].vpc_id
    cidr_block              = each.value.cidr_block
    gateway_id              = module.igw[each.value.igw_name].igw_id
    tags                    = each.value.tags
}

module "route_table_association" {
    source                  = "./modules/aws-route-table-association"
    for_each                = var.route_table_association_config
    subnet_id               = module.subnet[each.value.subnet_name].subnet_id
    route_table_id          = module.route_table[each.value.table_name].route_table_id
}

module "security_group" {
    source                  = "./modules/aws-security-group"
    for_each                = var.security_group_config
    security-group-name     = each.value.security_group_name
    vpc-id                  = module.aws_vpc[each.value.vpc_name].vpc_id
}

module "lb_target_group" {
    source                  = "./modules/aws-lb-target-group"
    for_each                = var.lb_target_group_config
    alb-name                = each.value.alb-name
    vpc-id                  = module.aws_vpc[each.value.vpc_name].vpc_id
    port                    = each.value.port
    protocol                = each.value.protocol
    tags                    = each.value.tags
}

module "lb" {
    source                  = "./modules/aws-lb"
    for_each                = var.lb_config
    name                    = each.value.name
    security_groups         = [module.security_group[each.value.security_groups].security_group_public]
    subnets                 = [module.subnet[each.value.subnet_one].subnet_id,module.subnet[each.value.subnet_two].subnet_id]
}

module "lb_listener" {
    source                  = "./modules/aws-lb-listener"
    for_each                = var.lb_listener_config
    load_balancer_arn       = module.lb[each.value.alb-name].lb_arn
    target_group_arn        = module.lb_target_group[each.value.target_group_name].lb_target_group_arn
}

module "lb_target_group_attachment" {
    source                  = "./modules/aws-lb-target-group-attachment"
    for_each                = var.lb_target_group_attachment_config
    target_group_arn        = module.lb_target_group[each.value.target_group_name].lb_target_group_arn
    target_id               = module.instance[each.value.instance_id].instance_id
}

module "instance" {
    source                  = "./modules/aws-instance"
    for_each                = var.instance_config
    ami                     = each.value.ami_id
    instance_type           = each.value.instance_type
    subnet_id               = module.subnet[each.value.subnet_name].subnet_id
    security_groups         = [module.security_group[each.value.security_groups].security_group_public]
    user_data               = each.value.user_data
}

module "db_instance" {
    source                  = "./modules/aws-db-instance"
    for_each                = var.db_instance_config
    allocated_storage       = each.value.allocated_storage
    db_name                 = each.value.db_name
    engine                  = each.value.engine
    engine_version          = each.value.engine_version
    instance_class          = each.value.instance_class
    username                = each.value.username
    password                = each.value.password
    parameter_group_name    = each.value.parameter_group_name
    db_subnet_group_name    = each.value.db_subnet_group_name
    vpc_security_group_ids  = [module.security_group[each.value.security_groups].security_group_public]
    skip_final_snapshot     = each.value.skip_final_snapshot
}

module "db_subnet_group" {
    source                  = "./modules/aws-db-subnet-group"
    for_each                = var.db_subnet_group_config
    name                    = each.value.name
    subnet_ids              = [module.subnet[each.value.subnet_one].subnet_id,module.subnet[each.value.subnet_two].subnet_id]
}