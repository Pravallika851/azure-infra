terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformdev111"
    container_name       = "tfstate"
    key                  = "global/bootstrap.tfstate"
  }
}
