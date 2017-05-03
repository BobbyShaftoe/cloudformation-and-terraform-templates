variable "identifier" {
  default     = "example_rds_instance"
  description = "Identifier"
}

variable "storage" {
  default     = "10"
  description = "Storage size (GB)"
}

variable "storage_type" {
  default     = "gp2"
  description = "Storage type (gp2/io1)"
}

variable "engine" {
  default     = "postgres"
  description = "Engine type - Postgres"
}

variable "engine_version" {
  default = "9.4.1"
  description = "Engine version"
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "postgres_db_instance"
  description = "DB name"
}

variable "username" {
  default     = "admin"
  description = "User name"
}

variable "password" {
  description = "Secret password"
}

variable "security_group_id" {
  default = ""
}
variable "db_subnet_group_name" {
  default = ""
}