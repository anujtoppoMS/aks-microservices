output "aks_name" { 
    value = azurerm_kubernetes_cluster.aks.name 
    }

output "aks_uai_principal_id" {
  value = azurerm_user_assigned_identity.aks_uai.principal_id
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "aks_uai_client_id" {
  value = azurerm_user_assigned_identity.aks_uai.client_id
}

