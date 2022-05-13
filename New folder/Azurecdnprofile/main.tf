# Create Resource Group
resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.location

  tags = {
    Owner       = var.owner,
    Environment = var.environment,

  }
}

# Create Storage account with Static WebSite
resource "azurerm_storage_account" "demo" {
  name                     = var.st_name
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }

  tags = {
    Owner       = var.owner,
    Environment = var.environment,

  }
}

resource "azurerm_storage_blob" "demo" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.demo.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1>demo - CDN content </h1>"
}


# Create CDN Profile
resource "azurerm_cdn_profile" "demo" {
  name                = var.profilename
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  sku                 = "Standard_Verizon"

  tags = {
    Owner       = var.owner,
    Environment = var.environment,

  }
}

# Create CDN Endpoint

resource "azurerm_cdn_endpoint" "demo" {
  name                = "${var.profilename}-endpoint"
  profile_name        = azurerm_cdn_profile.demo.name
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  origin {
    name       = "demo"
    host_name  = azurerm_storage_account.demo.primary_web_host
    http_port  = "80"
    https_port = "443"
  }

  origin_host_header = azurerm_storage_account.demo.primary_web_host
}
