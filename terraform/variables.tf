variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "php-ecs"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "us-east-1b"
}

variable "ecr_repository_name" {
  description = "ECR Repository Name"
  type        = string
  default     = "php-app"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "php-cluster"
}

variable "ecs_service_name" {
  description = "ECS Service Name"
  type        = string
  default     = "php-service"
}

variable "task_family" {
  description = "ECS Task Definition Family"
  type        = string
  default     = "php-task"
}

variable "container_name" {
  description = "Container Name"
  type        = string
  default     = "php-app"
}

variable "container_port" {
  description = "Application Port"
  type        = number
  default     = 80
}

variable "cpu" {
  description = "Fargate CPU Units"
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "Fargate Memory (MB)"
  type        = number
  default     = 0.6
}

variable "desired_count" {
  description = "Desired ECS Task Count"
  type        = number
  default     = 1
}

variable "log_group_name" {
  description = "CloudWatch Log Group Name"
  type        = string
  default     = "/ecs/php-app"
}

variable "alb_name" {
  description = "Application Load Balancer Name"
  type        = string
  default     = "php-alb"
}

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
  default     = "php-tg"
}