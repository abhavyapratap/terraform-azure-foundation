resource "azurerm_storage_account" "stg" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

output "storage_account_id" {
  description = "The ID of the Azure Storage Account."
  value       = azurerm_storage_account.stg.id
}