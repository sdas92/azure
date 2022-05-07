# Sample Azure Terraform file
# Author: Somnath Das


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "somnath-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.cidr_range[1]]
}

resource "azurerm_subnet" "subnet" {
  name                 = "private_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["20.0.0.0/28"]
}

resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.rg.location 
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


##
resource "azurerm_storage_account" "stg_acc" {
  name                     = "dasterraexmpl"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = lookup(var.location, "amer") #Another way to fetch value from a MAP
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

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
}
