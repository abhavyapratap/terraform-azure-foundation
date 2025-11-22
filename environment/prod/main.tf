module "rg" {
  source  = "../../modules/azurerm_rg"
  rg_info = var.rg_info
}

module "aks" {
  source                 = "../../modules/azurerm_aks"
  for_each               = var.aks_info
  aks_name               = each.value.aks_name
  location               = each.value.location
  resource_group_name    = each.value.resource_group_name
  dns_prefix             = each.value.dns_prefix
  default_node_pool_name = each.value.default_node_pool_name
  node_count             = each.value.node_count
  vm_size                = each.value.vm_size
  identity_type          = each.value.identity_type
}

module "acr" {
  source              = "../../modules/azurerm_acr"
  for_each            = var.acr_info
  acr_name            = each.value.acr_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
}