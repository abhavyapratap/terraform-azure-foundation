data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "username" {
  name         = var.username_secret_key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "pwd" {
  name         = var.pwd_secret_key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}