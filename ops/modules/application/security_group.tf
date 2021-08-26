resource "aws_security_group" "application_sg" {
  name        = "application-sg"
  description = "Allow access to rails application"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [var.load_balancer_sg_id]
    description     = "Ingress from Load Balancer"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastian_sg_id]
    description     = "Ingress from Bastian"
  }
}
