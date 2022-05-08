
  
resource "aws_key_pair" "key" {
  key_name   = "aws-key-terraform"
  public_key = var.aws_pub_key
}

resource "aws_instance" "vm" {
  ami                         = "ami-0eea504f45ef7a8f7"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = aws_subnet.subnet.0.id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform"
  }
}