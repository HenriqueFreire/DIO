# 🌐 Tradutor de Artigos Técnicos com Azure AI

Este projeto utiliza o serviço **Azure AI Translator** para converter artigos técnicos (focando no [dev.to](https://dev.to)) de inglês para português, preservando o layout HTML original, imagens e blocos de código.

## 📋 Pré-requisitos

- **Nix** instalado (opcional, mas recomendado para ambiente reprodutível)
- Conta no **Azure** com o recurso **Translator** criado.

## 📂 Estrutura do Projeto

- `translator.py`: Script principal que extrai o HTML do artigo e realiza a tradução.
- `shell.nix`: Configuração do ambiente com Python 3.12 e dependências.
- `.env.example`: Modelo para configuração das chaves de API.

## 🛠️ Como Usar

### 1. Configurar o Ambiente
Se você utiliza **Nix**, rode o comando abaixo na raiz do projeto para entrar no shell com todas as dependências:
```bash
nix-shell
```
*Caso não utilize Nix, instale as dependências manualmente via pip:* `pip install requests beautifulsoup4 python-dotenv`

### 2. Configurar Credenciais do Azure
1. Copie o arquivo de exemplo para criar o seu `.env`:
   ```bash
   cp .env.example .env
   ```
2. Edite o `.env` e preencha com suas informações obtidas no Portal do Azure:
   - `AZURE_RESOURCE_KEY`: Sua chave secreta (Key 1 ou Key 2).
   - `AZURE_RESOURCE_REGION`: A região do recurso (ex: `eastus`).

### 3. Executar a Tradução
Rode o script passando a URL do artigo desejado:
```bash
python translator.py "https://dev.to/usuario/nome-do-artigo"
```

**Opcional**: Você pode especificar o idioma de destino (padrão é `pt-br`):
```bash
python translator.py "https://dev.to/..." "es"
```

## 📄 Resultado
O script gerará um arquivo chamado `artigo_traduzido.html`. Basta abri-lo no seu navegador favorito para ler o artigo traduzido com a formatação original.

