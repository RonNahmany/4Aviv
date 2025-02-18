variable "rg_name" {
  type = string
}
variable "rg_location" {
  type = string
}
variable "network_rules" {
  description = "Network rules configuration for the resource"
  type = object({
    default_action = string
    bypass         = list(string)
    ip_rules       = list(string)
  })
}

variable "tags" {
  description = "Tags to be applied to the resource"
  type = map(string)
}

variable "prefix" {
  type = string
}