# Create a resource group using the generated random name
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
} 

module "adls" {
  source                       = "./modules/adls"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  adls_storage_account_name    = var.adls_storage_account_name
  adls_container_name          = var.adls_container_name
}
