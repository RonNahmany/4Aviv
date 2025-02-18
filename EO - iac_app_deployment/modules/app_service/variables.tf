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
variable "tenant_id" {
  type = string
}
variable "username" {
  type = string
}
variable "ar_api_application_id" {
  type = string
}
variable "sql_server_FQDN" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "rg_location" {
  type = string
}
variable "scim_token" {
  type = string
}
variable "db_pass" {
  type = string
  
}

variable "ar_api_password" {
  type = string
}

variable "storage_primery_connection_string" {
  type = string
}

variable "storage_primery_key" {
  type = string
}
variable "ar_users_application_id" {
  type = string
}
variable "tags" {
  description = "Tags to be applied to the resource"
  type = map(string)
}
variable "applicationname" {
  type = string
}