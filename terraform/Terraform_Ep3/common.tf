# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Get an existing resource group
data "azurerm_resource_group" "rg" {
  name      = var.rg_name
}
