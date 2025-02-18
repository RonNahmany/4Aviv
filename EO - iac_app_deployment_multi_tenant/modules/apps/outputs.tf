output "ar_api_id" {
  value = azuread_application.ar_api.id
}

output "ar_api_client_id" {
    value = azuread_application.ar_api.client_id
  
}

output "ar_api_password" {
  value = [for p in azuread_application.ar_api.password : p.value][0]
  
}

output "ar_api_app_id" {
  value = azuread_application.ar_api.client_id
}
output "ar_users_application_id" {
  value = azuread_application.ar_users.client_id
}