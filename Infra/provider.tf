# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscriptionId = var.subscriptionId
  # client_id =var.client_id
  # client_secret = var.client_secret
  # tenant_id = var.tenant_id

}

terraform {
  backend "azurerm" {
    resource_group_name  = "TF-Deployment"
    storage_account_name = "saterraformstate01"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}