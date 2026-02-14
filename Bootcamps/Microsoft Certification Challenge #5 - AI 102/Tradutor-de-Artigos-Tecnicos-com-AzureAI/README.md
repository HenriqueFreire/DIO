# Tradutor de Artigos Técnicos com Azure AI

Este projeto utiliza o serviço Azure AI Translator para traduzir artigos técnicos de forma automatizada.

## 🚀 Tecnologias

- **Python 3.12**
- **Nix** (Ambiente reprodutível)
- **Azure AI Translator**

## 📂 Estrutura do Projeto

- `shell.nix`: Configuração do ambiente de desenvolvimento.
- `translator.py`: Script principal de tradução.
- `.env.example`: Exemplo de configuração de variáveis de ambiente.

## 🛠️ Como usar

1. **Configurar o Ambiente**:
   Utilize o Nix para carregar todas as dependências:
   ```bash
   nix-shell
   ```

2. **Configurar Credenciais**:
   Copie o `.env.example` para `.env` e preencha com suas chaves do Azure:
   ```bash
   cp .env.example .env
   ```

3. **Executar**:
   ```bash
   python translator.py
   ```
