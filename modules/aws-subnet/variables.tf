variable "vpc_id" {
    description = "VPC ID"
}

variable "cidr_block" {
    description = "CIDR block"
}

variable "map_public_ip_on_launch" {
    description = "Map public IP on launch"
    default = true
}

variable "availability_zone" {
    description = "Availability zone"
}

variable "tags" {
    description = "Tags"
    type = map(string)
    default = {
        Name = "subnet"
    }
}