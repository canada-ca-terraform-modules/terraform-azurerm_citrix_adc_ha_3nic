resource "azurerm_storage_account" "boot_diagnostic" {
  count                    = var.boot_diagnostic ? 1 : 0
  name                     = local.storageName
  resource_group_name      = var.resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# MGMT
resource azurerm_network_interface NIC1-1 {
  name                          = "${var.name}1-nic1"
  depends_on                    = [var.nic1_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address            = var.nic1_ip_configuration.private_ip_address1
    private_ip_address_allocation = var.nic1_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

# Client
resource azurerm_network_interface NIC2-1 {
  name                          = "${var.name}1-nic2"
  depends_on                    = [var.nic2_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet2.id
    private_ip_address            = var.nic2_ip_configuration.private_ip_address1
    private_ip_address_allocation = var.nic2_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "NIC2-1" {
  network_interface_id    = azurerm_network_interface.NIC2-1.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp.id
}

# Server
resource azurerm_network_interface NIC3-1 {
  name                          = "${var.name}1-nic3"
  depends_on                    = [var.nic3_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet3.id
    private_ip_address            = var.nic3_ip_configuration.private_ip_address1
    private_ip_address_allocation = var.nic3_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

# MGMT
resource azurerm_network_interface NIC1-2 {
  name                          = "${var.name}2-nic1"
  depends_on                    = [var.nic1_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address            = var.nic1_ip_configuration.private_ip_address2
    private_ip_address_allocation = var.nic1_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

# Client
resource azurerm_network_interface NIC2-2 {
  name                          = "${var.name}2-nic2"
  depends_on                    = [var.nic2_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet2.id
    private_ip_address            = var.nic2_ip_configuration.private_ip_address2
    private_ip_address_allocation = var.nic2_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "NIC2-2" {
  network_interface_id    = azurerm_network_interface.NIC2-2.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp.id
}

# Server
resource azurerm_network_interface NIC3-2 {
  name                          = "${var.name}2-nic3"
  depends_on                    = [var.nic3_depends_on]
  location                      = var.location
  resource_group_name           = var.resource_group.name
  enable_ip_forwarding          = var.nic_enable_ip_forwarding
  enable_accelerated_networking = var.nic_enable_accelerated_networking
  dns_servers                   = var.dnsServers
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet3.id
    private_ip_address            = var.nic3_ip_configuration.private_ip_address2
    private_ip_address_allocation = var.nic3_ip_configuration.private_ip_address_allocation
    primary                       = true

  }
  tags = var.tags
}

resource azurerm_linux_virtual_machine VM1 {
  name                            = "${var.name}1"
  depends_on                      = [var.vm_depends_on]
  location                        = var.location
  resource_group_name             = var.resource_group.name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  computer_name                   = "${var.name}1"
  custom_data                     = var.custom_data
  size                            = var.vm_size
  priority                        = var.priority
  eviction_policy                 = local.eviction_policy
  network_interface_ids           = [azurerm_network_interface.NIC1-1.id, azurerm_network_interface.NIC2-1.id, azurerm_network_interface.NIC3-1.id]
  availability_set_id             = azurerm_availability_set.availabilityset.id
  source_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }
  dynamic "plan" {
    for_each = local.plan
    content {
      name      = local.plan[0].name
      product   = local.plan[0].product
      publisher = local.plan[0].publisher
    }
  }
  provision_vm_agent = true
  os_disk {
    name                 = "${var.name}1-osdisk1"
    caching              = var.storage_os_disk.caching
    storage_account_type = var.os_managed_disk_type
    disk_size_gb         = var.storage_os_disk.disk_size_gb
  }
  dynamic "boot_diagnostics" {
    for_each = local.boot_diagnostic
    content {
      storage_account_uri = azurerm_storage_account.boot_diagnostic[0].primary_blob_endpoint
    }
  }
  tags = var.tags
}

resource azurerm_linux_virtual_machine VM2 {
  name                            = "${var.name}2"
  depends_on                      = [var.vm_depends_on]
  location                        = var.location
  resource_group_name             = var.resource_group.name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  computer_name                   = "${var.name}2"
  custom_data                     = var.custom_data
  size                            = var.vm_size
  priority                        = var.priority
  eviction_policy                 = local.eviction_policy
  network_interface_ids           = [azurerm_network_interface.NIC1-2.id, azurerm_network_interface.NIC2-2.id, azurerm_network_interface.NIC3-2.id]
  availability_set_id             = azurerm_availability_set.availabilityset.id
  source_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }
  dynamic "plan" {
    for_each = local.plan
    content {
      name      = local.plan[0].name
      product   = local.plan[0].product
      publisher = local.plan[0].publisher
    }
  }
  provision_vm_agent = true
  os_disk {
    name                 = "${var.name}2-osdisk1"
    caching              = var.storage_os_disk.caching
    storage_account_type = var.os_managed_disk_type
    disk_size_gb         = var.storage_os_disk.disk_size_gb
  }
  dynamic "boot_diagnostics" {
    for_each = local.boot_diagnostic
    content {
      storage_account_uri = azurerm_storage_account.boot_diagnostic[0].primary_blob_endpoint
    }
  }
  tags = var.tags
}
