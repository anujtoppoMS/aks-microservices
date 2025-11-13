variable "spoke_cidr" { 
    type = string  
    default = "10.2.0.0/16"
     }

variable "spoke_aks_node_cidr" { 
    type = string  
    default = "10.2.1.0/24"
     }

# variable "spoke_workernode_cidr" { 
#     type = string  
#     default = "10.2.2.0/24"
#      }

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "hub_vnet_id" {
  type = string
}