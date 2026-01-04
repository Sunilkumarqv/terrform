# Create a resource group using the generated random name
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
} 

module "adls" {
  source                = "./modules/adls"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  storage_account_name  = var.storage_account_name
  container_name        = var.container_name
  environment           = var.environment
}

 resource "azurerm_databricks_workspace" "databricks" {
  name                        = var.databricks_workspace_name
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = "standard"
  managed_resource_group_name = "${var.databricks_workspace_name}-managed-rg"
 }