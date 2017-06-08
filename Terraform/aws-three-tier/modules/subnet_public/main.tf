data "aws_vpc" "selected" {
  id = "${var.example_vpc_id}"
}

# Create external facing subnets in us-east-1a AZ
resource "aws_subnet" "example_public_subnet" {
  count                   = 1
  vpc_id                  = "${data.aws_vpc.selected.id}"
  cidr_block              = "${var.subnet_cidr}"
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags {
    Name = "subnet_public"
  }
}
