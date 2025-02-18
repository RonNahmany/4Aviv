resource "azurerm_mssql_server" "main" {
  name                         = "${var.prefix}-mssql-server"
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  administrator_login          = "${var.username}${var.prefix}"
  administrator_login_password = var.db_pass
}

resource "azurerm_sql_database" "main" {
  name                             = "${var.prefix}-legal-db"
  resource_group_name              = var.rg_name
  location                         = var.rg_location
  server_name                      = "${azurerm_mssql_server.main.name}"
  edition                          = "Standard"
  collation                        = "Hebrew_CI_AI"
  create_mode                      = "Default"
  requested_service_objective_name = "S0"
  max_size_bytes                   = 5368709120
  lifecycle {
    ignore_changes  = [ collation ]
    prevent_destroy = true
  }
}


resource "azurerm_sql_firewall_rule" "main" {
  depends_on = [ azurerm_mssql_server.main, azurerm_sql_database.main ]
  name                = "allow azure communication"
  resource_group_name = var.rg_name
  server_name         = azurerm_mssql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}



