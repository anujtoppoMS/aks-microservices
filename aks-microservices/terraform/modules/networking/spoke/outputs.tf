output "spoke_aks_subnet_id" {
  value = azurerm_subnet.spoke_aks_nodepool_subnet.id
}
output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke_vnet.id
}