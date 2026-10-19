resource "aws_launch_template" "alt" {
  name          = var.template
  image_id      = "ami-042d7899818bea126"
  instance_type = "t3.micro"

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  security_group_names = [var.sg_http, var.sg_http]
  network_interfaces {
    delete_on_termination = true
  }

  key_name = var.key_pair

  placement {
    availability_zone = "eu-west-1"
  }

  iam_instance_profile {
    name = var.iam_profile
  }

  user_data = filebase64("${path.module}/script.sh")

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }

}

resource "aws_autoscaling_group" "asg" {
  name             = var.asg
  max_size         = 2
  min_size         = 1
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.alt.id
    version = "$Latest"
  }
}

resource "aws_lb" "load_balancer" {
  name               = var.loadbalancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_lb_http]
  subnets            = [for subnet in data.aws_subnets.subnets.ids : subnet]
  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_autoscaling_group.asg.arn
  }
}
