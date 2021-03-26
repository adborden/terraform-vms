terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.6.3"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://vm@shift.lan/system"
}

#resource "libvirt_pool" "lvm" {
#  name = "virtpool"
#  type = "virtual"
#  path = "/dev/vg0"
#}

data "template_file" "user_data" {
  template = file("${path.module}/config/user-data.yml")
}

#data "template_file" "network_config" {
#  template = file("${path.module}/config/network_config.cfg")
#}

resource "libvirt_volume" "base_ubuntu_xenial" {
  name   = "ubuntu-base-xenial"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
  format = "qcow2"
}

resource "libvirt_volume" "base_ubuntu_bionic" {
  name   = "ubuntu-base-bionic"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "base_ubuntu_focal" {
  name   = "ubuntu-base-focal"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64-disk-kvm.img"
  format = "qcow2"
}

module "ubuntu_bionic" {
  source = "./modules/vm"

  name = "ubuntu-bionic"
  base_volume_image_id = libvirt_volume.base_ubuntu_bionic.id
  cloudinit_user_data = data.template_file.user_data.rendered
}
