locals {
   environment_prefix = format("%s-%s-%s-%s-%s", var.company_name,var.project_name,lookup(local.locations,var.location,"none"), var.environment_name, var.environment_instance)

   locations ={
     eastus = "eus"
     westeurupe = "euw"
   }

   storge_properties = {
     account_tier             = "Standard"
     account_replication_type = "GRS"
   }
}

# Create a resource group
# this is azure resource group for demo
resource "azurerm_resource_group" "rg" {
  name     = format("%s-%s", "rg",local.environment_prefix)
  location = var.location
  tags = merge({Application = "DEMO"}, var.tags)
}

#------------------------------------------------------
#----------------- This is a virtual network module 

#------------------------------------------------------


module "network" {
  source = "../modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location =var.location
  network_name = format("%s-%s","vnet",local.environment_prefix)
  tags =var.tags
}


