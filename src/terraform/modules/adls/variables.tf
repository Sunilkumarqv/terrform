variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account"
  type        = string
}

variable "environment" {
  description = "Environment tag value"
  type        = string
}

variable "container_name" {
  description = "Name of the ADLS container"
  type        = string
}
