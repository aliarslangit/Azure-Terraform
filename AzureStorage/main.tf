
resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_storage_account" "demo" {
  name                     = var.stname
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "demo" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.demo.name
  container_access_type = "private"

}

resource "azurerm_storage_blob" "demo" {
  name                   = var.blobname
  storage_account_name   = azurerm_storage_account.demo.name
  storage_container_name = azurerm_storage_container.demo.name
  type                   = "Block"
}


