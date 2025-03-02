resource "huaweicloud_vpc" "vpc" {
  name = "vpc-web-hcie"
  cidr = "192.168.0.0/16"
}

resource "huaweicloud_vpc_subnet" "subnet" {
  name       = "subnet-web-hcie"
  cidr       = "192.168.10.0/24"
  gateway_ip = "192.168.10.1"
  vpc_id     = huaweicloud_vpc.vpc.id
  dns_list   = ["100.125.1.250", "100.125.129.250"] 
}

resource "huaweicloud_networking_secgroup" "mysecgroup" {
  name                 = "secgroup"
  description          = "Grupo de segurança web"
  delete_default_rules = true
}

resource "huaweicloud_networking_secgroup_rule" "allow_ssh" {
  security_group_id = huaweicloud_networking_secgroup.mysecgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "test" {
  security_group_id = huaweicloud_networking_secgroup.mysecgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
}
