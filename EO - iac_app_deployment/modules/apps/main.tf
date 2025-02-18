data "azuread_client_config" "current" {}

resource "azuread_application" "ar_api" {
  display_name          = "${var.prefix}-legal-ent-api"
  sign_in_audience      = "AzureADMyOrg"
  
  
  password {
    display_name        = "${var.prefix}-secret"
    end_date            = "2228-01-01T01:02:03Z"            #200 years valid
  }

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2


    dynamic "oauth2_permission_scope" {
        for_each = var.oauth2_permission_scopes
        content {
          admin_consent_description     = oauth2_permission_scope.value.admin_consent_description
          admin_consent_display_name    = oauth2_permission_scope.value.admin_consent_display_name
          enabled                       = oauth2_permission_scope.value.enabled
          id                            = oauth2_permission_scope.value.id
          type                          = oauth2_permission_scope.value.type
          value                         = oauth2_permission_scope.value.value
        }
    }
  }

  dynamic "app_role" {
    for_each = var.app_roles
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = app_role.value.enabled
      id                   = app_role.value.id
      value                = app_role.value.value
    }
  }

  feature_tags {
    enterprise = true
    gallery    = false
  }

  optional_claims {
    access_token {
      name = "samlexample"
    }
  }

    dynamic "required_resource_access" {
        for_each            = var.required_resource_access
        content {
          resource_app_id   = required_resource_access.value.resource_app_id
        dynamic "resource_access"{
            for_each        = required_resource_access.value.resource_access
            content{
                id          = resource_access.value.id
                type        = resource_access.value.type
            }
        }
      
        }
    }

  single_page_application {
      redirect_uris = ["https://${var.application_url}/"]
      }
  

  web {
    homepage_url  = "https://${var.application_url}"
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }
  }
}

resource "azuread_application_identifier_uri" "ar_api" {
  application_id = azuread_application.ar_api.id
  identifier_uri = "api://${azuread_application.ar_api.client_id}"
}

resource "azuread_service_principal" "ar_api" {
  client_id                    = azuread_application.ar_api.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
  feature_tags {
    hide       = false
    gallery    = true
    enterprise = true
  }
}

resource "azuread_application_pre_authorized" "ar_api" {
  application_id       = azuread_application.ar_api.id
  authorized_client_id = azuread_application.ar_api.client_id

  permission_ids = [
    "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc",
    "96183846-204b-4b43-82e1-5d2222eb4b9b",
  ]
}
##############################################################################################
data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

##############################################################################################

resource "azuread_application" "ar_users" {
  display_name = "${var.prefix}-users"
  owners       = [data.azuread_client_config.current.object_id]
  template_id   = "8adf8e6e-67b2-4cf2-a259-e3dc5476c621"

  depends_on = [azuread_application.ar_api] 

  single_page_application {
    redirect_uris = ["https://${var.application_url}/"]
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = false
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.ar_api.client_id 

    resource_access {
      id   = "96183846-204b-4b43-82e1-5d2222eb4b9b" # ActivityFeed.Read
      type = "Scope"
    }
    
        resource_access {
      id   = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc" # ActivityFeed.Read
      type = "Scope"
    }
  }
  feature_tags {
    gallery     = false
    enterprise  = true
    hide        = false
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["email"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["offline_access"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["openid"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["profile"]
      type = "Scope"
    }
    resource_access {
      id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
      type = "Scope"
    }
  }
  
  
}







