output "storage_account_id" {
  description = "Storage Account resource ID"
  value       = azurerm_storage_account.adls.id
}

output "storage_account_primary_endpoint" {
  description = "Primary Blob endpoint"
  value       = azurerm_storage_account.adls.primary_blob_endpoint
}
