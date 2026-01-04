# Create a random name for the resource group using random_pet
# resource "random_pet" "rg_name" {
#   prefix = var.resource_group_name_prefix
# }
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  lower   = true
  special = false
}


# Create a resource group using the generated random name
resource "azurerm_resource_group" "rg" {
  location = var.location
  #name     = random_pet.rg_name.id
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
} 

# Storage Account (ADLS Gen2)
module "adls" {
  source              = "./modules/adls"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  storage_account_name = "adls${random_string.suffix.result}"
}
# Key Vault
module "key_vault" {
  source              = "./modules/key_vault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  keyvault_name       = "kv-${random_string.suffix.result}"
}


# Data Factory
module "data_factory" {
  source              = "./modules/data_factory"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  adf_name            = "adf-${random_string.suffix.result}"
}


# Databricks
module "databricks" {
  source                   = "./modules/databricks"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  databricks_workspace_name = "dbw-${random_string.suffix.result}"
}


