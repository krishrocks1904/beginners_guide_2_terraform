
resource "azurerm_storage_account" "example" {

  for_each = var.storage_account_config

  name = each.key
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             =  lookup(each.value,"account_tier", "Standard")
  account_replication_type = lookup(each.value,"account_replication_type", "GRS")

  tags = merge({Application = "DEMO"}, each.value.tags)
}
