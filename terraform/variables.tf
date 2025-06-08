# Descrição das variáveis
# Variables description

variable "vpc_name" {
  description = "The name of the VPC"
  type = string
}

variable "subnet_name" {
    description = "The name of the subnet"
    type = string
}

variable "security_group_name" {
    description = "The name of the security group"
    type = string
}

variable "instance_name" {
  description = "The name of the ECS instance"
  type = string
}

variable "admin_password" {
    description = "The password of the admin"
    type = string
}

