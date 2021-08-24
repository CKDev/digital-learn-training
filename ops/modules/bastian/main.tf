resource "aws_instance" "bastian_instance" {
  ami                         = "ami-03d5c68bab01f3496"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.bastian_sg.id]
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.developer.key_name

  tags = {
    Name = "Training Bastian (${var.environment_name})"
  }
}
