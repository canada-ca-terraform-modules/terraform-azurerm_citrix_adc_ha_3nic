resource "azurerm_resource_group" "test-RG" {
  name     = "test-${local.template_name}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "test-VNET" {
  name                = "test-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.test-RG.name
  address_space       = ["10.10.10.0/23"]
}
resource "azurerm_subnet" "mgmt" {
  name                 = "mgmt"
  virtual_network_name = azurerm_virtual_network.test-VNET.name
  resource_group_name  = azurerm_resource_group.test-RG.name
  address_prefixes     = ["10.10.10.0/27"]
}

resource "azurerm_subnet" "client" {
  name                 = "client"
  virtual_network_name = azurerm_virtual_network.test-VNET.name
  resource_group_name  = azurerm_resource_group.test-RG.name
  address_prefixes     = ["10.10.10.32/27"]
}

resource "azurerm_subnet" "server" {
  name                 = "server"
  virtual_network_name = azurerm_virtual_network.test-VNET.name
  resource_group_name  = azurerm_resource_group.test-RG.name
  address_prefixes     = ["10.10.10.64/27"]
}