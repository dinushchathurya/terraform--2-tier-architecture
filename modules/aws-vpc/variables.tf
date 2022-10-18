variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
    default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC."
    type        = string
    default     = "default"
}


variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map(string)
    default     = {
        Name = "main"
    }
}