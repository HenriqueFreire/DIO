terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ml_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "ml_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.ml_rg.name
  location                 = azurerm_resource_group.ml_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "ml_kv" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

resource "azurerm_application_insights" "ml_ai" {
  name                = var.app_insights_name
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  application_type    = "web"
}

resource "azurerm_machine_learning_workspace" "ml_ws" {
  name                    = var.workspace_name
  location                = azurerm_resource_group.ml_rg.location
  resource_group_name     = azurerm_resource_group.ml_rg.name
  application_insights_id = azurerm_application_insights.ml_ai.id
  key_vault_id            = azurerm_key_vault.ml_kv.id
  storage_account_id      = azurerm_storage_account.ml_storage.id

  identity {
    type = "SystemAssigned"
  }
}
