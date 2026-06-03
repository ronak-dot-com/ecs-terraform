resource "aws_lb" "app" {
  name               = "php-alb"
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

resource "aws_lb_target_group" "app" {
  name        = "php-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.app.arn
  }
}