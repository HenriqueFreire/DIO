#!/bin/bash

# Aborta se um comando falhar
set -e

# --- Configurações Gerais ---
LOCATION="brazilsouth" # Você pode mudar esta região
ENVIRONMENT="Development"
PROJECT="DIO-AzureDevOps"
OWNER="Henrique" # Adapte com seu nome ou time

# --- Autenticação ---
echo "Verificando login no Azure..."
az account show -o table || { echo "Erro: Não logado no Azure. Por favor, execute 'az login' e tente novamente."; exit 1; }
echo "Login no Azure verificado."

# --- Departamento de TI ---
IT_RG_NAME="rg-${PROJECT}-it-${ENVIRONMENT}"
IT_TAGS="Department=IT Environment=${ENVIRONMENT} Project=${PROJECT} Owner=${OWNER}"

echo -e "\n--- Criando Resource Group para TI: ${IT_RG_NAME} ---"
az group create \
  --name "${IT_RG_NAME}" \
  --location "${LOCATION}" \
  --tags ${IT_TAGS} \
  --output table

echo "Criando recursos para TI..."

# Exemplo TI: Rede Virtual
echo "  - Criando Rede Virtual (VNet) para TI..."
az network vnet create \
  --resource-group "${IT_RG_NAME}" \
  --name "${PROJECT}-vnet-it" \
  --address-prefix 10.0.0.0/16 \
  --location "${LOCATION}" \
  --tags ${IT_TAGS} \
  --output none

# Exemplo TI: Subnet
echo "  - Criando Subnet para TI..."
az network vnet subnet create \
  --resource-group "${IT_RG_NAME}" \
  --vnet-name "${PROJECT}-vnet-it" \
  --name "${PROJECT}-subnet-it" \
  --address-prefixes 10.0.0.0/24 \
  --output none

# Exemplo TI: IP Público (para a VM)
echo "  - Criando IP Público para VM de TI..."
az network public-ip create \
  --resource-group "${IT_RG_NAME}" \
  --name "${PROJECT}-ip-vm-it" \
  --sku Standard \
  --allocation-method Static \
  --location "${LOCATION}" \
  --tags ${IT_TAGS} \
  --output none

# Exemplo TI: Network Security Group (para a VM)
echo "  - Criando Network Security Group (NSG) para VM de TI..."
az network nsg create \
  --resource-group "${IT_RG_NAME}" \
  --name "${PROJECT}-nsg-vm-it" \
  --location "${LOCATION}" \
  --tags ${IT_TAGS} \
  --output none

# Exemplo TI: Regra NSG para SSH (porta 22)
echo "  - Adicionando regra SSH ao NSG de TI..."
az network nsg rule create \
  --resource-group "${IT_RG_NAME}" \
  --nsg-name "${PROJECT}-nsg-vm-it" \
  --name "Allow-SSH" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-ranges 22 \
  --source-address-prefixes "*" \
  --output none

# Exemplo TI: Network Interface (para a VM)
echo "  - Criando Network Interface (NIC) para VM de TI..."
az network nic create \
  --resource-group "${IT_RG_NAME}" \
  --vnet-name "${PROJECT}-vnet-it" \
  --subnet "${PROJECT}-subnet-it" \
  --public-ip-address "${PROJECT}-ip-vm-it" \
  --network-security-group "${PROJECT}-nsg-vm-it" \
  --location "${LOCATION}" \
  --tags ${IT_TAGS} \
  --output none

# Exemplo TI: Máquina Virtual (Ubuntu 22.04 LTS)
# NOTA: A criação de VM requer nome de usuário e senha/chave SSH.
# PARA PROPOSITO DE DEMONSTRAÇÃO, VOU USAR UM NOME DE USUÁRIO E SENHA DE EXEMPLO.
# EM PRODUÇÃO, USE UMA CHAVE SSH OU AZURE KEY VAULT.
VM_USERNAME="azureuser"
VM_PASSWORD="Password123!" # MUDE ESTA SENHA EM AMBIENTES REAIS!
echo "  - Criando Máquina Virtual (VM) para TI (Ubuntu 22.04 LTS)..."
echo "    !!! ATENÇÃO: Usando senha de exemplo para a VM. Em produção, use chave SSH ou Key Vault !!!"
az vm create \
  --resource-group "${IT_RG_NAME}" \
  --name "${PROJECT}-vm-it" \
  --location "${LOCATION}" \
  --image "Ubuntu2204" \
  --size Standard_B1s \
  --admin-username "${VM_USERNAME}" \
  --admin-password "${VM_PASSWORD}" \
  --nics "${PROJECT}-nic-vm-it" \
  --tags ${IT_TAGS} \
  --output none

echo "Recursos de TI criados com sucesso!"

# --- Departamento de Marketing ---
MARKETING_RG_NAME="rg-${PROJECT}-marketing-${ENVIRONMENT}"
MARKETING_TAGS="Department=Marketing Environment=${ENVIRONMENT} Project=${PROJECT} Owner=${OWNER}"

