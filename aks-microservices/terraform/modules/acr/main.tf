# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "platformacr001"   # must be globally unique
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"          # Basic | Standard | Premium
  admin_enabled       = false              # best practice: disable admin creds

  # Optional: network rules for private access
  network_rule_set {
    default_action = "Deny"

    # ip_rule {
    #   action   = "Allow"
    #   ip_range = "203.0.113.0/24"
    # }
  }

  tags = {
    environment = "production"
    owner       = "platform-team"
  }
}