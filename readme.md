# Terraform ADLS Project 🔧

## Overview ✨
This repository defines an Azure Data Lake Storage (ADLS) deployment using Terraform. It creates a Resource Group, a Storage Account configured for hierarchical namespace (ADLS Gen2), and a storage container. The configuration is modular and uses a reusable `adls` module.

## Repository Structure 📁

```
terraform/
├── main.tf                 # Root module; creates Resource Group and calls modules/adls
├── providers.tf            # Provider and required providers block
├── variables.tf            # Variable definitions and defaults
├── terraform.tfvars        # Default variable values (overridable)
├── output.tf               # Outputs from root module
└── modules/adls/
    ├── main.tf             # Storage account and container resources
    ├── variables.tf        # Module variables
    └── output.tf           # Module outputs
```

## Key Variables & Defaults ⚙️

| Variable | Default | Notes |
|----------|---------|-------|
| `resource_group_location` | `uksouth` | Azure region |
| `resource_group_name` | `rg-retail-002` | Resource group name |
| `storage_account_name` | `rgdbronzestretail0001` | Must be globally unique |
| `container_name` | `bronze` | Storage container name |
| `environment` | `dev` | Deployment environment |

## Usage — Local Workflow 💻

1. **Authenticate to Azure:**
   ```bash
   az login
   az account set --subscription "<SUBSCRIPTION_ID>"
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Validate & Format:**
   ```bash
   terraform fmt -recursive
   terraform validate
   ```

4. **Plan & Apply:**
   ```bash
   terraform plan -out=tfplan
   terraform apply tfplan
   ```

## Automation Scripts 🛠️

- **Bash:** `scripts/terraform-deploy.sh`
- **PowerShell:** `scripts/terraform-deploy.ps1`

## CI/CD with GitHub Actions 🧪

See `.github/workflows/terraform.yml` for automated deployments using GitHub Secrets and Azure Login actions.

## Outputs & Verification ✅

Outputs include resource group name, storage account ID, and primary blob endpoint. Verify via:
```bash
az storage account show --name <storage-account-name> -g <resource-group-name>
```

## Best Practices 💡

- Use workspaces or separate state backends per environment
- Store state remotely (Azure Storage backend) for team collaboration
- Avoid hardcoding sensitive values; use Azure Key Vault or secrets
- Ensure `storage_account_name` is globally unique