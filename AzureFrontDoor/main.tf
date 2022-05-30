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

resource "azurerm_frontdoor_firewall_policy" "demo" {
  name                              = "demo"
  resource_group_name               = azurerm_resource_group.demo.name
  enabled                           = true
  mode                              = "Detection"
  custom_block_response_status_code = 403
  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
  
  /*
  custom_block_response_body takes in is a base 64 encoded string, hence this is the base 64 encoded string for 
  "blocked by frontdoor"

  Front door created using this script will only detect the custom_block_response_body as the firewall policy mode is set "Detection"
  */


  custom_block_response_body        = "YmxvY2tlZCBieSBmcm9udGRvb3I="

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }
}


resource "azurerm_frontdoor" "demo" {
  name                                         = var.fdname
  resource_group_name                          = azurerm_resource_group.demo.name
  enforce_backend_pools_certificate_name_check = false

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

  routing_rule {
    name               = "demoRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["demoFrontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "demoBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "demoLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "demoHealthProbeSetting1"
  }

  backend_pool {
    name = "demoBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "demoLoadBalancingSettings1"
    health_probe_name   = "demoHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "demoFrontendEndpoint1"
    host_name = "${var.fdname}.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.demo.id
  }

}