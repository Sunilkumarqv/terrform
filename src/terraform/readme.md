# Terraform Configuration

This directory contains the Terraform configuration files for infrastructure provisioning.

## Files

- **main.tf** - Primary resource definitions and configurations
- **outputs.tf** - Output values exported from the Terraform state
- **providers.tf** - Provider configuration and version constraints
- **variables.tf** - Input variable definitions and defaults

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Requirements

See `providers.tf` for required provider versions and `variables.tf` for required inputs.