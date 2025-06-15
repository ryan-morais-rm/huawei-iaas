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

provider "huaweicloud" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
