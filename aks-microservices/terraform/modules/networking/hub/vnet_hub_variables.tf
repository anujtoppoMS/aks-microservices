variable "hub_cidr" { 
    type = string  
    default = "10.1.0.0/16"
     }

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "spoke_vnet_id" {
  type = string
}