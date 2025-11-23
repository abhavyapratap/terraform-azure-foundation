rg_info = {
  "rg-bhavya" = "centralindia"
}

# stg_info = {
#   "stg1" = {
#     name                = "storagebhavyaqqqq"
#     resource_group_name = "rg-bhavya"
#     location            = "centralindia"
#   }

#   "stg2" = {
#     name                = "storagegamingqqqq"
#     resource_group_name = "rg-bhavya"
#     location            = "centralindia"
#   }
# }

# container_info = {
#   "container1" = {
#     name            = "bhavyacontainer"
#     storage_account = "stg1"
#   }

#   "container2" = {
#     name            = "bhavyacontainerq"
#     storage_account = "stg2"
#   }
# }

server_name = {
  "indian-server" = {
    location            = "centralindia"
    resource_group_name = "rg-bhavya"
    key                 = "keyvault2525"
    rg_name             = "rg-key-vault"
    username_secret_key = "database-username-secret-key"
    pwd_secret_key      = "database-pwd-secret-key"
  }
}

database_info = {
  "indian-database" = {
    server_name = "indian-server"
  }

  "russian-database" = {
    server_name = "indian-server"
  }
}

firewall_info = {
  "firewall-Rule-1" = {
    firewall_name = "Firewallrule"
    server_id     = "indian-server"
    vm_ip         = "pip2"
  }
}

vnet_info = {
  "vnet" = {
    location            = "centralindia"
    resource_group_name = "rg-bhavya"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet_info = {
  "subnet1" = {
    resource_group_name  = "rg-bhavya"
    virtual_network_name = "vnet"
    address_prefixes     = ["10.0.0.0/24"]
  }

  "subnet2" = {
    resource_group_name  = "rg-bhavya"
    virtual_network_name = "vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }

  # "AzureBastionSubnet" = {
  #   resource_group_name  = "rg-bhavya"
  #   virtual_network_name = "vnet"
  #   address_prefixes     = ["10.0.1.0/26"]
  # }
}

nic_info = {
  "nicforfrontend" = {
    location              = "centralindia"
    resource_group_name   = "rg-bhavya"
    ip_configuration_name = "configuration1"
    subnet_name           = "subnet1"
    public_ip              = "pip1"
  }

  "nicforbackend" = {
    location              = "centralindia"
    resource_group_name   = "rg-bhavya"
    ip_configuration_name = "configuration2"
    subnet_name           = "subnet2"
    public_ip              = "pip2"
  }
}

nsg_info = {
  "nsgforfrontend" = {
    location                = "centralindia"
    resource_group_name     = "rg-bhavya"
    security_rule_name      = "test"
    destination_port_ranges = ["22", "80"]
  }

  "nsgforbackend" = {
    location                = "centralindia"
    resource_group_name     = "rg-bhavya"
    security_rule_name      = "tes1"
    destination_port_ranges = ["22", "8000"]
  }
}

nsg_nic_association_info = {
  "association1" = {
    network_interface_name      = "nicforfrontend"
    network_security_group_name = "nsgforfrontend"
  }

  "association2" = {
    network_interface_name      = "nicforbackend"
    network_security_group_name = "nsgforbackend"
  }
}

vm_info = {
  "vmforfrontend" = {
    resource_group_name    = "rg-bhavya"
    location               = "centralindia"
    network_interface_name = "nicforfrontend"
    os_disk_name           = "frontend-disk"
    size                   = "Standard_B2s"
    publisher              = "Canonical"
    offer                  = "0001-com-ubuntu-server-jammy"
    sku                    = "22_04-lts"
    version                = "latest"
    key_vault_name         = "keyvault2525"
    rg_name                = "rg-key-vault"
    username_secret_key    = "frontend-username-secret-key"
    pwd_secret_key         = "frontend-pwd-secret-key"
    custom_data            = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOT
  }

  "vmforbackend" = {
    resource_group_name    = "rg-bhavya"
    location               = "centralindia"
    network_interface_name = "nicforbackend"
    os_disk_name           = "backend-disk"
    size                   = "Standard_B2s"
    publisher              = "Canonical"
    offer                  = "0001-com-ubuntu-server-focal"
    sku                    = "20_04-lts"
    version                = "latest"
    key_vault_name         = "keyvault2525"
    rg_name                = "rg-key-vault"
    username_secret_key    = "backend-username-secret-key"
    pwd_secret_key         = "backend-pwd-secret-key"
    custom_data            = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y python3 python3-pip python3-venv
  EOT
  }
}

pip_info = {
  "pip1" = {
    name                = "frontend-pip"
    resource_group_name = "rg-bhavya"
    location            = "centralindia"
    sku                 = "Standard"
  }

  "pip2" = {
    name                = "backend-pip"
    resource_group_name = "rg-bhavya"
    location            = "centralindia"
    sku                 = "Standard"
  }
}

# pip_info = {
#   "pipforbastion" = {
#     resource_group_name = "rg-bhavya"
#     location            = "centralindia"
#     sku                 = "Standard"
#   }
# }

# bastion_info = {
#   "jump-server" = {
#     location              = "centralindia"
#     resource_group_name   = "rg-bhavya"
#     ip_configuration_name = "configuration"
#     public_ip_name        = "pipforbastion"
#     subnet_name           = "AzureBastionSubnet"
#   }
# }
