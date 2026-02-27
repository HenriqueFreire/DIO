#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration Variables ---
# These values should match what was used in azure-provision.sh or be retrieved dynamically.
ACR_NAME="YOUR_ACR_NAME" # Replace with your Azure Container Registry name
IMAGE_NAME="my-ts-api"    # Name of the Docker image
IMAGE_TAG="latest"        # Tag for the Docker image

# --- Azure CLI Commands ---

echo "--- Logging in to Azure Container Registry: $ACR_NAME ---"
az acr login --name $ACR_NAME

echo "--- Building Docker image: $IMAGE_NAME:$IMAGE_TAG ---"
docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo "--- Tagging Docker image for ACR ---"
# Get the ACR login server dynamically if not set
if [ "$ACR_LOGIN_SERVER" == "" ]; then
  ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
fi
docker tag $IMAGE_NAME:$IMAGE_TAG $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

echo "--- Pushing Docker image to ACR ---"
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

echo "--- Docker image build and push completed ---"
echo "Image available at: $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG"
