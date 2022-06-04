#Gives output from resources / data sources.
# Author: Somnath Das

output "private_ip" {
    value = {
        for nic in azurerm_network_interface.nics:
            nic.name => nic.private_ip_address
    }
}
