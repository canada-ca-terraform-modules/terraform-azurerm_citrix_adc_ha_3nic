data "azurerm_subnet" "subnet1" {
  name                 = var.nic1_subnetName
  virtual_network_name = var.nic_vnetName
  resource_group_name  = var.nic_resource_group_name
}

data "azurerm_subnet" "subnet2" {
  name                 = var.nic2_subnetName
  virtual_network_name = var.nic_vnetName
  resource_group_name  = var.nic_resource_group_name
}

data "azurerm_subnet" "subnet3" {
  name                 = var.nic3_subnetName
  virtual_network_name = var.nic_vnetName
  resource_group_name  = var.nic_resource_group_name
}

data "azurerm_resource_group" "resourceGroup" {
  name       = var.resource_group_name
}
