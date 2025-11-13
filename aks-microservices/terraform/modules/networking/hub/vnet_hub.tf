# Hub VNet
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub"
  address_space       = [var.hub_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}


# Peering: Hub -> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = var.spoke_vnet_id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
  use_remote_gateways       = false
}