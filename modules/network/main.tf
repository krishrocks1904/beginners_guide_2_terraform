
resource "azurerm_network_ddos_protection_plan" "example" {
  name                = "ddospplan1"
 location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "example" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }

  subnet {
    name           = "web"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "service"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "data"
    address_prefix = "10.0.3.0/24"
    #security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}