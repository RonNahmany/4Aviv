
module "addons" {
    source                              = "./modules/addons"
}

module "resource_group" {
  source                                = "./modules/resource-group"
  prefix                                = var.prefix
  depends_on                            = [ module.addons ]
  rg_prefix_name                        = var.rg_prefix_name

}

module "apps" {
    source                              = "./modules/apps"
    depends_on                          = [ module.resource_group ]
    application_url                     = var.application_url
    app_roles                           = var.app_roles
    required_resource_access            = var.required_resource_access
    required_resource_access_app1       = var.required_resource_access_app1
    prefix                              = var.prefix
    oauth2_permission_scopes            = var.oauth2_permission_scopes
    tags                                = var.tags

}

module "app_service" {
    source                              = "./modules/app_service"
    depends_on                          = [ module.addons, module.resource_group , module.sql, module.apps , module.storage ]
    scim_token                          = module.addons.scim_token
    db_pass                             = module.addons.db_pass
    ar_api_application_id               = module.apps.ar_api_app_id
    csm_addresses_allow                 = var.csm_addresses_allow
    ip_addresses_allow                  = var.ip_addresses_allow
    tenant_id                           = var.tenant_id
    prefix                              = var.prefix
    rg_name                             = module.resource_group.rg_name
    rg_location                         = module.resource_group.rg_location
    application_url                     = var.application_url
    sql_server_FQDN                     = module.sql.sql_server_FQDN
    username                            = var.username
    ar_api_password                     = module.apps.ar_api_password
    storage_primery_connection_string   = module.storage.storage_primery_connection_string
    storage_primery_key                 = module.storage.storage_primery_key
    ar_users_application_id             = module.apps.ar_users_application_id
    tags                                = var.tags
    applicationname                     = var.applicationname
}

module "vault" {
    source                  = "./modules/vault"
    depends_on              = [ module.apps , module.resource_group , module.addons ]
    tenant_id               = var.tenant_id
    application_url         = var.application_url
    ar_api_client_id        = module.apps.ar_api_client_id
    db_pass                 = module.addons.db_pass
    rg_location             = module.resource_group.rg_location
    ar_api_id               = module.apps.ar_api_id
    rg_name                 = module.resource_group.rg_name
    prefix                  = var.prefix
    rg_id                   = module.resource_group.rg_id
}
module "storage" {
    source                  = "./modules/storage"
    depends_on              = [ module.resource_group ]
    rg_location             = module.resource_group.rg_location
    rg_name                 = module.resource_group.rg_name
    prefix                  = var.prefix
    tags                    = var.tags
    network_rules           = var.network_rules
  
}

module "sql" {
  source        = "./modules/sql"
  depends_on    = [ module.resource_group ]
  rg_name       = module.resource_group.rg_name
  rg_location   = module.resource_group.rg_location
  prefix        = var.prefix
  username      = var.username
  db_pass       = module.addons.db_pass
}
