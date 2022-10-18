module "aws_vpc" {
    source           = "./modules/aws-vpc"
    for_each         = var.vpc_config
    vpc_cidr         = each.value.vpc_cidr
    instance_tenancy = each.value.instance_tenancy
    tags             = each.value.tags
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
    source   = "./modules/aws-igw"
    for_each = var.igw_config
    vpc_id   = module.aws_vpc[each.value.vpc_name].vpc_id
    tags     = each.value.tags
}