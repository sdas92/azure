# Sample Azure Terraform file
# Author: Somnath Das


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  count               = length(var.cidr_range)
  name                = format("%s%s", "vnet-", (count.index+1))
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.cidr_range[count.index]]
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_map
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [each.value]
}

resource "azurerm_network_interface" "nics" {
  for_each = {for nic in var.nic_list: nic.nic_name => nic}
  name                = each.value.nic_name
  location            = azurerm_resource_group.rg.location 
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet["app_sub"].id
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.nic_ip
  }
}


##
resource "azurerm_storage_account" "stg_acc" {
  count                    = var.strage_check == "create" ? 1 : 0
  name                     = "daslearning22"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = lookup(var.location, "amer") #Another way to fetch value from a MAP
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

/*
resource "azurerm_storage_container" "container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.stg_acc.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.stg_acc.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "index.html"
}*/
