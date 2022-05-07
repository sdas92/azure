# Sample Azure Terraform file

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "00c9b468-5a13-44d5-8dcc-403e8c2f87fe"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name      = "somnath-rg"
  location  = "eastus"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "somnath-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}


