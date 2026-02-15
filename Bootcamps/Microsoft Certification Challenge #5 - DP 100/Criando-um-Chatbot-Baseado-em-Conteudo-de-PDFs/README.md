# Chatbot baseado em PDF com Azure AI Foundry

Este projeto automatiza a configuração de um chatbot que utiliza RAG (Retrieval Augmented Generation) para responder perguntas baseadas em documentos PDF, utilizando os serviços de IA da Microsoft Azure.

## Arquitetura
- **Azure AI Foundry (Hub/Project)**: Orquestração do ambiente de IA.
- **Azure OpenAI**: Modelos `gpt-4` para chat e `text-embedding-3-small` para vetores.
- **Azure AI Search**: Banco de dados vetorial para busca semântica nos PDFs.
- **Nix**: Gerenciamento de ambiente reprodutível.
- **Terraform**: Infraestrutura como Código (IaC).

## Como Preparar (Sem conta Azure)
O ambiente já está pronto. Para explorar as dependências e o código:
1. Certifique-se de ter o `nix` instalado.
2. Execute `nix-shell` na raiz do projeto. Isso instalará o Python, Terraform e Azure CLI automaticamente em um ambiente isolado.

## Como Executar (Quando tiver conta Azure)
1. **Login no Azure**:
   ```bash
   az login
   ```
2. **Implantar Infraestrutura**:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```
3. **Configurar Variáveis**:
   - Copie o `.env.example` para `.env`.
   - Preencha com os logs/outputs gerados pelo Terraform.
4. **Ingestão de Dados**:
   - Coloque seus PDFs na pasta `data/`.
   - Execute `python src/ingest.py`.
5. **Chat**:
   - Execute `python src/chat.py`.

## Estrutura de Pastas
- `terraform/`: Arquivos de configuração da infraestrutura.
- `src/`: Scripts Python do chatbot.
- `data/`: Local para armazenar os PDFs.
- `shell.nix`: Configuração do ambiente de desenvolvimento.
