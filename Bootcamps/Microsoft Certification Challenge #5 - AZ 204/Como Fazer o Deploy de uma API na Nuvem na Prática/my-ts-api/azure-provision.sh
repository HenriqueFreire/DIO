#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration Variables ---
# Customize these values for your Azure deployment
RESOURCE_GROUP_NAME="my-ts-api-rg"        # Name of the Azure Resource Group
LOCATION="eastus"                         # Azure region (e.g., eastus, westus, brazilsouth)
ACR_NAME="mytsapiacr$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)" # Azure Container Registry name (must be globally unique)
APP_SERVICE_PLAN_NAME="my-ts-api-plan"    # Name of the App Service Plan
APP_SERVICE_NAME="my-ts-api-app-$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)" # Name of the App Service (must be globally unique)

# --- Azure CLI Commands ---

echo "--- Creating Azure Resource Group: $RESOURCE_GROUP_NAME in $LOCATION ---"
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

echo "--- Creating Azure Container Registry: $ACR_NAME ---"
# SKU can be Basic, Standard, or Premium. Basic is sufficient for most dev/test scenarios.
az acr create --resource-group $RESOURCE_GROUP_NAME --name $ACR_NAME --sku Basic --admin-enabled true

echo "--- Creating Azure App Service Plan: $APP_SERVICE_PLAN_NAME ---"
# SKU can be F1 (Free), B1 (Basic), S1 (Standard), etc. F1 is good for testing.
# For production, consider B1 or higher.
az appservice plan create --name $APP_SERVICE_PLAN_NAME --resource-group $RESOURCE_GROUP_NAME --is-linux --sku F1

echo "--- Creating Azure Web App: $APP_SERVICE_NAME ---"
# We create it as a Linux web app and specify it will run a Docker image.
# The image will be updated later by the deployment script.
az webapp create --resource-group $RESOURCE_GROUP_NAME --plan $APP_SERVICE_PLAN_NAME --name $APP_SERVICE_NAME --deployment-container-image-name "mcr.microsoft.com/azure-cli" # Placeholder image

echo "--- Storing ACR login server for later use ---"
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
echo "ACR Login Server: $ACR_LOGIN_SERVER"

echo "--- Azure resource provisioning script completed ---"
echo "You can now use the following values in your deployment scripts:"
echo "RESOURCE_GROUP_NAME=$RESOURCE_GROUP_NAME"
echo "ACR_NAME=$ACR_NAME"
echo "ACR_LOGIN_SERVER=$ACR_LOGIN_SERVER"
echo "APP_SERVICE_NAME=$APP_SERVICE_NAME"