echo -e "\n--- Criando Resource Group para Marketing: ${MARKETING_RG_NAME} ---"
az group create \
  --name "${MARKETING_RG_NAME}" \
  --location "${LOCATION}" \
  --tags ${MARKETING_TAGS} \
  --output table

echo "Criando recursos para Marketing..."

# Exemplo Marketing: Storage Account (para ativos de mídia)
STORAGE_ACCOUNT_NAME="stg${PROJECT}marketing${ENVIRONMENT//-}" # Nome da SA deve ser único globalmente e apenas minúsculas
echo "  - Criando Storage Account para Marketing: ${STORAGE_ACCOUNT_NAME}..."
az storage account create \
  --resource-group "${MARKETING_RG_NAME}" \
  --name "${STORAGE_ACCOUNT_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --tags ${MARKETING_TAGS} \
  --output none

# Exemplo Marketing: App Service Plan
APP_SERVICE_PLAN_NAME="${PROJECT}-plan-marketing"
echo "  - Criando App Service Plan para Marketing: ${APP_SERVICE_PLAN_NAME}..."
az appservice plan create \
  --resource-group "${MARKETING_RG_NAME}" \
  --name "${APP_SERVICE_PLAN_NAME}" \
  --location "${LOCATION}" \
  --is-linux \
  --sku B1 \
  --tags ${MARKETING_TAGS} \
  --output none

# Exemplo Marketing: Web App
WEB_APP_NAME="${PROJECT}-webapp-marketing" # Nome do Web App deve ser único globalmente
echo "  - Criando Web App para Marketing: ${WEB_APP_NAME}..."
az webapp create \
  --resource-group "${MARKETING_RG_NAME}" \
  --plan "${APP_SERVICE_PLAN_NAME}" \
  --name "${WEB_APP_NAME}" \
  --runtime "NODE:18-LTS" \
  --tags ${MARKETING_TAGS} \
  --output none

echo "Recursos de Marketing criados com sucesso!"

# --- Departamento Financeiro ---
FINANCE_RG_NAME="rg-${PROJECT}-finance-${ENVIRONMENT}"
FINANCE_TAGS="Department=Finance Environment=${ENVIRONMENT} Project=${PROJECT} Owner=${OWNER}"

echo -e "\n--- Criando Resource Group para Finance: ${FINANCE_RG_NAME} ---"
az group create \
  --name "${FINANCE_RG_NAME}" \
  --location "${LOCATION}" \
  --tags ${FINANCE_TAGS} \
  --output table

echo "Criando recursos para Finance..."

# Exemplo Financeiro: Azure SQL Server
SQL_SERVER_NAME="${PROJECT}sqlserver" # Nome do SQL Server deve ser único globalmente
SQL_ADMIN_USERNAME="sqladmin"
SQL_ADMIN_PASSWORD="Password123!" # MUDE ESTA SENHA EM AMBIENTES REAIS!
echo "  - Criando Azure SQL Server para Finance: ${SQL_SERVER_NAME}..."
echo "    !!! ATENÇÃO: Usando senha de exemplo para o SQL Server. Em produção, use Key Vault !!!"
az sql server create \
  --resource-group "${FINANCEIRO_RG_NAME}" \
  --name "${SQL_SERVER_NAME}" \
  --location "${LOCATION}" \
  --admin-user "${SQL_ADMIN_USERNAME}" \
  --admin-password "${SQL_ADMIN_PASSWORD}" \
  --tags ${FINANCEIRO_TAGS} \
  --output none

# Exemplo Financeiro: Regra de Firewall para o SQL Server (permitir acesso do Azure Services)
echo "  - Adicionando regra de Firewall ao SQL Server para serviços Azure..."
az sql server firewall-rule create \
  --resource-group "${FINANCEIRO_RG_NAME}" \
  --server "${SQL_SERVER_NAME}" \
  --name "AllowAzureServices" \
  --start-ip-address "0.0.0.0" \
  --end-ip-address "0.0.0.0" \
  --output none

# Exemplo Financeiro: Azure SQL Database
SQL_DB_NAME="${PROJECT}-sqldb-finance"
echo "  - Criando Azure SQL Database para Finance: ${SQL_DB_NAME}..."
az sql db create \
  --resource-group "${FINANCEIRO_RG_NAME}" \
  --server "${SQL_SERVER_NAME}" \
  --name "${SQL_DB_NAME}" \
  --edition Basic \
  --tags ${FINANCEIRO_TAGS} \
  --output none

# Exemplo Financeiro: Key Vault
KEY_VAULT_NAME="${PROJECT}-kv-finance" # Nome do Key Vault deve ser único globalmente
echo "  - Criando Key Vault para Finance: ${KEY_VAULT_NAME}..."
az keyvault create \
  --resource-group "${FINANCEIRO_RG_NAME}" \
  --name "${KEY_VAULT_NAME}" \
  --location "${LOCATION}" \
  --sku Standard \
  --tags ${FINANCEIRO_TAGS} \
  --output none

echo "Recursos de Finance criados com sucesso!"

echo -e "\n--- Automação de criação de recursos Azure concluída com sucesso! ---"
