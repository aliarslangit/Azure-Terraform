
resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location
  tags = {
    Owner        = var.owner,
    Environment  = var.Environment,
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
    Owner        = var.owner,
    Environment  = var.Environment,
  }
}
/*resource "azurerm_subnet" "test_subnet" {
  count                = length(var.subnets)
  name                 = lookup(element(var.subnets, count.index), "name")
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefix       = lookup(element(var.subnets, count.index), "ip")
}*/
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
    Owner        = var.owner,
    Environment  = var.Environment,
  }
}
/*resource "azurerm_subnet_network_security_group_association" "demo" {
  count                     = length(azurerm_subnet.test_subnet)
  subnet_id                 = lookup(element(azurerm_subnet.test_subnet, count.index), "id")
  network_security_group_id = azurerm_network_security_group.demo.id
}*/
resource "azurerm_subnet_network_security_group_association" "demo" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.demo.id
}
resource "azurerm_subnet_network_security_group_association" "demo1" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.demo.id
}

/*
resource "azurerm_subnet" "firewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefix       = "10.0.10.0/24"
}
resource "azurerm_public_ip" "firewallip" {
  name                = "testpip"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Name         = var.vnetname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BusinessUnit = var.Business_unit,
    Application  = var.Application,
  }
}

resource "azurerm_firewall" "firewall" {
  name                = "${var.vnetname}-firewall"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewallsubnet.id
    public_ip_address_id = azurerm_public_ip.firewallip.id
  }
  tags = {
    Name         = var.vnetname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BusinessUnit = var.Business_unit,
    Application  = var.Application,
  }
}
resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.demo.name
  priority            = 100
  action              = "Deny"

  rule {
    name = "testrule"

    source_addresses = [
      "0.0.0.0",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "0.0.0.0",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
*/
data "azurerm_monitor_diagnostic_categories" "demo" {
  resource_id = azurerm_virtual_network.demo.id
}
resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "Vnet diagnostic logs"
  target_resource_id         = azurerm_virtual_network.demo.id
  log_analytics_workspace_id = "/subscriptions/8e485c9b-6527-441b-a8c3-51058f8daf6e/resourceGroups/RG-demo-MONITOR/providers/Microsoft.OperationalInsights/workspaces/demo-log-analytics-workspace"
  log {
    category = "VMProtectionAlerts"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}

