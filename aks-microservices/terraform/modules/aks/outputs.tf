output "aks_name" { 
    value = azurerm_kubernetes_cluster.aks.name 
    }

output "aks_uai_principal_id" {
  value = azurerm_user_assigned_identity.aks_uai.principal_id
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config
}
