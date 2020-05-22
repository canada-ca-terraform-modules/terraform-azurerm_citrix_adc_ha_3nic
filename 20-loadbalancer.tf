resource "azurerm_lb" "loadbalancer" {
  name                = "${var.name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                          = "${var.name}-lbfe"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip
    subnet_id                     = data.azurerm_subnet.subnet2.id # Client
  }
}

resource "azurerm_lb_probe" "loadbalancer-TCP9000-lbhp" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "${var.name}-TCP9000-lbhp"
  port                = 9000
}

resource "azurerm_lb_backend_address_pool" "loadbalancer-VPXServers-lbbp" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "${var.name}-VPXServers-lbbp"
}

resource "azurerm_lb_rule" "loadbalancer-TCP443-lbr" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "${var.name}-TCP443-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${var.name}-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp.id
  probe_id                       = azurerm_lb_probe.loadbalancer-TCP9000-lbhp.id
  load_distribution              = "Default"
}

resource "azurerm_lb_rule" "loadbalancer-TCP80-lbr" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "${var.name}-TCP80-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.name}-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp.id
  probe_id                       = azurerm_lb_probe.loadbalancer-TCP9000-lbhp.id
  load_distribution              = "Default"
}
