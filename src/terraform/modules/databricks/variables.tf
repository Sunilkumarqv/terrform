variable "resource_group_name" {
  description = "The name of the resource group where the Databricks workspace will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region for the Databricks workspace"
  type        = string
}

variable "workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "environment" {
  description = "The environment tag (e.g. dev, test, prod)"
  type        = string
}
