resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = var.storage_account_id
  container_access_type = "private"
}

output "container_id" {
  value = azurerm_storage_container.container.id
}