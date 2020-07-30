resource "azurerm_availability_set" "availabilityset" {
  name                = "${var.name}-as"
  location            = var.location
  resource_group_name = var.resource_group.name
  tags                = var.tags
}
