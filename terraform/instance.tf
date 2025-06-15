data "huaweicloud_availability_zones" "zones" {
    region = var.region
}

data "huaweicloud_image" "linux_instance_image" {
  name = var.instance_image.name
  visibility = var.instance_image.visibility
  architecture = var.instance_image.architecture
  most_recent = var.instance_image.most_recent
  region = var.region
}

resource "huaweicloud_compute_instance" "linux" {
  name = local.name
  region = local.region
  image_id = var.image_id
  flavor_name = var.flavor_name
  key_pair = var.key_pair
  az = var.availability_zone
  system_disk_size = var.system_disk_size
  system_disk_type = var.system_disk_type

  network {
    UUID = var.subnet_id
  }

  dynamic "data_disk" {
    for_each = var.data_disk
    content {
        name = data_disk.value.name
        type = data_disk.value.type
        size = data_disk.value.size        
    }
    # Parei aqui, preciso ajustar esse "data_disk"
  }
}

