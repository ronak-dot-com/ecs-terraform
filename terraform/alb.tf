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