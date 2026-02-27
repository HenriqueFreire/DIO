# Serverless CPF Validation Microservice

This project implements a serverless microservice for validating Brazilian CPF (Cadastro de Pessoas Físicas) numbers. It is built using Azure Functions (Node.js), JavaScript, and leverages `shell.nix` for a reproducible development environment.

## Features

*   **CPF Validation**: Validates the format and checksum digits of a given CPF.
*   **Serverless**: Deploys as an Azure Function, providing a scalable and cost-effective solution.
*   **API Endpoint**: Exposes an HTTP endpoint for easy integration with other applications.

## Prerequisites

Before you begin, ensure you have the following installed:

*   **Nix**: A powerful package manager for reproducible builds and environments. Follow the installation guide on [NixOS.org](https://nixos.org/download.html).
*   **Azure CLI**: Command-line tools for managing Azure resources. Install it by following the instructions on [Microsoft Docs](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
*   **Azure Functions Core Tools**: While this project uses `shell.nix` to provide it, if you prefer a global installation, refer to the [official documentation](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Ccsharp%2Cportal%2Cbash%2Ckeda#install-the-azure-functions-core-tools).

## Development Setup

1.  **Clone the repository**:
    ```bash
    git clone <repository_url>
    cd Criando-um-Microsservico-Serverless-para-Validacao-de-CPF
    ```

2.  **Enter the Development Environment**:
    This project uses `shell.nix` to ensure a consistent development environment with `nodejs` and `azure-functions-core-tools` readily available.
    ```bash
    nix-shell
    ```
    You will be dropped into a new shell where all necessary tools are configured.

## Running Locally

Once you are in the `nix-shell` environment:

1.  **Navigate to the function app directory**:
    ```bash
    cd cpf-validator-function
    ```

2.  **Start the Azure Function host**:
    ```bash
    func start
    ```
    The function host will start, and you will see the URL for your `ValidateCpf` function (e.g., `http://localhost:7071/api/ValidateCpf`).

3.  **Test the function**:
    You can test the function using `curl` or a tool like Postman/Insomnia.

    *   **GET request with query parameter**:
        ```bash
        curl "http://localhost:7071/api/ValidateCpf?cpf=12345678909"
        ```

    *   **POST request with body**:
        ```bash
        curl -X POST -H "Content-Type: text/plain" -d "12345678909" "http://localhost:7071/api/ValidateCpf"
        ```

    The response will be a JSON object indicating the CPF and its validity:
    ```json
    {"cpf":"12345678909","isValid":false}
    ```

## Deployment to Azure

To deploy this microservice to your Azure subscription:

1.  **Log in to Azure**:
    ```bash
    az login
    ```

2.  **Create a Resource Group** (if you don't have one):
    ```bash
    az group create --name <YOUR_RESOURCE_GROUP_NAME> --location <YOUR_LOCATION>
    # Example: az group create --name CpfValidatorRg --location eastus
    ```

3.  **Create an Azure Storage Account**:
    ```bash
    az storage account create --name <YOUR_STORAGE_ACCOUNT_NAME> --location <YOUR_LOCATION> --resource-group <YOUR_RESOURCE_GROUP_NAME> --sku Standard_LRS
    # Example: az storage account create --name cpfvalidatorstorage --location eastus --resource-group CpfValidatorRg --sku Standard_LRS
    ```

4.  **Create an Azure Function App**:
    ```bash
    az functionapp create --resource-group <YOUR_RESOURCE_GROUP_NAME> --consumption-plan-location <YOUR_LOCATION> --runtime node --runtime-version 18 --functions-version 4 --name <YOUR_FUNCTION_APP_NAME> --storage-account <YOUR_STORAGE_ACCOUNT_NAME>
    # Example: az functionapp create --resource-group CpfValidatorRg --consumption-plan-location eastus --runtime node --runtime-version 18 --functions-version 4 --name mycpfvalidatorapp --storage-account cpfvalidatorstorage
    ```

5.  **Publish the Function App**:
    Ensure you are in the `cpf-validator-function` directory.
    ```bash
    func azure functionapp publish <YOUR_FUNCTION_APP_NAME>
    # Example: func azure functionapp publish mycpfvalidatorapp
    ```
    (This command should be run from within the `nix-shell` or with Azure Functions Core Tools installed globally.)

## Usage

Once deployed, you can access your function at the URL provided by Azure (e.g., `https://<YOUR_FUNCTION_APP_NAME>.azurewebsites.net/api/ValidateCpf`).

You can make requests similar to the local testing:

*   **GET request**: `https://<YOUR_FUNCTION_APP_NAME>.azurewebsites.net/api/ValidateCpf?cpf=12345678909`
*   **POST request**: Send a POST request to `https://<YOUR_FUNCTION_APP_NAME>.azurewebsites.net/api/ValidateCpf` with the CPF in the request body (Content-Type: `text/plain`).
