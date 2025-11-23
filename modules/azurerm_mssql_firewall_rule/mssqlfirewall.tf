resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = var.firewall_name
  server_id        = var.server_id
  start_ip_address = var.vm_ip
  end_ip_address   = var.vm_ip
}