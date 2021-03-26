variable "memory" {
  default = 512
  description = "Amount of memory to provide for this virtual machine."
}

variable "name" {
  description = "Name of the virtual machine."
  type = string
}

variable "hostname" {
  description = "Hostname to provide to the virtual machine."
  default = ""
  type = string
}

variable "base_volume_image_id" {
  description = "Base volume Id to use for COW volume."
  type = string
}

variable "disk_size" {
  description = "Disk image size in GiB."
  default = 8
}

variable "disk_volume_pool" {
  description = "Volume Pool to create the volume in."
  default = "default"
}

variable "cloudinit_user_data" {
  description = "Cloudinit user-data to provide the virtual machine."
  type = string
}
