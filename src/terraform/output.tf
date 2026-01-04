output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "storage_account_name" {
  value = module.adls.storage_account_name
}

output "databricks_workspace_url" {
  value = module.databricks.workspace_url
}

output "data_factory_name" {
  value = module.data_factory.data_factory_name
}