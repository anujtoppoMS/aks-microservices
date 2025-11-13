# Log Analytics for AKS monitoring
# resource "azurerm_log_analytics_workspace" "law" {
#   name                = "law-aks-hubspoke"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# Managed Identity for AKS
resource "azurerm_user_assigned_identity" "aks_uai" {
  name                = "uai-aks"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# AKS cluster with system node pool
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-spoke"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-spoke"

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_uai.id]
  }

  default_node_pool {
    name                         = "sysnp"
    vm_size                      = "Standard_D2s_v3"
    node_count                   = 1
    auto_scaling_enabled         = true
    min_count                    = 1
    max_count                    = 3
    vnet_subnet_id               = var.subnet_ids["spoke_aks_subnet_id"]
    # only_critical_addons_enabled = true
    upgrade_settings {
      max_surge = "33%"
    }
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    # service_cidr       = "10.240.0.0/16"
    # dns_service_ip     = "10.240.0.10"
    # docker_bridge_cidr = "172.17.0.1/16"
  }

  # oms_agent {
  #   log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  # }
}

# resource "azurerm_kubernetes_cluster_node_pool" "usernp" {
#   name                  = "usernp"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   vm_size               = "Standard_D2s_v3"

#   # Autoscaling configuration
#   auto_scaling_enabled = true
#   min_count           = 1
#   max_count           = 3
#   # Subnet assignment
#   vnet_subnet_id = var.subnet_ids["spoke_aks_subnet_id"]
# }

# Role assignments for subnet permissions
# resource "azurerm_role_assignment" "aks_subnet_contributor" {
#   scope                = var.subnet_ids["spoke_aks_subnet_id"]
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_user_assigned_identity.aks_uai.principal_id
# }

# resource "azurerm_role_assignment" "aks_nodes_subnet_contributor" {
#   scope                = module.networking.spoke_nodes_subnet_id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_user_assigned_identity.aks_uai.principal_id
# }

# Assign multiple roles to the UAMI at subnet scope
locals {
  roles = [
    "Network Contributor",
    "User Access Administrator"
  ]
}

resource "azurerm_role_assignment" "uami_roles" {
  for_each            = toset(local.roles)
  scope               = var.subnet_ids["spoke_aks_subnet_id"]
  role_definition_name = each.key
  principal_id        = azurerm_user_assigned_identity.aks_uai.principal_id
}

# Attach ACR to AKS (role assignment)
# resource "azurerm_role_assignment" "aks_acr_pull" {
#   scope                = var.acr_id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_user_assigned_identity.aks_uai.principal_id
# }

# Allow AKS to access Key Vault
resource "azurerm_role_assignment" "aks_kv_secrets_user" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.aks_uai.principal_id
}

resource "azurerm_role_assignment" "acr_pull_sys" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}