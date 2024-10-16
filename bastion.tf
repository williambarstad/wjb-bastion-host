# Bastion Host
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.server_ami.id
  instance_type               = var.node_instance_type
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Host"
  }
  subnet_id                   = aws_subnet.public_subnet_az1.id # Public subnet in AZ1
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.private_ip_ingress_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}