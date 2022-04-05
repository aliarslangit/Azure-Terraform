
resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location
  tags = {
    Owner       = var.owner,
    Environment = var.Environment,
  }
}

resource "azurerm_virtual_network" "demo" {
  name                = var.vnetname
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  address_space       = [var.cidr]

  ddos_protection_plan {
    id     = "/subscriptions/8e485c9b-6527-441b-a8c3-51058f8daf6e/resourcegroups/RG-demo-MONITOR/providers/Microsoft.Network/ddosProtectionPlans/demo-DDos"
    enable = true
  }
  tags = {
    Owner       = var.owner,
    Environment = var.Environment,
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefix       = var.subnet1ip
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefix       = var.subnet2ip
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_network_security_group" "demo" {
  name                = "${var.vnetname}-nsg"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  tags = {
    Owner       = var.owner,
    Environment = var.Environment,
  }
}

resource "azurerm_subnet_network_security_group_association" "demo" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.demo.id
}
resource "azurerm_subnet_network_security_group_association" "demo1" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.demo.id
}


