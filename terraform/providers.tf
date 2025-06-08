# Estrutura básica do provedor
# Provider's basic structure

terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}

variable "region_name" {
  description = "The region where the ECS instance is located"
  type = string
}

variable "access_key" {
  description = "The access key of the IAM user"
  type = string
}

variable "secret_key" {
  description = "The secret key of the IAM user"
  type = string
}

provider "huaweicloud" {
  region = var.region_name
  access_key = var.access_key
  secret_key = var.secret_key
}