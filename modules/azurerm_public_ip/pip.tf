resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = var.sku
}

output "public_ip" {
  value = azurerm_public_ip.pip.id
}

output "backend_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}