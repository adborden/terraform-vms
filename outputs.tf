output "ip_address" {
  value = libvirt_domain.ubuntu_bionic.network_interface.0.addresses
}
