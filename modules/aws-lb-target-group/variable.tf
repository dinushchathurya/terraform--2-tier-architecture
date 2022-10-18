variable "alb-name" {
    description = "Name of the ALB"
    type        = string
}

variable "vpc-id" {
    description = "ID of the VPC"
    type        = string
}

variable "port" {
    description = "Port of the ALB"
    type        = number
}

variable "protocol" {
    description = "Protocol of the ALB"
    type        = string
}

variable "tags" {
    description = "Tags to be applied to the ALB"
    type        = map(string)
}