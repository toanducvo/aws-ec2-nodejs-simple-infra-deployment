variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
  default     = "t3.micro"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the key pair"
  default     = "ec2-key-pair"
}