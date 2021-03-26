terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.6.3"
    }
  }
}

resource "libvirt_cloudinit_disk" "main" {
  name      = "${var.name}-cloudinit.iso"
  user_data = var.cloudinit_user_data
  #network_config = data.template_file.network_config.rendered
  pool = "default"
}

resource "libvirt_volume" "main" {
  name           = var.name
  base_volume_id = var.base_volume_image_id
  pool           = var.disk_volume_pool
  size           = var.disk_size * 1024
}

resource "libvirt_domain" "main" {
  name   = var.name
  memory = var.memory
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.main.id

  network_interface {
    network_name = "default"
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.main.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
