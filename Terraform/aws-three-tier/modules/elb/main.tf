resource "aws_elb" "example_instances_elb" {
  name = "example-elb"

  # The same availability zone as our instance
  subnets = ["${var.subnet_cidrs}"]

  security_groups = ["${var.security_groups}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  # The instance is registered automatically

  instances                   = ["${var.instances}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_lb_cookie_stickiness_policy" "default" {
  name                     = "lbpolicy"
  load_balancer            = "${aws_elb.example_instances_elb.id}"
  lb_port                  = 80
  cookie_expiration_period = 600
}
