output "kube_config" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_id" {
  value = module.acr.id
}

output "acr_name" {
  value = module.acr.name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "aks_app_client_id" {
  value     = module.aks.aks_app_client_id
}