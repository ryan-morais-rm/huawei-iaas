# Descrição das variáveis
# Variables description


# Basic variables
variable "region" {
  description = "The region where the ECS instance is located"
  type = string
  default = null 
}

variable "access_key" {
  description = "The access key of the IAM user"
  type = string
}

variable "secret_key" {
  description = "The secret key of the IAM user"
  type = string
}

variable "availability_zone" {
  description = "Specifies the AZ in which to create the instance"
  type = string
  default = "AZ7"
}





# Network variables
variable "vpc_name" {
  description = "The name of the VPC"
  type = string
  default = "vpc_production"
}

variable "subnet_name" {
    description = "The name of the subnet"
    type = string
    default = "subnet_primary"
}

variable "subnet_id" {
  description = "VPC Subnet ID in UUID format"
  type = string
  nullable = false
}

variable "security_group_name" {
    description = "The name of the security group"
    type = string
}





# Instance variables
variable "instance_name" {
  description = "The name of the ECS instance"
  type = string
  default = "Huawei_Linux"
}

variable "flavor_name" {
  description = "Specifies the instance's flavor"
  type = string
  default = "s7n.xlarge.2"
}

variable "image_id" {
  description = "Image id of the desired instance"
  type = string
  default = null
}

variable "instance_image" {
  description = "Requirements for Compute Instance Image"
  type = object({
    name = optional(string, "CentOS 7.6 server 64bit")
    visibility = optional(string, "public")
    architecture = optional(string, "x86")
    most_recent = optional(bool, true) 
  })
  default = {} 
}

variable "system_disk_type" {
  description = "Specifies: SAS, SSD, GPSSD, ESSD"
  type = string
  default = "SSD"
  validation {
    condition = contains(["SAS", "SSD", "GPSSD", "ESSD"], var.system_disk_type)
    error_message = "Possible values: SAS, SSD, GPSSD and ESSD"
  }
}

variable "system_disk_size" {
  description = "Specifies the system disk size in GB"
  type = number
  default = 50
  validation {
    condition = 1 <= var.system_disk_size && var.system_disk_size <= 512
    error_message = "Only between 1 and 512 GB"
  }
}

variable "data_disk" {
  description = "Specifies the ECS data disk"
  type = list(object({
    name = string
    type = string
    size = number
  }))
  default = []
}

variable "eip_enabled" {
  description = "Enabler for EIP"
  type = bool
  default = true
}

variable "admin_password" {
    description = "The password of the admin"
    type = string
    default = "Huawei@2025"
}

variable "key_pair" {
  description = "Specifies the SSH keypair"
  type = string
  nullable = false
}