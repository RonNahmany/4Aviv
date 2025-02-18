resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.rg_prefix_name}"
  location = "${var.location}"
}