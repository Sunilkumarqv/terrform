resource "azurerm_storage_account" "adls" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # ADLS Gen2
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "bronze" {
  name                  = var.container_name
  storage_account_id  = azurerm_storage_account.adls.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = var.container_name_silver
  storage_account_id  = azurerm_storage_account.adls.id
  container_access_type = "private"
}

