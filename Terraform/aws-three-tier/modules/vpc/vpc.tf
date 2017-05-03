variable "vpc_cidr" { }


# Create a VPC to launch our instances into
resource "aws_vpc" "example_vpc_id" {

  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  lifecycle {
    create_before_destroy = true
  }
  tags {
    Name = "small_test_vpc"
  }
}

output "example_vpc_id" {
  value = "${aws_vpc.example_vpc_id.id}"
}
