variable "cidr" {
  default = "10.99.0.0/16"
}

variable "subnet_public_cidr_0" {
  default = "10.99.1.0/24"
}

variable "subnet_private_cidr_0" {
  default = "10.99.2.0/24"
}

variable "subnet_private_cidr_1" {
  default = "10.99.3.0/24"
}

variable "aws_region" {
  default = "us-east-1"
}

variable security_group_id {
  default = "sg-cf2a2bb3"
}

variable "app_instance_name" {
  default = "example-app-instance"
}

variable "web_instance_name" {
  default = "example-web-instance"
}

variable "rds_instance_name" {
  default = "example-db-instance"
}

variable "ami_id" {
  default = "ami-f6e27ee0"
}

variable "key_name" {
  default = "nb-keypair-02"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "supersecret"
}
