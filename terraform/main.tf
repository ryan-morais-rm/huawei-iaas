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
  region     = "sa-brazil-1"
  access_key = "VY6SA9JMX5ORXS5XQOLZ"
  secret_key = "QTLq71k4jlzTR37Lo3cO0RypEkGOtI1YNOE0jfSH"
}
