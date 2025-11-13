resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  # Soft delete & purge protection are best practice
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  # RBAC vs Access Policies:
  # If you want RBAC, set `enable_rbac_authorization = true`
  # Otherwise, use access_policies below
  rbac_authorization_enabled   = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    
    # Example: restrict to VNETs/subnets if needed
    virtual_network_subnet_ids = var.subnet_ids
  }

  tags = {
    environment = var.environment
  }
}

# Allow AKS Managed Identity to access Key Vault (if not using RBAC)
# resource "azurerm_key_vault_access_policy" "aks_uai" {
#   count        = var.enable_access_policy ? 1 : 0
#   key_vault_id = azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = var.aks_uai_principal_id

#   secret_permissions = ["Get", "List"]
#   key_permissions    = ["Get", "List"]
#   certificate_permissions = ["Get", "List"]
# }