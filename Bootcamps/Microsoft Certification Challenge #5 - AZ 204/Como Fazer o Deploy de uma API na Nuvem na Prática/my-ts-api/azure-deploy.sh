#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration Variables ---
# These values should match what was used in azure-provision.sh or be retrieved dynamically.
ACR_NAME="YOUR_ACR_NAME" # Replace with your Azure Container Registry name
APP_SERVICE_NAME="YOUR_APP_SERVICE_NAME" # Replace with your Azure App Service name
IMAGE_NAME="my-ts-api" # Name of the Docker image
IMAGE_TAG="latest"     # Tag for the Docker image

# --- Azure CLI Commands ---

echo "--- Retrieving ACR login server ---"
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)

echo "--- Configuring App Service '$APP_SERVICE_NAME' to use image '$ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG' ---"
az webapp config container set \
  --name $APP_SERVICE_NAME \
  --resource-group $(az webapp show --name $APP_SERVICE_NAME --query resourceGroup --output tsv) \
  --docker-custom-image-name "$ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG" \
  --enable-app-service-storage false \
  --registry-server "$ACR_LOGIN_SERVER"

echo "--- Setting up Continuous Deployment (Webhook) ---"
# This command enables continuous deployment and sets up a webhook.
# Azure will automatically pull new images from ACR when they are pushed.
# The webhook URL can be retrieved after enabling CD, for manual configuration in ACR.
az webapp deployment container config \
  --enable-cd true \
  --name $APP_SERVICE_NAME \
  --resource-group $(az webapp show --name $APP_SERVICE_NAME --query resourceGroup --output tsv)

echo "--- Azure deployment script completed ---"
echo "To trigger continuous deployment, push a new image to ACR."
echo "You can also get the webhook URL for manual configuration in ACR if needed:"
echo "az webapp deployment container show --name $APP_SERVICE_NAME --resource-group $(az webapp show --name $APP_SERVICE_NAME --query resourceGroup --output tsv) --query targetUrl --output tsv"
