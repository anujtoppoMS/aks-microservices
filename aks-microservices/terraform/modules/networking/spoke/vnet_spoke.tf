# Spoke VNet
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "vnet-spoke"
  address_space       = [var.spoke_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# AKS subnet (spoke)
resource "azurerm_subnet" "spoke_aks_nodepool_subnet" {
  name                 = "snet-aks"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = [var.spoke_aks_node_cidr]
  service_endpoints = [
    "Microsoft.KeyVault"
  ]
}

# Optional: node pool subnet
# resource "azurerm_subnet" "spoke_aks_workernode" {
#   name                 = "snet-aks-nodes"
#   resource_group_name  = azurerm_resource_group.rg_vnet_spoke.name
#   virtual_network_name = azurerm_virtual_network.spoke.name
#   address_prefixes     = [var.spoke_workernode_cidr]
# }

# Peering: Spoke -> Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = var.hub_vnet_id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
  use_remote_gateways       = false
}