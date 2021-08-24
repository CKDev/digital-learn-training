resource "aws_security_group" "load_balancer_sg" {
  name        = "load_balancer_sg"
  description = "Allow access to application's load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}