output "storage_primery_key" {
    value = azurerm_storage_account.main.primary_access_key
}
output "storage_primery_connection_string" {
    
    value = azurerm_storage_account.main.primary_connection_string
}