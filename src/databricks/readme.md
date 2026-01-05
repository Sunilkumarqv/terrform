
# Databricks Configuration

## Overview
This directory contains Databricks infrastructure and configuration files.

## Files

### `databricks`
Main Databricks configuration and resource definitions for Terraform deployment.

### `db_cd.yaml`
Continuous Deployment configuration file for Databricks workflows and job definitions.

## Usage
- Configure Databricks provider credentials
- Define clusters, jobs, and workspace resources in the Terraform files
- Reference `db_cd.yaml` for CI/CD pipeline integration
