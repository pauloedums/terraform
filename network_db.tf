resource "azurerm_public_ip" "publicip_aula" {
    name                         = "myPublicIP"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.rg_terraform_desafio.name
    allocation_method            = "Static"
    idle_timeout_in_minutes = 30

    tags = {
        environment = "aula infra"
    }

    depends_on = [ azurerm_resource_group.rg_terraform_desafio ]
}
resource "azurerm_public_ip" "publicip_aula_db" {
    name                         = "myPublicIPDB"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.rg_terraform_desafio.name
    allocation_method            = "Static"
    idle_timeout_in_minutes = 30

    tags = {
        environment = "aula infra"
    }

    depends_on = [ azurerm_resource_group.rg_terraform_desafio ]
}

resource "azurerm_network_interface" "nic_aula_db" {
    name                      = "myNICDB"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.rg_terraform_desafio.name

    ip_configuration {
        name                          = "myNicConfigurationDB"
        subnet_id                     = azurerm_subnet.subnet_aula.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.80.4.10"
        public_ip_address_id          = azurerm_public_ip.publicip_aula_db.id
    }

    tags = {
        environment = "aula infra"
    }

    depends_on = [ azurerm_resource_group.rg_terraform_desafio, azurerm_subnet.subnet_aula ]
}

resource "azurerm_network_interface_security_group_association" "nicsq_aula_db" {
    network_interface_id      = azurerm_network_interface.nic_aula_db.id
    network_security_group_id = azurerm_network_security_group.sg_aula.id

    depends_on = [ azurerm_network_interface.nic_aula_db, azurerm_network_security_group.sg_aula ]
}

data "azurerm_public_ip" "ip_aula_data_db" {
  name                = azurerm_public_ip.publicip_aula_db.name
  resource_group_name = azurerm_resource_group.rg_terraform_desafio.name
}