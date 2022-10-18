variable "name" {
    description = "Name of the ALB"
    type        = string
}

variable "security_groups" {
    description = "Security groups to be applied to the ALB"
}

variable "subnets" {
    description = "Subnets to be applied to the ALB"
}