Terraform: Azure Resource Group + Data Factory + Databricks 🚀
Short description: This Terraform configuration creates an Azure Resource Group (name generated with random_pet) and provisions an Azure Data Factory and Azure Databricks workspace inside it.

📋 Table of contents
Prerequisites 🔧
Quick start ⚡
Files & structure 📁
Variables 🔢
Outputs 📤
Example usage 💡
Notes & best practices ⚠️
Contributing & License 

 Prerequisites
Terraform (recommended >= 1.0)
Azure CLI or service principal credentials:
Run az login (interactive) OR set env vars: ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID.
Required providers:
hashicorp/azurerm ~>4.0
hashicorp/random ~>3.0
Note: This configuration uses the azurerm provider and random to create unique resource names.

 Quick start
Authenticate with Azure:
az login OR set service principal env vars.
Initialize Terraform:
terraform init
Preview changes:
terraform plan -out=plan.tfplan
Apply:
terraform apply plan.tfplan
Destroy (when needed):
terraform destroy


📁 Files & structure
main.tf — resources (resource group, data factory, databricks workspace, random_pet)
providers.tf — provider and required_providers block
variables.tf — input variables
output.tf — outputs
readme.md — this document

🔢 Variables
Name	Type	Default	Description
resource_group_location	string	"eastuk"	Location of the resource group.
resource_group_name_prefix	string	"rg"	Prefix used by random_pet to generate a unique resource group name.


resource_group_location = "eastus"
resource_group_name_prefix = "rg"

📤 Outputs
Name	Description
resource_group_name	The generated name of the created Azure Resource Group.


terraform output

💡 Example usage (root configuration)
Run in this folder (this is designed as a root configuration rather than a reusable module):
terraform init
terraform plan -out=plan.tfplan
terraform apply plan.tfplan