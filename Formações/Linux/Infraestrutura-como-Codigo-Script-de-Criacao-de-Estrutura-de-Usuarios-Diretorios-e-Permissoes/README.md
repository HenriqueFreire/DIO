# Projeto 1: Script de Criação de Estrutura de Usuários, Diretórios e Permissões

## Descrição

Este projeto consiste em um script de shell (`iac_script.sh`) que automatiza a criação de uma estrutura organizacional básica em um sistema Linux. Ele cria grupos de usuários, diretórios específicos para esses grupos, define permissões de acesso e cria usuários, associando-os aos seus respectivos grupos.

O script foi projetado para ser idempotente, o que significa que pode ser executado várias vezes sem gerar erros, criando apenas os elementos que ainda não existem no sistema.

## Pré-requisitos

*   Sistema operacional baseado em Linux.
*   Acesso como superusuário (root) ou um usuário com permissões `sudo`.

## Como Usar

1.  **Dar permissão de execução ao script:**
    ```bash
    chmod +x iac_script.sh
    ```

2.  **Executar o script com privilégios de superusuário:**
    ```bash
    sudo ./iac_script.sh
    ```

## O Que o Script Faz

O script executa as seguintes ações:

1.  **Criação de Grupos:**
    *   `GRP_ADM`
    *   `GRP_VEN`
    *   `GRP_SEC`

2.  **Criação de Diretórios no Raiz (`/`):**
    *   `/publico`
    *   `/adm`
    *   `/ven`
    *   `/sec`

3.  **Definição de Permissões:**
    *   O diretório `/publico` recebe permissão total para todos os usuários (`777`).
    *   Os diretórios `/adm`, `/ven` e `/sec` permitem acesso total (`770`) apenas para o usuário `root` e para os membros do grupo correspondente.

4.  **Criação de Usuários:**
    *   **Grupo ADM:** `carlos`, `maria`, `joao`
    *   **Grupo VEN:** `debora`, `sebastiana`, `roberto`
    *   **Grupo SEC:** `josefina`, `amanda`, `rogerio`

### ⚠️ Aviso de Segurança

Todos os usuários são criados com a senha padrão `Senha123`. Esta configuração é **insegura** e serve apenas para fins de demonstração. Em um ambiente de produção, é crucial adotar uma política de senhas mais segura, como forçar a alteração da senha no primeiro login do usuário.
