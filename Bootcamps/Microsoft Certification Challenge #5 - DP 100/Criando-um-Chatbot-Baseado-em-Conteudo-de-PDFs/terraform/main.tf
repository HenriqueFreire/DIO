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

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure AI Services (OpenAI)
resource "azurerm_cognitive_account" "openai" {
  name                = "openai-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

# Azure OpenAI Deployment (gpt-4o ou similar)
resource "azurerm_cognitive_deployment" "gpt" {
  name                 = "chat-model"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "turbo-2024-04-09"
  }
  scale {
    type = "Standard"
  }
}

# Azure OpenAI Deployment (embeddings)
resource "azurerm_cognitive_deployment" "embeddings" {
  name                 = "embedding-model"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "text-embedding-3-small"
    version = "1"
  }
  scale {
    type = "Standard"
  }
}

# Azure AI Search
resource "azurerm_search_service" "search" {
  name                = "search-${var.project_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "standard" # Necessário para funcionalidades avançadas de RAG
}

# Nota: A criação de recursos específicos de AI Foundry (Hub/Project) via Terraform 
# azurerm pode requerer configurações adicionais ou uso de azapi provider para recursos em preview.
