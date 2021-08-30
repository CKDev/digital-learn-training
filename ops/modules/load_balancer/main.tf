resource "aws_lb" "load_balancer" {
  name            = "${var.project_name}-lb"
  security_groups = [aws_security_group.load_balancer_sg.id, var.default_security_group_id]
  subnets         = var.public_subnet_ids

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "load_balancer_tg" {
  name        = "${var.project_name}-lb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
    matcher             = "200-499"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  depends_on        = [aws_lb_target_group.load_balancer_tg]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_tg.arn
  }
}

