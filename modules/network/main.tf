locals {

  subnets = [for k, v in local.deployment.network : [
    for key, val in lookup(v, "subnets", []) :
    [
      merge(
              { 
                    resource = k
                    subnet_name    = key
                    service_endpoints = [
                      "Microsoft.KeyVault",
                      "Microsoft.Storage"
                    ],
                    delegation         = null
                    enable_nat_gateway = false 
              },
        val)
    ] #if !lookup(val,"type", false)  #[NOTE] create storage account if lookup is false
    ] if v.type == "virtual_network" && lookup(v, "subnets", []) != []
  ]
}

resource "azurerm_network_ddos_protection_plan" "resource" {
  for_each = {
    for k, v in local.deployment.network : k => v
    if v.type == "virtual_network" && lookup(v, "enable_ddos_protection_plan", false)
  }
  name                = format("%s-%s", each.key, "ddos")
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  
}

data "azurerm_network_ddos_protection_plan" "resource" {

  for_each = {
    for k, v in local.deployment.network : k => v
    if v.type == "virtual_network" && lookup(v, "enable_ddos_protection_plan", false)
  }
  name                = azurerm_network_ddos_protection_plan.resource[each.key].name
  resource_group_name = each.value.resource_group_name
}



resource "azurerm_virtual_network" "resource" {

  for_each = {
    for k, v in local.deployment.network : k => v
    if v.type == "virtual_network"
  }

  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  dns_servers         = lookup(each.value, "dns_servers", null)

  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "enable_ddos_protection_plan", false) == true ? [1] : []
    content {
      id     = data.azurerm_network_ddos_protection_plan.resource[each.key].id
      enable = true
    }
  }

  tags = merge(lookup(each.value, "tags", {}), var.tags)

}

data "azurerm_virtual_network" "resource" {
  for_each = {
    for k, v in local.deployment.network : k => v
    if v.type == "virtual_network"
  }

  name                = each.key
  resource_group_name = each.value.resource_group_name
  depends_on          = [azurerm_virtual_network.resource]
}

resource "azurerm_subnet" "resource" {
  for_each = { for entry in flatten(local.subnets) : "${entry.resource}-${entry.subnet_name}" => entry
    #   if upper(entry.type) == upper("azure_blob_storage") 
  }
  name                                           = each.value.subnet_name
  resource_group_name                            = data.azurerm_virtual_network.resource[each.value.resource].resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.resource[each.value.resource].name
  address_prefix                                 = each.value.address_prefix
  service_endpoints                              = each.value.service_endpoints
  enforce_private_link_endpoint_network_policies = lookup(each.value, "disable_network_policies", false)
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [1] : []
    content {
      name = each.value.delegation.name
      service_delegation {
        actions = each.value.delegation.service_delegation.actions
        name    = each.value.delegation.service_delegation.name
      }
    }
  }
  depends_on = [azurerm_virtual_network.resource]

}


data "azurerm_subnet" "resource" {
  for_each = { for entry in flatten(local.subnets) : "${entry.resource}-${entry.subnet_name}" => entry
    #   if upper(entry.type) == upper("azure_blob_storage") 
  }

  name                 = each.value.subnet_name
  resource_group_name  = data.azurerm_virtual_network.resource[each.value.resource].resource_group_name
  virtual_network_name = data.azurerm_virtual_network.resource[each.value.resource].name

  depends_on = [ azurerm_virtual_network.resource, azurerm_subnet.resource]
}





resource "azurerm_virtual_network_peering" "example-2" {
  name                      = "peer2to1"
  resource_group_name       = "rg-ava-ler-wus-dev-01"
  virtual_network_name      = "vnet-gx-eus-hub"
  #allow_virtual_network_access = false 
  remote_virtual_network_id = data.azurerm_virtual_network.resource["vnet-gx-eus-mgmt"].id
}

# resource "azurerm_virtual_network_peering" "example-1" {
#   name                      = "peer1to2"
#   resource_group_name       = azurerm_resource_group.example.name
#   virtual_network_name      = azurerm_virtual_network.example-1.name
#   remote_virtual_network_id = azurerm_virtual_network.example-2.id
# }