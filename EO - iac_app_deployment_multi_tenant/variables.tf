variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string

}
variable "ip_addresses_allow" {
  type        = set(string)
}
variable "csm_addresses_allow" {
  type        = set(string)
}
variable "prefix" {
  type = string
}
variable "application_url" {
  type = string
}
variable "app_roles" {
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
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
}

variable "required_resource_access_app1" {
  type        = list(object({
    id   = string
    type = string
  }))
}
variable "oauth2_permission_scopes" {
  type        = list(object({
    admin_consent_description  = string
    admin_consent_display_name = string
    enabled                    = bool
    id                         = string
    type                       = string
    value                      = string
  }))
}
variable "username" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "network_rules" {
  type = object({
    default_action = string
    bypass         = list(string)
    ip_rules       = list(string)
  })
}
variable "client_secret" {
  type = string
}
variable "client_id" {
  type = string
}

variable "applicationname" {
  type = string
}
variable "rg_prefix_name" {
  type = string
}
variable "app_subscription_id" {
  type = string
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