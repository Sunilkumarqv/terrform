resource "azurerm_databricks_workspace" "db" {
  name                = "${var.prefix}-databricks-ws"
  resource_group_name = var.resource_group_name.db.name
  location            = var.location.db.name
  sku                 = "premium"

  tags = {
    environment = var.environment
  }
}
