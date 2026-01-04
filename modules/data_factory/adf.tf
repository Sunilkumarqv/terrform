resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

output "data_factory_name" {
  value = azurerm_data_factory.adf.name
}
