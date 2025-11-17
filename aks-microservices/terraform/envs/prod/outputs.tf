# output "kube_config" {
#   value     = module.aks.kube_config[0]
#   sensitive = true
# }

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