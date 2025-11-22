rg_info = {
  "rg-bhavya-aks-infra" = "centralindia"
}

aks_info = {
  "aks1" = {
    aks_name               = "bhavya-aks"
    location               = "centralindia"
    resource_group_name    = "rg-bhavya-aks-infra"
    dns_prefix             = "bhavyaksinfra"
    default_node_pool_name = "default"
    node_count             = 1
    vm_size                = "Standard_B2s"
    identity_type          = "SystemAssigned"
  }
}
