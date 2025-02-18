
data "azurerm_app_service_plan" "main" {
  name                = "apps-service-plan"
  resource_group_name = "web-apps-plan"
}



resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-legal-provision"
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = data.azurerm_app_service_plan.main.id
  https_only          = true 
  tags =  var.tags

  site_config {
    windows_fx_version = "DOTNETCORE|6.0"
    dotnet_framework_version = "v5.0"
    http2_enabled            = "true"  
    websockets_enabled       = "true"
    ftps_state               = "Disabled"

    
    dynamic "ip_restriction" {
      for_each = var.ip_addresses_allow
      
      content {
        ip_address  = ip_restriction.value        
      }
    } 
    
    dynamic "scm_ip_restriction" {
      for_each = var.csm_addresses_allow
      
      content {
        ip_address  = scm_ip_restriction.value       
      }
    } 

  }
  

  
  app_settings  = {
    "uiCulture"                                     = "he-IL"
    "ASPNETCORE_ENVIRONMENT"                        = "Development"
    "Token__TokenIssuer"                            =  "https://sts.windows.net/${var.tenant_id}/"
    "WEBSITE_NODE_DEFAULT_VERSION"                  = "6.9.1"
    "ApplicationContext"                            = "Server=${var.sql_server_FQDN};Database=${var.prefix}-legal-db;uid=${var.username}${var.prefix};pwd=${var.db_pass};MultipleActiveResultSets=true;"
    "USER_PROVISIONING_AutorizationHeader"          = "Bearer ${var.scim_token}"  
    "USER_PROVISIONING_IssuerSigningKey"            = "1775EFEC32A2813FA967A7671236FG3R"
    "USER_PROVISIONING_TokenAudience"               = "8adf8e6e-67b2-4cf2-a259-e3dc5476c621"
    "USER_PROVISIONING_TokenIssuer"                 = "https://sts.windows.net/${var.tenant_id}/"
    "USER_PROVISIONING_TokenLifetimeInMins"         = "5684000"
    }

  


  connection_string {
    name  = "BoardDirectorConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${var.sql_server_FQDN},1433;Initial Catalog=BoarDirector;User ID=${var.username}${var.prefix};Password=${var.db_pass};"
  }
  
}





resource "azurerm_app_service" "second" {
  name                = "${var.prefix}-${var.applicationname}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = data.azurerm_app_service_plan.main.id
  https_only          = true 
  tags =  var.tags

  site_config {
    windows_fx_version = "DOTNETCORE|6.0"
    dotnet_framework_version = "v5.0"
    http2_enabled            = "true"  
    websockets_enabled       = "true"
    ftps_state               = "Disabled"
    
    dynamic "ip_restriction" {
      for_each = var.ip_addresses_allow
      
      content {
        ip_address  = ip_restriction.value        
      }
    } 
    
    dynamic "scm_ip_restriction" {
      for_each = var.csm_addresses_allow
      
      content {
        ip_address  = scm_ip_restriction.value       
      }
    } 

  }
  

  
  app_settings  = {
    "uiCulture"                                     = "he-IL"
    "HANGFIRE_CONNECTION_STRING"                    = "Server=${var.sql_server_FQDN};Database=${var.prefix}-legal-db;uid=${var.username}${var.prefix};pwd=${var.db_pass};MultipleActiveResultSets=true;"
    "Serilog:WriteTo:0:Name"                        = "MSSqlServer"
    "ApplicationContext"                            = "Server=${var.sql_server_FQDN};Database=${var.prefix}-legal-db;uid=${var.username}${var.prefix};pwd=${var.db_pass};MultipleActiveResultSets=true;"
    "ASPNETCORE_ENVIRONMENT"                        = "Prod"
    "AZURE_AUTHORITY"                               = "https://login.microsoftonline.com/${var.tenant_id}"
    "AZURE_BASE_ADDRESS"                            = "https://${var.application_url}/api"
    "AZURE_BLOB_STORAGE_ACCOUNT_KEY"                = var.storage_primery_connection_string
    "AZURE_BLOB_STORAGE_CONNECTION_STRING"          = var.storage_primery_connection_string
    "AZURE_CLIENT_ID"                               = var.ar_api_application_id
    "AZURE_TENANT_ID"                               = "${var.tenant_id}"
    "AzureAd__AppPermissions__Admin__0"             = "LegalEntities.Admin.All"
    "AzureAd__AppPermissions__Read__0"              = "LegalEntities.Read.All"
    "AzureAd__AppPermissions__Read__1"              = "LegalEntities.ReadWrite.All"
    "AzureAd__AppPermissions__Write__0"             = "LegalEntities.ReadWrite.All"
    "AzureAd__ClientId"                             =  var.ar_api_application_id
    "AzureAd__Instance"                             = "https://login.microsoftonline.com/"
    "AzureAd__Scopes__Admin__0"                     = "LegalEntities.Admin"
    "AzureAd__Scopes__Read__0"                      = "LegalEntities.Read"
    "AzureAd__Scopes__Read__1"                      = "LegalEntities.ReadWrite"
    "AzureAd__Scopes__Write__0"                     = "LegalEntities.ReadWrite"
    "AzureAd__TenantId"                             = "${var.tenant_id}"
    "CLIENT_SECRET"                                 = var.ar_api_password
    "GOOGLE_PlLACES_API_KEY"                        = "AIzaSyClfw_j_H1_WHZEOg4mKgDLmIw0D-_coOk"
    "LOGS_ACCESS_KEY"                               = "b7282785-4df7-4fc2-b56e-752c889dafec"
    "SCIM_SERVICE_AUTHORIZATION"                    = "${var.scim_token}"
    "SCIM_SERVICE_BASE_ADDRESS"                     = "https://${azurerm_app_service.main.default_site_hostname}"
    "Serilog__WriteTo__0__Args__connectionString"   = "Server=${var.sql_server_FQDN};Database=${var.prefix}-legal-db;uid=${var.username}${var.prefix};pwd=${var.db_pass};MultipleActiveResultSets=true;"
    "SWAGGER_AUTH_PASSWORD"                         = "g7!Qw8@E#r9&T5y"
    "SWAGGER_AUTH_USERNAME"                         = "Zigit$Amdocs_Swagger"
    "USER_PROVISIONING_AutorizationHeader"          = "Bearer ${var.scim_token}" 
    "USER_PROVISIONING_IssuerSigningKey"            = "1775EFEC32A2813FA967A7671236FG3R"
    "USER_PROVISIONING_TokenAudience"               = "8adf8e6e-67b2-4cf2-a259-e3dc5476c621"
    "USER_PROVISIONING_TokenIssuer"                 = "https://sts.windows.net/${var.tenant_id}/"
    "USER_PROVISIONING_TokenLifetimeInMins"         = "5684000"
    "VALID_AUDIENCE"                                = "api://${var.ar_users_application_id}/LegalEntities.ReadWrite"
    } 
    
  connection_string {
    name  = "BoardDirectorConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${var.sql_server_FQDN},1433;Initial Catalog=BoarDirector;User ID=${var.username}${var.prefix};Password=${var.db_pass};"
  }
  
}
