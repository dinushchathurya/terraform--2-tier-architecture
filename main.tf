module "aws_vpc" {
    source           = "./modules/aws-vpc"
    for_each         = var.vpc_config
    vpc_cidr         = each.value.vpc_cidr
    instance_tenancy = each.value.instance_tenancy
    tags             = each.value.tags
}