# Configurando o Terraform 
terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}

provider "huaweicloud" {
  region     = "-"
  access_key = "-"
  secret_key = "-"
}
