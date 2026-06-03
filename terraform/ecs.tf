resource "aws_ecs_cluster" "main" {
  name = "php-cluster"
}

resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/php-app"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "php-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 0.25
  memory = 0.6

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "php-app"

      image = "${aws_ecr_repository.app.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "php-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 1

  launch_type = "FARGATE"

  depends_on = [
    aws_lb_listener.app
  ]

  network_configuration {
    assign_public_ip = true

    subnets = [
      aws_subnet.public1.id,
      aws_subnet.public2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn

    container_name = "php-app"
    container_port = 80
  }
}