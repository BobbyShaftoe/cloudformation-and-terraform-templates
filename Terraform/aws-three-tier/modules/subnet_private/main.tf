
data "aws_vpc" "selected" {
  id = "${var.example_vpc_id}"
}

# Create external facing subnets in us-east-1a AZ
resource "aws_subnet" "example_subnet_private_0" {
  vpc_id = "${data.aws_vpc.selected.id}"
  cidr_block = "${var.subnet_cidrs[0]}"
  availability_zone = "us-east-1"
  map_public_ip_on_launch = false
  tags {
    Name = "subnet_private_0"
  }
}

resource "aws_subnet" "example_subnet_private_1" {
  vpc_id = "${data.aws_vpc.selected.id}"
  cidr_block = "${var.subnet_cidrs[1]}"
  availability_zone = "us-east-1"
  map_public_ip_on_launch = false
  tags {
    Name = "subnet_private_1"
  }
}