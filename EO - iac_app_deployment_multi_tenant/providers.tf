terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.0"
    }
  }
}

# Azure AD Provider Configuration
provider "azuread" {
  tenant_id       = var.tenant_id
  client_secret   = var.client_secret
  client_id       = var.client_id
}

provider "azuread" {
  alias = "app_Config"
  tenant_id       = var.app_tenant_id
  client_secret   = var.app_client_secret
  client_id       = var.app_client_id
}



# Azure AD Client Configuration
data "azuread_client_config" "current" {}

# Azure RM Provider Configuration
provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_secret   = var.client_secret
  client_id       = var.client_id
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = false
    }
  }
}

# Random Provider Configuration
provider "random" {}
