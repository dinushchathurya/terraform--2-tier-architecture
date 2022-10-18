variable "ami" {
    description = "AMI ID"
    default     = "ami-08e2d37b6a0129927"
}

variable "instance_type" {
    description = "Instance type"
    default     = "t2.micro"
}

variable "subnet_id" {
    description = "Subnet ID"
}

variable "security_groups" {
    description = "Security Group ID"
}

variable "user_data" {

}