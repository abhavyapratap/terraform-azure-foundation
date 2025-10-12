resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.username.value
  administrator_login_password = data.azurerm_key_vault_secret.pwd.value
}

data "azurerm_key_vault" "key" {
  name                = var.key
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "username" {
  name         = var.username_secret_key
  key_vault_id = data.azurerm_key_vault.key.id
}

data "azurerm_key_vault_secret" "pwd" {
  name         = var.pwd_secret_key
  key_vault_id = data.azurerm_key_vault.key.id
}

output "server_id" {
  value = azurerm_mssql_server.server.id
}