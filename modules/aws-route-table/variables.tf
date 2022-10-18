variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "cidr_block" {
    description = "The CIDR block for the route table"
    type        = string
}

variable "gateway_id" {
    description = "The ID of the gateway to route to"
    type        = string
}

variable "tags" {
    description = "A mapping of tags to assign to the resource"
    type        = map(string)
}