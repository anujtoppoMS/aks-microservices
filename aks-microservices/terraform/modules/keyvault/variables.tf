variable "kv_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "environment" {
  type        = string
  default     = "dev"
}

# variable "aks_uai_principal_id" {
#   type        = string
#   description = "Principal ID of AKS User Assigned Identity"
# }

variable "enable_access_policy" {
  type    = bool
  default = false
}

variable "tenant_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}