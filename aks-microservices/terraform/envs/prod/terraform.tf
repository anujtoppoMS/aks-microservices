terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.0.0"
      configuration_aliases = [helm.aks]
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">=2.0.0"
    # }
  }
  cloud {
    organization = "anujtoppo_terraform_state"
    workspaces {
      name = "Dev"
    }
  }
}
provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}