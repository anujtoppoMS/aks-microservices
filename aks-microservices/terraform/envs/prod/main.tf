
module "rg" {
  source   = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/resource_group?ref=main"
  for_each = var.resource_groups

  name     = each.key
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
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/keyvault?ref=main"
  resource_group_name = module.rg["rg_keyvault"].name
  location            = module.rg["rg_keyvault"].location
  kv_name             = "peerisland-asses-kv"
  environment         = "Prod"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subnet_ids          = [module.spoke.spoke_aks_subnet_id]

}

#aks module
module "aks" {
  source              = "git::https://github.com/anujtoppoMS/aks-microservices.git//aks-microservices/terraform/modules/aks?ref=main"
  resource_group_name = module.rg["rg_aks_microservices"].name
  location            = module.rg["rg_aks_microservices"].location
  subnet_ids = {
    spoke_aks_subnet_id = module.spoke.spoke_aks_subnet_id
  }
  acr_id      = module.acr.id
  keyvault_id = module.keyvault.id
}