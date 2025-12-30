terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm   = { source = "hashicorp/azurerm", version = "~> 3.115" }
    databricks = { source = "databricks/databricks", version = "~> 1.41" }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
}
