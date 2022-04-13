resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location

  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  sku                 = var.sku
  admin_enabled       = false

  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }

}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "demo" {

  name                = "${var.acrname}-laws"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    Owner       = var.owner,
    Environment = var.environment,
  }

}

# Diagnostic Settings

resource "azurerm_monitor_diagnostic_setting" "demo" {

  name                       = "${var.acrname}-diag"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.demo.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }

  }
  log {
    category = "ContainerRegistryRepositoryEvents"
    enabled  = true

    retention_policy {
      enabled = false
    }

  }
  log {
    category = "ContainerRegistryLoginEvents"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
