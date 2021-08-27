resource "aws_ecs_cluster" "training_cluster" {
  name = "dl-training-cluster-${var.environment_name}"
}

resource "aws_ecs_service" "training_ecs_service" {
  name            = "dl-training-${var.environment_name}-service"
  cluster         = aws_ecs_cluster.training_cluster.id
  task_definition = aws_ecs_task_definition.app_service.arn
  desired_count   = 1
  iam_role        = aws_iam_role.instance.name

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "application"
    container_port   = 3000
  }
}

data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_launch_configuration" "instance" {
  name_prefix                 = "dl-training-instance-"
  instance_type               = var.instance_type
  image_id                    = data.aws_ami.ecs_ami.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance.name
  security_groups             = [aws_security_group.application_sg.id]
  key_name                    = var.ssh_key_name

  user_data = <<-EOF
                  #!/bin/bash
                  echo ECS_CLUSTER=${aws_ecs_cluster.training_cluster.name} >> /etc/ecs/ecs.config
                EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "dl-training-${var.environment_name}-asg"

  launch_configuration = aws_launch_configuration.instance.name
  termination_policies = ["OldestLaunchConfiguration", "Default"]
  vpc_zone_identifier  = [var.public_subnet_a_id, var.public_subnet_b_id]
  target_group_arns    = [var.lb_target_group_arn]
  max_size             = 3
  min_size             = 1

  health_check_grace_period = 300
  health_check_type         = "EC2"

  tags = [
    {
      key                 = "ecs_cluster"
      value               = aws_ecs_cluster.training_cluster.name
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "Training App Instance ${var.environment_name}"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
