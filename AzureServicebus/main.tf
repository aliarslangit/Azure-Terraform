resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_servicebus_namespace" "demo" {
  name                = var.servicebusname
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  sku                 = "Standard"

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_servicebus_queue" "demo" {
  name                = "${var.servicebusname}_queue"
  resource_group_name = azurerm_resource_group.demo.name
  namespace_name      = azurerm_servicebus_namespace.demo.name
  enable_partitioning = false
}

resource "azurerm_servicebus_topic" "demo" {
  name                = "${var.servicebusname}_topic"
  resource_group_name = azurerm_resource_group.demo.name
  namespace_name      = azurerm_servicebus_namespace.demo.name
  enable_partitioning = false
}