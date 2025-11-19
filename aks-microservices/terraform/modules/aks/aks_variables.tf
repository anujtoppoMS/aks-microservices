variable "acr_id" { 
    type = string 
    description = "acr id from the acr module"
    }

variable "keyvault_id" { 
    type = string 
    description = "azure keyvault id from the keyvault module"
    }

variable "subnet_ids" {
  type = map(string)
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "k8s_namespace" {
  type = string
}

variable "default_node_pool_temporary_name_for_rotation" {
  type        = string
  description = "Temporary node pool name used during rotation when updating default node pool properties"
  default     = null
}