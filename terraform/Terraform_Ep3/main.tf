# Sample Azure Terraform file
# Author: Somnath Das


# Get a virtual network within the resource group
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

#Get the subnet in the VNET
data "azurerm_subnet" "subnet" {
  name                 = "manual-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

#Create a new NIC using exiting manual VNET & Subnet
resource "azurerm_network_interface" "nic" {
  name                = "tf-nic"
  location            = data.azurerm_resource_group.rg.location 
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Deploy a sample Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "tf-vm"
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "S@nDb0x*2205"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

/*
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
}*/
