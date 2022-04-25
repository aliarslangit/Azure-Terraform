# Resource Group
resource "azurerm_resource_group" "rg" {

  name     = "rg-${var.system}"
  location = var.hub_location

  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }

}

#Create hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-${var.system}-hub"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name           = "hubsubnet"
    address_prefix = "10.10.0.0/24"
  }

  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }

}

#Create spoke Virtual Networks
resource "azurerm_virtual_network" "spoke_vnet" {
  count = var.spokes

  name                = "vnet-${var.system}-spoke${count.index}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name           = "spokesubnet${count.index}"
    address_prefix = "10.${count.index}.0.0/24"
  }

  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }

}


# Hub Network Peering
resource "azurerm_virtual_network_peering" "hub_peer" {
  for_each = { for v in azurerm_virtual_network.spoke_vnet : v.name => v.id }

  name                      = "peer-hub-to-${each.key}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = each.value
}

#Peering
resource "azurerm_virtual_network_peering" "spoke_peer" {
  for_each = { for v in azurerm_virtual_network.spoke_vnet : v.name => v.id }

  name                      = "peer-${each.key}-to-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = each.key
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}
