resource "aws_security_group" "database_sg" {
  name        = "database-sg"
  description = "Database security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.bastian_sg_id]
    description     = "Database access for Bastian server"
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.application_sg_id]
    description     = "Database access for Application"
  }
}
