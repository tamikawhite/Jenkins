output "public_ip_addresses" {
  value = azurerm_linux_virtual_machine.jenkins.public_ip_address
}