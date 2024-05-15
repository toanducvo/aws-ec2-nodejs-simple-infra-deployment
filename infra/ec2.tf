resource "aws_instance" "expressjs_instance" {
  vpc_security_group_ids = [aws_security_group.expressjs_security_group.id]
  subnet_id              = aws_subnet.public_subnet_a.id
  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name = "ExpressJS Instance"
  }
}

resource "local_file" "host_file" {
  content  = templatefile("${path.module}/templates/inventory.tpl", { key_name = "${aws_key_pair.ec2_key.key_name}.pem", public_ip = aws_instance.expressjs_instance.public_ip, username = "ubuntu" })
  filename = "./inventory.yaml"
}

resource "null_resource" "ansible_provisioner" {
  depends_on = [local_file.host_file, aws_instance.expressjs_instance]
  provisioner "local-exec" {
    command = "ansible-playbook -i ./inventory.yaml playbook.yaml"
  }
}

resource "null_resource" "delete_zip_file" {
  depends_on = [null_resource.ansible_provisioner]

  lifecycle {
    ignore_changes = [triggers]
  }

  provisioner "local-exec" {
    command = "rm ./sample.zip"
  }
}