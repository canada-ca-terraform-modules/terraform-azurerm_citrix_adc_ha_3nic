resource azurerm_availability_set availabilityset {
  count                        = var.deploy ? 1 : 0
  name                         = "${local.vm-name}-as"
  location                     = var.location
  resource_group_name          = var.resource_group.name
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "3"
  managed                      = "true"
  tags                         = var.tags
}
