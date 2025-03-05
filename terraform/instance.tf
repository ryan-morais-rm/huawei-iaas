data "huaweicloud_availability_zones" "myaz" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}

data "huaweicloud_images_image" "myimage" {
  name        = "Ubuntu 22.04 server 64bit"
  most_recent = true
}

resource "huaweicloud_compute_keypair" "mykey" {
  name       = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB/gCtHRyFvXwluywQDXu/yKNwcqwUkA/GO5IdT3HKOoQWQvUasm3XEYCfsifKVcdZdRywc5m21PytFb/FL7kFn/YVyaz0zfW0w+nkWqKxjNhIV5xRiDfzNFjpJGK+JHnpQOulONORl/psZQqEyqJvu71HLB5jMs9rp8aovG2EkbIfOx/VUUf8xNj886+1UKJlpOE4EJZ9i4hUf4Jb67sEONyBCp8WioUzRjvSLIlOhKGIceUnRTkYtQ6ZCtCHB68fBCBfH4r8nNP2WP5MXR4S9eGiO3VxuiYrtN+n3IkqSMMo3vNjATKvSKipxSLqL/5uWfFmgAmwqtN1liiChM8y7slyagNQ29aWB1t4W6+PicxMyp9TG9Uew0fVKcN0Lo37xqlwN1caQ4xaNlx80nn16dc4Q7PB/pgq1G6jM9CThMBciaxdBQXVvelGaFheyyeuc3zzFFpG9Yi+IS64inVW+B+KbOSs1yxGTPmdcmOp+9YWxMN2WMbchm+c5A4xTC3wnUDuP+4QvMHfrsKPER9a7X3ZOQU4LukVSJcX9UvIiolntClkoUmLwOTRCVR04LtZE4ZVoifCOeuh+/91WxDWFz/zYlMGiUu0d1hb4tWeiuqGdPaerrC5yttiUT86vplh+Q5ESd++f+/U/YRMzV/UGZGux0xReR0UrK8cO5bIKw== ryan-correia@vivobook"
}

resource "huaweicloud_compute_instance" "basic" {
  name            = "ubuntu"
  image_id        = data.huaweicloud_images_image.myimage.id
  flavor_id       = data.huaweicloud_compute_flavors.myflavor.ids[0]
  security_groups = ["secgroup"]

  # NOTE: admin_pass doesn't work with user_data, use key_pair instead.
  key_pair          = huaweicloud_compute_keypair.mykey.name
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  
  system_disk {
    volume_type = "SSD"  # 🔹 Tipo de disco do sistema
    size        = 40      # 🔹 Tamanho do disco do sistema (GB)
  } 
}

# 🔹 Criação do Volume EVS
resource "huaweicloud_evsebs_volume" "datavolume" {
  name        = "volume-dados"
  availability_zone = "az1"  # 🔹 Ajuste conforme a sua região
  volume_type = "SSD"  
  size        = 100  # 🔹 Tamanho do disco adicional (GB)
}

# 🔹 Anexa o volume EVS à instância
resource "huaweicloud_evsebs_volume_attachment" "datavolume_attachment" {
  instance_id = huaweicloud_compute_instance.myinstance.id
  volume_id   = huaweicloud_evsebs_volume.datavolume.id
}

# 🔹 Criação do Elastic IP (EIP)
resource "huaweicloud_vpc_eip" "eip" {
  publicip {
    type = "5_bgp"  # 🔹 Tipo de EIP (ajuste conforme necessário)
  }
  bandwidth {
    name        = "eip-bandwidth"
    size        = 10  # 🔹 Largura de banda (Mbps)
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# 🔹 Associa o EIP à instância
resource "huaweicloud_vpc_eip_associate" "eip_assoc" {
  public_ip    = huaweicloud_vpc_eip.eip.publicip[0].id
  instance_id  = huaweicloud_compute_instance.myinstance.id
}
