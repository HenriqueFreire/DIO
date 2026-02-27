# my-ts-api: Uma Pequena API TypeScript com Deploy Automatizado para Azure

Este projeto demonstra a criação de uma API simples em TypeScript e a automação do seu deploy para o Microsoft Azure utilizando scripts do Azure CLI e Docker. O ambiente de desenvolvimento é configurado com Nix, garantindo reprodutibilidade.

## Funcionalidades

*   API "Hello World" simples construída com Node.js e Express.js.
*   Containerização da aplicação utilizando Docker.
*   Ambiente de desenvolvimento reproduzível com `shell.nix`.
*   Automação para provisionamento de recursos Azure (Resource Group, Azure Container Registry, Azure App Service).
*   Automação para build da imagem Docker, push para o ACR e deploy para o Azure App Service.
*   Configuração de Continuous Deployment (CD) no Azure App Service via webhook.

## Tecnologias Utilizadas

*   **TypeScript**
*   **Node.js**
*   **Express.js**
*   **Docker**
*   **Azure CLI**
*   **Nix / Nix-shell** (para ambiente de desenvolvimento)

## Estrutura do Projeto

```
my-ts-api/
├── src/
│   └── index.ts          # Código fonte da API (Endpoint "Hello World")
├── Dockerfile            # Definição da imagem Docker da aplicação
├── .dockerignore         # Arquivos/pastas a serem ignorados pelo Docker
├── package.json          # Metadados e dependências do projeto Node.js
├── tsconfig.json         # Configuração do compilador TypeScript
├── shell.nix             # Definição do ambiente de desenvolvimento Nix
├── azure-provision.sh    # Script para provisionar recursos Azure
├── docker-build-push.sh  # Script para construir e enviar a imagem Docker para o ACR
└── azure-deploy.sh       # Script para deployar a imagem do ACR para o Azure App Service
└── README.md             # Este arquivo
```

## Como Começar (Desenvolvimento Local)

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

*   **Nix:** Para gerenciar o ambiente de desenvolvimento. [Guia de instalação](https://nixos.org/download.html)
*   **Docker:** Para construir e executar imagens de contêiner. [Guia de instalação](https://docs.docker.com/get-docker/)
*   **Node.js & npm:** Gerenciados pelo Nix.

### Configuração do Ambiente Nix

1.  **Navegue até o diretório raiz da API:**
    ```bash
    cd my-ts-api
    ```
2.  **Entre no ambiente de desenvolvimento Nix shell:**
    ```bash
    nix-shell
    ```
    Isso ativará um shell com Node.js, npm, TypeScript e Azure CLI disponíveis, conforme definido em `shell.nix`.

### Instalação de Dependências

Dentro do `nix-shell`:

```bash
npm install
```

### Executando a API Localmente

Dentro do `nix-shell`:

```bash
npm run dev
```

A API estará disponível em `http://localhost:3000`. Você pode testá-la no seu navegador ou com `curl`:

```bash
curl http://localhost:3000
```

## Deploy Automatizado no Azure

Os scripts de automação foram projetados para serem executados quando você tiver uma conta Azure ativa.

### Pré-requisitos para o Deploy no Azure

*   **Conta Azure Ativa:** Você precisará de uma assinatura ativa do Microsoft Azure.
*   **Azure CLI:** Já incluído no seu `shell.nix`.
*   **Permissões:** Sua conta Azure precisa ter permissões para criar e gerenciar Resource Groups, ACRs, App Service Plans e Web Apps.

### Passos para o Deploy

1.  **Autentique-se no Azure CLI:**
    Certifique-se de estar dentro do `nix-shell` no diretório `my-ts-api`.
    ```bash
    az login
    ```
    Siga as instruções para autenticar sua conta Azure.

2.  **Provisione os Recursos Azure:**
    Execute o script de provisionamento. Ele criará o Resource Group, o Azure Container Registry (ACR) e o Azure App Service.
    ```bash
    ./azure-provision.sh
    ```
    **Importante:** Este script gerará nomes únicos para o ACR e o App Service. Anote-os, pois você precisará deles nos próximos scripts. Alternativamente, você pode editar o script `azure-provision.sh` para definir nomes específicos.

3.  **Atualize os Scripts de Deploy:**
    Edite os scripts `docker-build-push.sh` e `azure-deploy.sh` e substitua os placeholders `YOUR_ACR_NAME` e `YOUR_APP_SERVICE_NAME` pelos nomes reais gerados ou escolhidos por você.

4.  **Construa e Envie a Imagem Docker para o ACR:**
    Execute o script para construir sua imagem Docker e enviá-la para o ACR que você provisionou.
    ```bash
    ./docker-build-push.sh
    ```

5.  **Deplore a Imagem do ACR para o Azure App Service:**
    Execute o script para configurar seu Azure App Service para puxar e executar a imagem do ACR, e para configurar o Continuous Deployment.
    ```bash
    ./azure-deploy.sh
    ```

### Verificando o Deploy e o Continuous Deployment (CD)

*   **Acessar a Aplicação Deployada:**
    Obtenha a URL da sua aplicação no Azure:
    ```bash
    az webapp show --name YOUR_APP_SERVICE_NAME --query defaultHostName --output tsv
    ```
    (Substitua `YOUR_APP_SERVICE_NAME` pelo nome real da sua aplicação). Acesse esta URL no navegador para ver a API em execução.

*   **Testando o CD:**
    1.  Faça uma pequena alteração no `src/index.ts` (ex: mude a mensagem de resposta).
    2.  Execute novamente o script `./docker-build-push.sh`.
    3.  O Azure App Service detectará automaticamente a nova imagem no ACR (via webhook) e redeployará sua aplicação. Após alguns minutos, a URL da sua aplicação mostrará a alteração.

## Considerações Futuras

*   **Variáveis de Ambiente:** Gerenciar variáveis de ambiente de forma mais segura (ex: Azure Key Vault, configurações do App Service).
*   **Configuração de Produção:** O `shell.nix` e os scripts atuais são mais focados em desenvolvimento e testes. Para produção, considere configurações de recursos Azure (SKU) mais robustas e pipelines de CI/CD formais.
*   **Segurança:** Implementar autenticação e autorização na API.
*   **Monitoramento:** Adicionar ferramentas de monitoramento e log para a aplicação no Azure.
*   **Remoção de Recursos:** Criar um script `azure-cleanup.sh` para remover facilmente todos os recursos Azure criados.
