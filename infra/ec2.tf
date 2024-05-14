resource "aws_instance" "expressjs_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  security_groups = [aws_security_group.web_server_security_group.name]
  key_name        = aws_key_pair.ec2_key.key_name

  tags = {
    Name = "ExpressJS Instance"
  }

  provisioner "file" {
    source      = "sample.zip"
    destination = "~/app/sample.zip"

    connection {
      type        = "ssh"
      user = "ubuntu"
      private_key = "${file("${local_file.private_key_pem.filename}")}"
      host = self.public_ip
    }
  }
}

resource "null_resource" "ansible_provisioner" {
  triggers = {
    instance_id = aws_instance.expressjs_instance.id
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.expressjs_instance.public_ip},' -u ubuntu --private-key ${local_file.private_key_pem.filename} playbook.yml"
  }
}