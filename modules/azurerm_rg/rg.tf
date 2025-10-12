resource "azurerm_resource_group" "rg" {
  for_each = var.rg_info
  name     = each.key
  location = each.value
}