resource "azurerm_storage_account" "adls" {
  name                     = var.adls_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "bronze" {
  name                  = var.adls_container_name
  storage_account_id    = azurerm_storage_account.adls.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = var.adls_container_name_silver
  storage_account_id    = azurerm_storage_account.adls.id
  container_access_type = "private"
}
