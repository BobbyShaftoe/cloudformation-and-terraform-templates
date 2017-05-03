# web instance security group
resource "aws_security_group" "web_instance_sg" {
  name        = "web_instance_sg"
  description = "Used in the terraform"
  vpc_id      = "${var.example_vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_instance_sg" {
  name        = "web_instance_sg"
  description = "API access from web server"
  vpc_id      = "${var.example_vpc_id}"

  # SSH access from app_server
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet_cidrs[0]}"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet_cidrs[0]}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_instance_sg" {
  name        = "db_instance_sg"
  description = "Postgres access from app server"
  vpc_id      = "${var.example_vpc_id}"

  # Postgres access from app server
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet_cidrs[1]}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.subnet_cidrs[1]}"]
  }
}



# elb security group
resource "aws_security_group" "elb_sg" {
  name = "elb_sg"
  description = "Used in the terraform"

  vpc_id = "${var.example_vpc_id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}









  # ensure the VPC has an Internet gateway or this step will fail
//  depends_on = ["aws_internet_gateway."]
