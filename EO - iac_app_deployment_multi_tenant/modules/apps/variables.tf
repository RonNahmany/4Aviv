variable "prefix" {
  type = string
}
variable "oauth2_permission_scopes" {
  description = "List of OAuth2 permission scopes"
  type        = list(object({
    admin_consent_description  = string
    admin_consent_display_name = string
    enabled                    = bool
    id                         = string
    type                       = string
    value                      = string
  }))
}

variable "app_roles" {
  description = "List of application roles"
  type = list(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = bool
    id                   = string
    value                = string
  }))
}

variable "required_resource_access" {
  description = "List of required resource access configurations"
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
}

variable "application_url" {
  type = string
}


variable "required_resource_access_app1" {
  description = "List of resource access configurations for app1"
  type        = list(object({
    id   = string
    type = string
  }))
}

variable "tags" {
  type = map(string)
}

variable "app_tenant_id" {
  type = string 
}
variable "app_client_secret" {
  type = string
}
variable "app_client_id" {
  type = string
}