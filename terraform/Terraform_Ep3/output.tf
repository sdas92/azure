#Gives output from resources / data sources.
# Author: Somnath Das

output "private_ip" {
    value = azurerm_network_interface.nic.private_ip_address
}
