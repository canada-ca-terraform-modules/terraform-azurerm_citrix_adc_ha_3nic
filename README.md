# Terraform Citrix ADC HA

## Introduction

This module deploys a Citrix ADC HA cluster with 3 NIC.

## Security Controls

The following security controls can be met through configuration of this template:

* AC-1, AC-10, AC-11, AC-11(1), AC-12, AC-14, AC-16, AC-17, AC-18, AC-18(4), AC-2 , AC-2(5), AC-20(1) , AC-20(3), AC-20(4), AC-24(1), AC-24(11), AC-3, AC-3 , AC-3(1), AC-3(3), AC-3(9), AC-4, AC-4(14), AC-6, AC-6, AC-6(1), AC-6(10), AC-6(11), AC-7, AC-8, AC-8, AC-9, AC-9(1), AI-16, AU-2, AU-3, AU-3(1), AU-3(2), AU-4, AU-5, AU-5(3), AU-8(1), AU-9, CM-10, CM-11(2), CM-2(2), CM-2(4), CM-3, CM-3(1), CM-3(6), CM-5(1), CM-6, CM-6, CM-7, CM-7, IA-1, IA-2, IA-3, IA-4(1), IA-4(4), IA-5, IA-5, IA-5(1), IA-5(13), IA-5(1c), IA-5(6), IA-5(7), IA-9, SC-10, SC-13, SC-15, SC-18(4), SC-2, SC-2, SC-23, SC-28, SC-30(5), SC-5, SC-7, SC-7(10), SC-7(16), SC-7(8), SC-8, SC-8(1), SC-8(4), SI-14, SI-2(1), SI-3

## Dependancies

Hard:

* Resource Groups
* VNET-Subnet

Optional (depending on options configured):

* log analytics workspace

## Usage

```terraform
module "SRV-SASCTXVPX" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm_citrix_adc?ref=20200522.1"
  name                    = "${var.env}SRV-SASCTXVPX"
  resource_group_name     = azurerm_resource_group.EBAP_SAS_VIYA_DMZ-rg.name
  location                = var.location
  admin_username          = var.vm_configs.SRV-SASCTXVPX.admin_username
  admin_password          = var.vm_configs.SRV-SASCTXVPX.admin_password
  nic1_subnetName         = data.azurerm_subnet.EBAP_RZ-snet.name                  # MGMT
  nic2_subnetName         = data.azurerm_subnet.EBAP_PAZ-snet.name                 # Client
  nic3_subnetName         = data.azurerm_subnet.EBAP_OZ-snet.name                  # Server
  nic_vnetName            = data.azurerm_subnet.EBAP_PAZ-snet.virtual_network_name # same name for all 3 subnets
  nic_resource_group_name = data.azurerm_subnet.EBAP_PAZ-snet.resource_group_name  # same name for all 3 subnets
  nic1_ip_configuration = {
    private_ip_address1           = local.SRV-SASCTXVPX1-RZ
    private_ip_address2           = local.SRV-SASCTXVPX2-RZ
    private_ip_address_allocation = "Static"
  }
  nic2_ip_configuration = {
    private_ip_address1           = local.SRV-SASCTXVPX1-PAZ
    private_ip_address2           = local.SRV-SASCTXVPX2-PAZ
    private_ip_address_allocation = "Static"
  }
  nic3_ip_configuration = {
    private_ip_address1           = local.SRV-SASCTXVPX1-OZ
    private_ip_address2           = local.SRV-SASCTXVPX2-OZ
    private_ip_address_allocation = "Static"
  }
  lb_private_ip = local.SRV-SASCTXVPXLB
  vm_size       = var.vm_configs.SRV-SASCTXVPX.vm_size
  tags          = var.tags
}
```


## Variables Values

