
# Create a Security Group Rule to allow port 3000
resource "aws_security_group_rule" "allow_port_3000" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.expressjs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create a Security Group Rule to allow port 22
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.expressjs_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create a Security Group to allow HTTP traffic
resource "aws_security_group" "expressjs_security_group" {
  name   = "ExpressJS Security Group"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}