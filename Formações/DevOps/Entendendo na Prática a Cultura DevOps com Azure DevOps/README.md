# Automação de Infraestrutura Azure com NixOS e Azure CLI

Este projeto demonstra como automatizar a criação de recursos na Azure para diferentes departamentos (TI, Marketing, Financeiro) utilizando o Azure CLI dentro de um ambiente NixOS configurado via `shell.nix`.

## Estrutura do Projeto

*   `shell.nix`: Define o ambiente de desenvolvimento, garantindo que o `azure-cli` e suas dependências estejam disponíveis.
*   `create_azure_resources.sh`: Um script Bash que executa comandos do Azure CLI para provisionar os Resource Groups e recursos específicos de cada departamento, aplicando tags padronizadas.

## Pré-requisitos

Para executar este projeto, você precisará ter:

1.  **NixOS** (ou um sistema com Nix instalado)
2.  **Azure CLI** (será provisionado pelo `shell.nix`, mas é bom ter o conhecimento prévio)
3.  **Uma assinatura Azure** com permissões para criar Resource Groups e os recursos especificados.

## Configuração

1.  **Navegue até o diretório do projeto:**
    ```bash
    cd /home/henrique/Documentos/DIO/Formações/DevOps/Entendendo na Prática a Cultura DevOps com Azure DevOps/
    ```

2.  **Revise e personalize o script `create_azure_resources.sh`:**
    *   Abra o arquivo `create_azure_resources.sh` em um editor de texto.
    *   **`LOCATION`**: Altere a variável `LOCATION` para a região da Azure de sua preferência (ex: `eastus`, `westeurope`). Atualmente está configurada como `brazilsouth`.
    *   **`OWNER`**: Atualize a variável `OWNER` com seu nome ou o do seu time.
    *   **Credenciais (ATENÇÃO!):** As senhas para a VM (`VM_PASSWORD`) e o SQL Server (`SQL_ADMIN_PASSWORD`) estão hardcoded no script para fins de demonstração. **Em um ambiente de produção, é CRITICAMENTE IMPORTANTE que você use métodos seguros para gerenciar credenciais, como Chaves SSH, Azure Key Vault, Managed Identities ou variáveis de ambiente seguras.**
    *   **Nomes de Recursos:** Alguns nomes de recursos (Storage Account, SQL Server, Key Vault, Web App) precisam ser **globalmente únicos** na Azure. O script tenta gerar nomes únicos usando o prefixo do `PROJECT` e o `ENVIRONMENT`, mas em caso de conflito, você precisará ajustá-los manualmente.

## Como Executar

Siga os passos abaixo para provisionar sua infraestrutura na Azure:

1.  **Entre no ambiente Nix shell:**
    ```bash
    nix-shell
    ```
    Isso ativará o ambiente definido em `shell.nix`, garantindo que o `azure-cli` esteja disponível para uso. A primeira vez pode demorar um pouco enquanto o Nix baixa e configura as dependências.

2.  **Faça login na sua conta Azure:**
    Dentro do `nix-shell` (seu prompt de comando mudará para indicar o ambiente Nix), execute o comando de login:
    ```bash
    az login
    ```
    Siga as instruções no seu navegador para autenticar sua conta Azure.

3.  **Execute o script de criação de recursos:**
    Após o login, execute o script:
    ```bash
    ./create_azure_resources.sh
    ```
    O script começará a provisionar os Resource Groups e os recursos na sua assinatura Azure, exibindo o progresso no terminal.

## Recursos Criados

O script criará os seguintes Resource Groups e recursos:

### Departamento de TI (Resource Group: `rg-DIO-AzureDevOps-it-Development`)

*   **Rede Virtual (VNet)**: Para infraestrutura isolada.
*   **Subnet**: Sub-rede dentro da VNet.
*   **IP Público**: Para a VM de TI.
*   **Network Security Group (NSG)**: Regras de firewall para a VM.
*   **NIC (Network Interface)**: Interface de rede para a VM.
*   **Máquina Virtual (VM)**: Exemplo de servidor Ubuntu 22.04 LTS.

### Departamento de Marketing (Resource Group: `rg-DIO-AzureDevOps-marketing-Development`)

*   **Storage Account**: Para armazenar ativos de mídia (imagens, vídeos).
*   **App Service Plan**: Plano de hospedagem para aplicações web.
*   **Web App**: Exemplo de aplicação web para fins de marketing.

### Departamento de Finance (Resource Group: `rg-DIO-AzureDevOps-finance-Development`)

*   **Azure SQL Server**: Servidor para bancos de dados financeiros.
*   **Azure SQL Database**: Banco de dados para dados de transações/relatórios.
*   **Key Vault**: Para armazenamento seguro de segredos (credenciais, chaves).

## Limpeza (Opcional)

Se você deseja remover todos os recursos criados por este script (e evitar custos desnecessários), você pode excluir os Resource Groups. Tenha **EXTREMA CAUTELA** ao executar este comando, pois ele removerá **TODOS** os recursos dentro dos Resource Groups especificados, sem possibilidade de recuperação fácil.

1.  Certifique-se de estar logado no Azure (`az login`).
2.  Execute os comandos de exclusão:
    ```bash
    az group delete --name "rg-DIO-AzureDevOps-it-Development" --yes --no-wait
    az group delete --name "rg-DIO-AzureDevOps-marketing-Development" --yes --no-wait
    az group delete --name "rg-DIO-AzureDevOps-finance-Development" --yes --no-wait
    ```

---

Qualquer dúvida ou necessidade de personalização, sinta-se à vontade para perguntar!