| Name                                    | Type   | Required | Value                                                                                                                                                                                                       |
| --------------------------------------- | ------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| name                                    | string | yes      | Name of the vm                                                                                                                                                                                              |
| resource_group_name                     | string | yes      | Name of the resourcegroup that will contain the VM resources                                                                                                                                                |
| admin_username                          | string | yes      | Name of the VM admin account                                                                                                                                                                                |
| admin_password                          | string | yes      | Password of the VM admin account                                                                                                                                                                            |
| nic1_subnetName                          | string | yes      | Name of the subnet to which the MGMT NIC will connect to                                                                                                                                                      |
| nic2_subnetName                          | string | yes      | Name of the subnet to which the Client NIC will connect to                                                                                                                                                      |
| nic3_subnetName                          | string | yes      | Name of the subnet to which the Server NIC will connect to                                                                                                                                                      |
| nic_vnetName                            | string | yes      | Name of the VNET the subnet1,2 & 3 are part of                                                                                                                                                                      |
| nic_resource_group_name                 | string | yes      | Name of the resourcegroup containing the VNET                                                                                                                                                               |
| vm_size                                 | string | yes      | Specifies the desired size of the Virtual Machines. Eg: Standard_F4                                                                                                                                          |
| location                                | string | no       | Azure location for resources. Default: canadacentral                                                                                                                                                        |
| tags                                    | object | no       | Object containing a tag values - [tags pairs](#tag-object)                                                                                                                                                  |
| os_managed_disk_type                    | string | no       | Specifies the type of OS Managed Disk which should be created. Possible values are Standard_LRS or Premium_LRS. Default: Standard_LRS                                                                       |
| dnsServers                              | list   | no       | List of DNS servers IP addresses as string to use for this NIC, overrides the VNet-level dns server list - [dns servers](#dns-servers-list)                                                                 |
| nic_enable_ip_forwarding                | bool   | no       | Enables IP Forwarding on the NIC. Default: false                                                                                                                                                            |
| nic_enable_accelerated_networkingg      | bool   | no       | Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Default: false                                                                                             |
| nic1_ip_configuration                    | object | no       | Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address. Default: Dynamic - [ip configuration](#ip-configuration-object) |
| nic2_ip_configuration                    | object | no       | Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address. Default: Dynamic - [ip configuration](#ip-configuration-object) |
| nic3_ip_configuration                    | object | no       | Defines how a private IP address is assigned. Options are Static or Dynamic. In case of Static also specifiy the desired privat IP address. Default: Dynamic - [ip configuration](#ip-configuration-object) |
| public_ip                               | bool   | no       | Does the Cluster require a public IP. true or false. Default: false                                                                                                                                              |
| storage_image_reference                 | object | no       | Specify the storage image used to create the VM. Default is 2016-Datacenter. - [storage image](#storage-image-reference-object)                                                                             |
| plan                                    | object | no       | Specify the plan used to create the VM. Default is null. - [plan](#plan-object)                                                                                                                             |
| storage_os_disk                         | object | no       | Storage OS Disk configuration. Default: ReadWrite from image.                                                                                                                                               |
| boot_diagnostic                         | bool   | no       | Should a boot be turned on or not. Default: false                                                                                                                                                           |

### tag object

Example tag variable:

```hcl
tags = {
  "tag1name" = "somevalue"
  "tag2name" = "someothervalue"
  .
  .
  .
  "tagXname" = "some other value"
}
```

### dns servers list

Example dnsServers variable. The following example would configure 2 dns servers:

```hcl
dnsServers = ["10.20.30.40","10.20.30.41]
```

### ip configuration object

| Name                          | Type | Required | Value                                                                                                                                                           |
| ----------------------------- | ---- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| private_ip_address1            | list | yes      | Static IP desired for the 1st VM of the cluster. Set eto null if using Dynamic allocation or to a static IP part of the subnet is using Static |
| private_ip_address2            | list | yes      | Static IP desired for the 2nd VM of the cluster. Set eto null if using Dynamic allocation or to a static IP part of the subnet is using Static |
| private_ip_address_allocation | list | yes      | IP allocation type for the ip configuration. Set to either Dynamic or Static                                                                      |
Default:

```hcl
nic_ip_configuration = {
  private_ip_address1            = [null]
  private_ip_address2            = [null]
  private_ip_address_allocation = ["Dynamic"]
}
```

Example variable for a NIC with 2 staticly assigned IP and one dynamic:

```hcl
nic1_ip_configuration = {
    private_ip_address1           = local.SRV-SASCTXVPX1-RZ
    private_ip_address2           = local.SRV-SASCTXVPX2-RZ
    private_ip_address_allocation = "Static"
  }
```

### storage image reference object

| Name      | Type       | Required           | Value                                                                                              |
| --------- | ---------- | ------------------ | -------------------------------------------------------------------------------------------------- |
| publisher | string     | yes                | The image publisher.                                                                               |
| offer     | string     | yes                | Specifies the offer of the platform image or marketplace image used to create the virtual machine. |
| sku       | string     | yes                | The image SKU.                                                                                     |
| version   | string yes | The image version. |

Example variable:

```hcl
storage_image_reference = {
  publisher = "RedHat"
  offer     = "RHEL"
  sku       = "7.4"
  version   = "latest"
}
```

### plan object

| Name      | Type   | Required | Value               |
| --------- | ------ | -------- | ------------------- |
| name      | string | yes      | The plan nome.      |
| publisher | string | yes      | The publisher name. |
| product   | string | yes      | The product name.   |

Example variable:

```hcl
plan = {
    name      = "fortinet-fortimanager"
    publisher = "fortinet"
    product   = "fortinet-fortimanager"
}
```

## History

| Date     | Release    | Change                                                                                       |
| -------- | ---------- | -------------------------------------------------------------------------------------------- |
| 20200506 | 20200506.1 | 1st commit              |

