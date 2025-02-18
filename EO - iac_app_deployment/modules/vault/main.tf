data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                         = "${var.prefix}-legal-ent-vault"
  location                     = var.rg_location
  resource_group_name          = var.rg_name
  enabled_for_disk_encryption  = true
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled     = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id =  "08f2af7d-718a-4c7f-a9a7-0e52fa9f898e"

    secret_permissions = [
      "Get",
      "Recover",
      "Purge",
      "List",
      "Delete",
      "Set",
      
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id =  "d7d9c86d-b48f-4516-8003-e23ac23c1ab4"
    secret_permissions = [
      "Get",
      "Recover",
      "Purge",
      "List",
      "Delete",
      "Set",
      
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id =  "8e656b3c-612a-4c22-afe0-8e63ec3a57ef"

    secret_permissions = [
      "Get",
      "Recover",
      "Purge",
      "List",
      "Delete",
      "Set",
      
    ]
  }



  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Recover",
      "Purge",
      "List",
      "Delete",
      "Set",
    ]
  }
}



resource "azurerm_key_vault_secret" "second" {
  name         = "${var.prefix}-db-pass"
  value        = var.db_pass
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}





resource "azurerm_key_vault_secret" "AZURETENANTID" {
  name         = "${var.prefix}-AZURETENANTID"
  value        = "${var.tenant_id}"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}



resource "azurerm_key_vault_secret" "AZURECLIENTID" {
  name         = "${var.prefix}-AZURECLIENTID"
  value        = var.ar_api_client_id
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}



resource "azurerm_key_vault_secret" "AZUREAUTHORITY" {
  name         = "${var.prefix}-AZUREAUTHORITY"
  value        = "https://login.microsoftonline.com/${var.tenant_id}"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  

}

resource "azurerm_key_vault_secret" "APIURL" {
  name         = "${var.prefix}-APIURL"
  value        = "https://${var.application_url}/api"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}


resource "azurerm_key_vault_secret" "REDIRECTURI" {
  name         = "${var.prefix}-REDIRECTURI"
  value        = "https://${var.application_url}"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}

resource "azurerm_key_vault_secret" "AZUREAPICLIENTID" {
  name         = "${var.prefix}-AZUREAPICLIENTID"
  value        = var.ar_api_client_id
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}

resource "azurerm_key_vault_secret" "SCOPESREAD" {
  name         = "${var.prefix}-SCOPESREAD"
  value        = "api://${var.ar_api_client_id}/LegalEntities.Read"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  
}



resource "azurerm_key_vault_secret" "SCOPESWRITE" {
  name         = "${var.prefix}-SCOPESWRITE"
  value        = "api://${var.ar_api_client_id}/LegalEntities.ReadWrite"
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault.main] 
  

}