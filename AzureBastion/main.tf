resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,

  }
}

resource "azurerm_virtual_network" "demo" {
  name                = "${var.bastionhostname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_subnet" "demo" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "demo" {
  name                = "${var.bastionhostname}-pubip"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  allocation_method   = "Static"
  sku                 = "Standard"
   
   tags = {
    Owner        = var.owner,
    Environment  = var.environment,

  }
}

resource "azurerm_bastion_host" "demo" {
  name                = var.bastionhostname
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                 = "Ip_Configuration"
    subnet_id            = azurerm_subnet.demo.id
    public_ip_address_id = azurerm_public_ip.demo.id
  }

 tags = {
    Owner        = var.owner,
    Environment  = var.environment,

  }
}