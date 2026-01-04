resource "azurerm_databricks_workspace" "dbw" {
  name                        = var.databricks_workspace_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku                         = "standard"
  managed_resource_group_name = "mrg-${var.databricks_workspace_name}"
}

output "workspace_url" {
  value = azurerm_databricks_workspace.dbw.workspace_url
}
