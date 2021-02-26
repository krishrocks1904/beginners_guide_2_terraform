
resource "azurerm_resource_group" "resource_group_management" {
  for_each = { for k, v in local.management.resource_group : k => v
    if lookup(v, "lookup", true) == false
  }

  name     = each.key
  location = each.value.location
  tags     = merge(lookup(each.value, "tags", {}), local.management.tags)
}



#------------------------------------------------------
#----------------- This is a virtual network module 

#------------------------------------------------------


module "network" {
  source        = "../modules/network"
  
  #source       = "git::ssh://git@ssh.dev.azure.com/v3/ava-opscentre/CI - GX Application/Gx-Framework//src/modules/network"
  deployment  =local.deployment
  management  =local.management
  tags =  local.management.tags
  
  depends_on = [ azurerm_resource_group.resource_group_management ]
}


