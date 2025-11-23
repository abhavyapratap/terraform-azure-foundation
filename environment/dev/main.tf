module "rg" {
  source  = "../../modules/azurerm_rg"
  rg_info = var.rg_info
}

# module "stg" {
#   for_each            = var.stg_info
#   depends_on          = [module.rg]
#   source              = "../../modules/azurerm_storage_account"
#   stg_info            = var.stg_info
#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location
# }

# module "container" {
#   for_each           = var.container_info
#   source             = "../../modules/azurerm_container"
#   container_name     = each.value.name
#   container_info     = var.container_info
#   storage_account_id = module.stg[each.value.storage_account].storage_account_id
# }

# output "container_ids" {
#   value = module.container
# }

module "server" {
  depends_on          = [module.rg]
  for_each            = var.server_name
  source              = "../../modules/azurerm_server"
  server_name         = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  key                 = each.value.key
  rg_name             = each.value.rg_name
  username_secret_key = each.value.username_secret_key
  pwd_secret_key      = each.value.pwd_secret_key
}

module "database" {
  depends_on    = [module.server]
  for_each      = var.database_info
  source        = "../../modules/azurerm_database"
  database_name = each.key
  server_id     = module.server[each.value.server_name].server_id
}

module "firewall" {
  depends_on = [ module.rg ]
  for_each = var.firewall_info
  source        = "../../modules/azurerm_mssql_firewall_rule"
  firewall_name = each.value.firewall_name
  server_id     = module.server[each.value.server_id].server_id
  vm_ip         = module.pip[each.value.vm_ip].backend_ip_address
}

# output "server_ids" {
#   value = module.server["indian-server"].server_id
# }

module "vnet" {
  depends_on          = [module.rg]
  for_each            = var.vnet_info
  source              = "../../modules/azurerm_vnet"
  vnet_name           = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}

module "subnet" {
  depends_on           = [module.vnet]
  for_each             = var.subnet_info
  source               = "../../modules/azurerm_subnet"
  subnet_name          = each.key
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

module "nic" {
  for_each              = var.nic_info
  source                = "../../modules/azurerm_nic"
  nic_name              = each.key
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  ip_configuration_name = each.value.ip_configuration_name
  subnet_id             = module.subnet[each.value.subnet_name].subnet_id
  public_ip = module.pip[each.value.public_ip].public_ip
}

module "nsg" {
  depends_on              = [module.rg]
  for_each                = var.nsg_info
  source                  = "../../modules/azurerm_nsg"
  nsg_name                = each.key
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  security_rule_name      = each.value.security_rule_name
  destination_port_ranges = each.value.destination_port_ranges
}

module "nsg_nic_association" {
  for_each                  = var.nsg_nic_association_info
  source                    = "../../modules/azurerm_nsg_nic_association"
  network_interface_id      = module.nic[each.value.network_interface_name].nic_id
  network_security_group_id = module.nsg[each.value.network_security_group_name].nsg_id
}

module "pip" {
  for_each            = var.pip_info
  depends_on          = [module.rg]
  source              = "../../modules/azurerm_public_ip"
  pip_name            = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
}

module "vm" {
  depends_on            = [module.rg]
  for_each              = var.vm_info
  source                = "../../modules/azurerm_VM"
  vm_name               = each.key
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  network_interface_ids = module.nic[each.value.network_interface_name].nic_id
  os_disk_name          = each.value.os_disk_name
  size                  = each.value.size
  publisher             = each.value.publisher
  offer                 = each.value.offer
  sku                   = each.value.sku
  version1              = each.value.version
  key_vault_name        = each.value.key_vault_name
  rg_name               = each.value.rg_name
  username_secret_key   = each.value.username_secret_key
  pwd_secret_key        = each.value.pwd_secret_key
  custom_data           = lookup(each.value, "custom_data", null)
}

# module "bastion" {
#   depends_on            = [module.subnet, module.pip]
#   for_each              = var.bastion_info
#   source                = "../../modules/azurerm_bastion"
#   bastion_name          = each.key
#   location              = each.value.location
#   resource_group_name   = each.value.resource_group_name
#   ip_configuration_name = each.value.ip_configuration_name
#   public_ip_address_id  = module.pip[each.value.public_ip_name].public_ip
#   subnet_id             = module.subnet[each.value.subnet_name].subnet_id
# }

# output "pip_ids" {
#   value = module.pip["pipforbastion"].public_ip
# }
