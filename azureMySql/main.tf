resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location
}
resource "azurerm_mysql_server" "demo" {
  name                = var.db_server
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  administrator_login          = var.username
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = var.db_size
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = {
    Owner       = var.owner,
    Environment = var.Environment
  }
}

resource "azurerm_mysql_database" "demo" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_server.demo.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

