resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group_name
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${aws_ecr_repository.app.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
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

  depends_on = [
    aws_cloudwatch_log_group.ecs
  ]
}

resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  launch_type   = "FARGATE"
  desired_count = var.desired_count

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

    container_name = var.container_name
    container_port = var.container_port
  }
}