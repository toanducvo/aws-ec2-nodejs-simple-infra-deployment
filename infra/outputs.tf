output "expressjs_instance_public_ip" {
  description = "IP address of the ExpressJS instance"
  value       = aws_instance.expressjs_instance.public_ip
}

output "expressjs_instance_name" {
  description = "Name of the ExpressJS instance"
  value       = aws_instance.expressjs_instance.tags.Name
}