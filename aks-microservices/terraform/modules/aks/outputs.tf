output "aks_name" { 
    value = azurerm_kubernetes_cluster.aks.name 
    }

output "aks_uai_principal_id" {
  value = azurerm_user_assigned_identity.aks_uai.principal_id
}

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.aks.kube_config[0]
# }

output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
}
output "client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
}

