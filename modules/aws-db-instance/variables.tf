variable "allocated_storage" {
    description = "The allocated storage in gigabytes"
    default     = 10
}

variable "db_name" {
    description = "The name of the database to create when the DB instance is created"
    type        = string
}

variable "engine" {
    description = "The database engine to use"
    default     = "mysql"
}

variable "engine_version" {
    description = "The engine version to use"
    default     = "5.7"
}

variable "instance_class" {
    description = "The instance type of the RDS instance"
    default     = "db.t2.micro"
}

variable "username" {
    description = "Username for the master DB user"
    type        = string
}

variable "password" {
    description = "Password for the master DB user"
    type        = string
}

variable "parameter_group_name" {
    description = "Name of the DB parameter group to associate"
    default     = "default.mysql5.7"
}

variable "db_subnet_group_name" {
    description = "Name of DB subnet group"
}

variable "vpc_security_group_ids" {
    description = "List of VPC security groups to associate"
    type        = list(string)
}

variable "skip_final_snapshot" {
    description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
    default     = true
}