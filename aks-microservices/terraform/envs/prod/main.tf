
module "rg" {
  source   = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/resource_group?ref=main"
  for_each = var.resource_groups

  rg_name  = each.key
  location = each.value.location
}


#networking hub
module "hub" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/networking/hub?ref=main"
  resource_group_name = module.rg["rg_hub"].name
  location            = module.rg["rg_hub"].location
  spoke_vnet_id       = module.spoke.spoke_vnet_id
}

#networking aks spoke
module "spoke" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/networking/spoke?ref=main"
  resource_group_name = module.rg["rg_aks_spoke"].name
  location            = module.rg["rg_aks_spoke"].location
  hub_vnet_id         = module.hub.hub_vnet_id
}

# ACR attached to the AKS
module "acr" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/acr?ref=main"
  resource_group_name = module.rg["rg_acr"].name
  location            = module.rg["rg_acr"].location
  acr_name            = "peerisland-asses-acr"
}

#keyvault block
data "azurerm_client_config" "current" {}

module "keyvault" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/keyvault?ref=144a19375de6c0d2ba187257fea9e3f2530cc736"
  resource_group_name = module.rg["rg_keyvault"].name
  location            = module.rg["rg_keyvault"].location
  kv_name             = "peerisland-asses-kv"
  environment         = "Prod"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subnet_ids          = [module.spoke.spoke_aks_subnet_id]

}

#aks module
module "aks" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/aks?ref=144a19375de6c0d2ba187257fea9e3f2530cc736"
  resource_group_name = module.rg["rg_aks_microservices"].name
  location            = module.rg["rg_aks_microservices"].location
  k8s_namespace       = "micro-app"
  subnet_ids = {
    spoke_aks_subnet_id = module.spoke.spoke_aks_subnet_id
  }
  acr_id      = module.acr.id
  keyvault_id = module.keyvault.id
}

data "azurerm_kubernetes_cluster" "aks-spoke" {
  name                = "aks-spoke"
  resource_group_name = module.rg["rg_aks_microservices"].name
}

provider "helm" {
  kubernetes = {
      host                   = data.azurerm_kubernetes_cluster.aks-spoke[0].host
      client_certificate     = data.azurerm_kubernetes_cluster.aks-spoke[0].client_certificate
      client_key             = data.azurerm_kubernetes_cluster.aks-spoke[0].client_key
      cluster_ca_certificate = data.azurerm_kubernetes_cluster.aks-spoke[0].cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks-spoke[0].host
  client_certificate     = data.azurerm_kubernetes_cluster.aks-spoke[0].client_certificate
  client_key             = data.azurerm_kubernetes_cluster.aks-spoke[0].client_key
  cluster_ca_certificate = data.azurerm_kubernetes_cluster.aks-spoke[0].cluster_ca_certificate
}

module "secretprovider" {
  source            = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/secretprovider?ref=main"
  azure_tenant_id   = data.azurerm_client_config.current.tenant_id
  aks_uai_client_id = module.aks.aks_uai_client_id
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}