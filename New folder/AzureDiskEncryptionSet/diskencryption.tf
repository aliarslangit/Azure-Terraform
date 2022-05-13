data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_key_vault" "akv" {
  name                        = "des-example-kv123"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  #soft_delete_enabled         = true
  purge_protection_enabled = true
}

resource "azurerm_key_vault_key" "akvkey" {
  name         = "des-example-key"
  key_vault_id = azurerm_key_vault.akv.id
  key_type     = "RSA"
  key_size     = 2048

  depends_on = [
    azurerm_key_vault_access_policy.example-user
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "ade" {
  name                = "des"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  key_vault_key_id    = azurerm_key_vault_key.akvkey.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_access_policy" "example-disk" {
  key_vault_id = azurerm_key_vault.akv.id

  tenant_id = azurerm_disk_encryption_set.ade.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.ade.identity.0.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}

resource "azurerm_key_vault_access_policy" "example-user" {
  key_vault_id = azurerm_key_vault.akv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
    "create",
    "delete"
  ]
}