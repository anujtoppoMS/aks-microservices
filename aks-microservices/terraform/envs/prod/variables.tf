variable "resource_groups" {
  default = {
    rg_hub               = { location = "eastus" }
    rg_aks_spoke         = { location = "eastus" }
    rg_acr               = { location = "eastus" }
    rg_keyvault          = { location = "eastus" }
    rg_aks_microservices = { location = "eastus" }
  }
}

variable "subscription_id" {
  type    = string
  default = "6c5ab08a-38e2-49b5-a0f0-b7c78bbbea6d"
}