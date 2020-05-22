/*
List of option related variables:

custom_data = "some custom shell code to execute. Eg: ${file("serverconfig/jumpbox-init.sh")}"

Those can be set optionally if you want to deploy with optional features
*/

variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
  description = "Tags that will be associated to VM resources"
  default = {
    "exampleTag1" = "SomeValue1"
    "exampleTag1" = "SomeValue2"
  }
}

variable "name" {
  description = "Name of the linux vm"
}

variable "nic1_subnetName" {
  description = "Name of the subnet to which the VM NIC1 will connect to"
}

variable "nic2_subnetName" {
  description = "Name of the subnet to which the VM NIC2 will connect to"
}

variable "nic3_subnetName" {
  description = "Name of the subnet to which the VM NIC3 will connect to"
}

variable "lb_private_ip" {
  description = "Private IP for the Citrix LB in subnet 1"
}

variable "nic_vnetName" {
  description = "Name of the VNET the subnet is part of"
}
variable "nic_resource_group_name" {
  description = "Name of the resourcegroup containing the VNET"
}
variable "dnsServers" {
  description = "List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list"
  default     = null
}
variable "nic_enable_ip_forwarding" {
  description = "Enables IP Forwarding on the NIC."
  default     = false
}
variable "nic_enable_accelerated_networking" {
  description = "Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported."
  default     = false
}
variable "nic1_ip_configuration" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address"
  default = {
    private_ip_address            = [null]
    private_ip_address_allocation = ["Dynamic"]
  }
}
variable "nic2_ip_configuration" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address"
  default = {
    private_ip_address            = [null]
    private_ip_address_allocation = ["Dynamic"]
  }
}
variable "nic3_ip_configuration" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address"
  default = {
    private_ip_address            = [null]
    private_ip_address_allocation = ["Dynamic"]
  }
}

variable "public_ip" {
  description = "Should the VM be assigned public IP(s). True or false."
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resourcegroup that will contain the VM resources"
}

variable "admin_username" {
  description = "Name of the VM admin account"
}

variable "admin_password" {
  description = "Password of the VM admin account"
  default     = null
}

variable "os_managed_disk_type" {
  default = "Standard_LRS"
}

variable "custom_data" {
  description = "Specifies custom data to supply to the machine. On Linux-based systems, this can be used as a cloud-init script. On other systems, this will be copied as a file on disk. Internally, Terraform will base64 encode this value before sending it to the API. The maximum length of the binary array is 65535 bytes."
  default     = null
}

variable "vm_size" {
  description = "Specifies the size of the Virtual Machine. Eg: Standard_F4"
}

variable "storage_image_reference" {
  description = "This block provisions the Virtual Machine from one of two sources: an Azure Platform Image (e.g. Ubuntu/Windows Server) or a Custom Image. Refer to https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for more details."
  default = {
    publisher = "citrix",
    offer     = "netscalervpx-130",
    sku       = "netscalerbyol",
    version   = "latest"
  }
}

variable "plan" {
  description = "An optional plan block"
  default     = {
    name      = "netscalerbyol"
    publisher = "citrix"
    product   = "netscalervpx-130"
  }
}

variable "storage_os_disk" {
  description = "This block describe the parameters for the OS disk. Refer to https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for more details."
  default = {
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = null
    disk_size_gb  = null
  }
}

variable "boot_diagnostic" {
  default = true
}

variable "priority" {
  description = "Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  default     = "Regular"
}

variable "eviction_policy" {
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. At this time the only supported value is Deallocate. Changing this forces a new resource to be created."
  default     = "Deallocate"
}
