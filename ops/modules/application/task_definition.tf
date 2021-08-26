resource "aws_ecs_task_definition" "app_service" {
  family                   = "dl-training-app-service-${var.environment_name}"
  requires_compatibilities = ["EC2"]
  memory                   = 128

  container_definitions = jsonencode([
    {
      name      = "application",
      image     = "917415714855.dkr.ecr.us-west-2.amazonaws.com/dl-training:v1.0.0",
      essential = true,
      mountPoints = [
        {
          containerPath = "/public/system",
          sourceVolume  = "dl-training-storage-${var.environment_name}"
        }
      ],
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 0
        }
      ],
      command = ["puma", "-C", "config/puma.rb", "-p", "3000"],
      environment = [
        {
          name  = "POSTGRES_USER",
          value = "${var.db_username}"
        },
        {
          name  = "POSTGRES_PASSWORD",
          value = "${var.db_password}"
        },
        {
          name  = "POSTGRES_HOST",
          value = "${var.db_host}"
        },
        {
          name  = "RAILS_ENV",
          value = "${var.environment_name}"
        },
        {
          name  = "RAILS_MAX_THREADS"
          value = "5"
        },
        {
          name  = "BUNDLE_PATH",
          value = "/bundle"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/dl-training-ecs-task",
          awslogs-region        = "${var.region}",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])


  volume {
    name = "dl-training-storage-${var.environment_name}"

    docker_volume_configuration {
      scope         = "task"
      autoprovision = false
      driver        = "rexray/ebs"
    }
  }
}
