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

# create a datafactory instance in the resource group created above
resource "azurerm_data_factory" "example" {
  name                = "example-datafactory-${random_pet.rg_name.id}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# create a azure databricks workspace in the resource group created above
resource "azurerm_databricks_workspace" "example" {
  name                        = "example-databricks-${random_pet.rg_name.id}"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  sku                         = "standard"
  managed_resource_group_name = "example-managed-rg-${random_pet.rg_name.id}"
}