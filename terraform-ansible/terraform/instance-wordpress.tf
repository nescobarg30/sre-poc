resource "aws_instance" "wordpress-a" {
  ami                         = "ami-06b263d6ceff0b3dd"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.pockey.key_name
  vpc_security_group_ids      = [aws_security_group.wordpress.id]
  subnet_id                   = aws_subnet.app-subnet-a.id
  associate_public_ip_address = true
  tags = {
    Name = "terraform-EC2 Instance"
  }
}

resource "aws_instance" "wordpress-b" {
  ami                         = "ami-06b263d6ceff0b3dd"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.pockey.key_name
  vpc_security_group_ids      = [aws_security_group.wordpress.id]
  subnet_id                   = aws_subnet.app-subnet-b.id
  associate_public_ip_address = true
  tags = {
    Name = "terraform-EC2 Instance"
  }
}
