resource "azurerm_databricks_workspace" "databricks" {
  name                = "${databricks_workspace_name}-test"
  resource_group_name = var.resource_group_name.name.databricks
  location            = var.location.location
  sku                 = "standard"

  tags = {
    Environment = var.environment
  }
}
