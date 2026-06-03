output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public2.id
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.app.arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.app.dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.app.arn
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.app.name
}

output "task_definition_arn" {
  description = "ECS Task Definition ARN"
  value       = aws_ecs_task_definition.app.arn
}

output "ecr_repository_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.app.name
}

output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_lb.app.dns_name}"
}