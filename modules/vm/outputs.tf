output "ip_address" {
  value = libvirt_domain.main.network_interface.0.addresses
}
