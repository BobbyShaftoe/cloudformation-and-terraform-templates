
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "example_db_subnet_group"
  subnet_ids = ["${var.db_subnet_id}"]

  tags {
    Name = "Example DB subnet group"
  }
}