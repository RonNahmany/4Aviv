resource "azurerm_storage_account" "main" {
  name                      = "${var.prefix}legalent8"
  resource_group_name       = var.rg_name
  location                  = var.rg_location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  
  network_rules {
        default_action      =  var.network_rules.default_action
        bypass              =  var.network_rules.bypass
        ip_rules            =  var.network_rules.ip_rules
                        
    }
  tags = var.tags
}

