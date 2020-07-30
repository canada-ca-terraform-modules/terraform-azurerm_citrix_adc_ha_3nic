# This local is used to create a simple array with a single plan object if a plan is specified as an optional variable

locals {
  plan            = var.plan == null ? [] : [var.plan]
  boot_diagnostic = var.boot_diagnostic ? ["1"] : []
  unique          = substr(sha1(var.resource_group.id), 0, 8)
  fixname         = replace(var.name, "-", "")
  fixname2        = replace(local.fixname, "_", "")
  fixname3        = substr("${local.fixname2}diag", 0, 16)
  storageName     = lower("${local.fixname3}${local.unique}")
  eviction_policy = var.priority == "Regular" ? null : var.eviction_policy
  
  windows_virtual_machine_regex = "/[//\"'\\[\\]:|<>+=;,?*@&]/" # Can't include those characters in windows_virtual_machine name: \/"'[]:|<>+=;,?*@&
  env_4                         = substr(var.env, 0, 4)
  serverType_3                  = substr(var.serverType, 0, 3)
  userDefinedString_7           = substr(var.userDefinedString, 0, 7)
  prefix                        = replace("${local.env_4}${local.serverType_3}-${local.userDefinedString_7}", local.windows_virtual_machine_regex, "")
  vm-name                       = replace("${local.env_4}${local.serverType_3}-${local.userDefinedString_7}${local.postfix_3}", local.windows_virtual_machine_regex, "")
}
