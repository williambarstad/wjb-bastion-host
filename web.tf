resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id
  ]
  
  min_size = 2  # At least one instance per AZ
  max_size = 4  # Allow it to scale up if needed
  desired_capacity = 2

  launch_configuration = aws_launch_configuration.web_lc.id
}

resource "aws_launch_configuration" "web_lc" {
  image_id      = data.aws_ami.server_ami.id  # Web server AMI
  instance_type = var.node_instance_type
}