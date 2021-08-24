resource "aws_instance" "bastian_instance" {
  ami                    = "ami-03d5c68bab01f3496"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastian_sg.id]
}