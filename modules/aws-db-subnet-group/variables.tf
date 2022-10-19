
variable "name" {
    description = "The name of the DB subnet group. If omitted, Terraform will assign a random, unique name."
    type        = string
}

variable "subnet_ids" {
    description = "A list of VPC subnet IDs."
    type        = list(string)
}