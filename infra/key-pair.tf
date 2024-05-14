resource "tls_private_key" "ec2_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.ec2_key_pair.private_key_pem
  filename        = "${var.key_pair_name}.pem"
  file_permission = 0400
}

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_key_pair.public_key_openssh
}