
resource "azurerm_virtual_network" "example" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name      = var.resource_group_name
  location                 = var.location
  tags = var.tags
}