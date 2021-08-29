resource "aws_ecs_task_definition" "app_service" {
  family                   = "training-app-task-definition-${var.environment_name}"
  requires_compatibilities = ["EC2"]
  memory                   = 512
  cpu                      = 512

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${var.region}a, ${var.region}b]"
  }

  container_definitions = jsonencode([
    {
      name      = "application",
      image     = "917415714855.dkr.ecr.us-west-2.amazonaws.com/dl-training:latest",
      essential = true,
      #      mountPoints = [
      #        {
      #          containerPath = "/public/system",
      #          sourceVolume  = "dl-training-storage-${var.environment_name}"
      #        }
      #      ],
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 0
        }
      ],
      command = ["bundle", "exec", "puma", "-C", "config/puma.rb", "-p", "3000"],
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
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.instance.name}",
          awslogs-region        = "${var.region}",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])


  #  volume {
  #    name = "dl-training-storage-${var.environment_name}"

  #    docker_volume_configuration {
  #      scope         = "task"
  #      autoprovision = false
  #      driver        = "rexray/ebs"
  #    }
  #  }
}
