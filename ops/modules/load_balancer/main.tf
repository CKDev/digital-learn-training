resource "aws_lb" "training_lb" {
  name               = "training-lb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "training_lb_tg" {
  name        = "training-lb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-499"
  }
}

resource "aws_lb_listener" "training_lb_listener" {
  load_balancer_arn = aws_lb.training_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.training_lb_tg.arn
  }
}

