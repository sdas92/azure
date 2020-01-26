# Create a resource group
resource "azurerm_resource_group" "firstTGroup" {
  name     = "somnath-das-terraform"
  location = "West US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "firstTVnet" {
  name                = "production-network"
  resource_group_name = azurerm_resource_group.firstTGroup.name
  location            = azurerm_resource_group.firstTGroup.location
  address_space       = ["10.0.0.0/16"]
}

