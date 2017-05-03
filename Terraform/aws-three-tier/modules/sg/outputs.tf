output "security_group_web_instance_id" {
  value = "${aws_security_group.web_instance_sg.id}"
}

output "security_group_app_instance_id" {
  value = "${aws_security_group.app_instance_sg.id}"
}

output "security_group_db_instance_id" {
  value = "${aws_security_group.db_instance_sg.id}"
}


output "security_group_elb_id" {
  value = "${aws_security_group.elb_sg.id}"
}

