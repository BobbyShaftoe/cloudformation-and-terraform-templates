
provider "aws" {
  region = "${var.aws_region}"
}

module "vpc" {
  source = "modules/vpc"
  vpc_cidr = "${var.cidr}"
}

module "subnets_private" {
  source = "modules/subnet_private"
  example_vpc_id = "${module.vpc.example_vpc_id}"
  subnet_cidrs = ["${var.subnet_private_cidr_0}","${var.subnet_private_cidr_1}"]
}

module "subnet_public" {
  source = "modules/subnet_public"
  example_vpc_id = "${module.vpc.example_vpc_id}"
  subnet_cidr = "${var.subnet_public_cidr_0}"
}

module "example_subnet_db_group" {
  source = "modules/subnet_db"
  db_subnet_id = "${module.subnets_private.example_subnet_private_1_id}"
}

module "example_security_groups" {
  source = "modules/sg"
  example_vpc_id = "${module.vpc.example_vpc_id}"
  subnet_cidrs = ["${var.subnet_public_cidr_0}", "${var.subnet_private_cidr_0}","${var.subnet_private_cidr_1}"]
}



### THIS GOES IN INTERNET GATEWAY MODULE ############################
resource "aws_internet_gateway" "example_ig" {
  vpc_id = "${module.vpc.example_vpc_id}"
  tags {
    Name = "example_ig"
  }
}
//output "example_ig_gw" {
//  value = "${aws_internet_gateway.example_ig.id}"
//}

resource "aws_route_table" "example_route_table" {
  vpc_id = "${module.vpc.example_vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.example_ig.id}"
  }
  tags {
    Name = "example_route_table"
  }
}

resource "aws_route_table_association" "example_route_table_asc" {
  subnet_id      = "${module.subnet_public.example_subnet_public_0_id}"
  route_table_id = "${aws_route_table.example_route_table.id}"
}
##############################################################


module "example_ec2_web" {
  source = "modules/ec2"
  name = "${var.web_instance_name}"
  ami_id = "${var.ami_id}"
  key_name = "${var.key_name}"
  count = "1"
  security_group_id = "${module.example_security_groups.security_group_web_instance_id}"
  subnet_id = "${module.subnet_public.example_subnet_public_0_id}"
  instance_type = "t2.micro"
  domain_name = "some.domain"
  user_data = "#!/bin/bash\necho done"
  create_eip = true
}


module "example_ec2_app" {
  source = "modules/ec2"
  name = "${var.app_instance_name}"
  ami_id = "${var.ami_id}"
  key_name = "${var.key_name}"
  count = "1"
  security_group_id = "${var.security_group_id}"
  subnet_id = "${module.subnets_private.example_subnet_private_1_id}"
  instance_type = "t2.micro"
  domain_name = "some.domain"
  user_data = "#!/bin/bash\necho done"
  create_eip = false
}

module "example_rds_instance" {
  source = "modules/rds"
  identifier = "${var.rds_instance_name}"
  storage = "4"
  engine_version = "9.4.1"
  instance_class = "db.t2.micro"
  identifier = "${var.rds_instance_name}"
  username = "${var.db_username}"
  password = "${var.db_password}"
  security_group_id = "${var.security_group_id}"
  db_subnet_group_name   = "${module.example_subnet_db_group.example_db_subnet_group_name}"
}

module "example_main_instance_elb" {
  source = "modules/elb"
  subnet_cidrs = ["${module.subnet_public.example_subnet_public_0_id}"]
  security_groups = ["${module.example_security_groups.security_group_elb_id}","${module.example_security_groups.security_group_web_instance_id}"]
  instances = ["${module.example_ec2_app.ec2_id}"]

}
