resource "aws_ecs_task_definition" "app_service" {
  family                   = "${var.project_name}-app-task-definition-${var.environment_name}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${var.region}a, ${var.region}b]"
  }

  container_definitions = jsonencode([
    {
      name              = "application",
      image             = "917415714855.dkr.ecr.us-west-2.amazonaws.com/dl-training:latest",
      essential         = true,
      memoryReservation = 512,
      portMappings = [
        {
          hostPort      = 0,
          protocol      = "tcp",
          containerPort = 3000
        }
      ],
      command = ["puma", "-C", "config/puma.rb"],
      environment = [
        {
          name  = "RAILS_MASTER_KEY",
          value = "${var.rails_master_key}"
        },
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
          name  = "RAILS_MAX_THREADS",
          value = "5"
        },
        {
          name  = "RAILS_LOG_TO_STDOUT",
          value = "true"
        },
        {
          name  = "REDIS_HOST",
          value = "${var.redis_host}"
        },
        {
          name  = "REDIS_PORT",
          value = "6379"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.app_instance.name}",
          awslogs-region        = "${var.region}",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
