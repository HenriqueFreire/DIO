# Pipeline ETL com IA Generativa para Marketing Bancário

Este projeto é uma solução para o desafio "Explorando IA Generativa em um Pipeline de ETL com Python" do bootcamp Santander 2025 - Ciência de Dados com Python.

## 🚀 Sobre o Projeto

O objetivo é demonstrar um pipeline de **ETL (Extract, Transform, Load)** que utiliza uma Inteligência Artificial Generativa para criar mensagens de marketing personalizadas para clientes de um banco.

O fluxo do pipeline é o seguinte:
1.  **Extract (Extração):** Os dados dos clientes são lidos de um arquivo `users.csv`.
2.  **Transform (Transformação):** Para cada cliente, o script utiliza a API da OpenAI (GPT) para gerar uma mensagem de marketing única e personalizada, incentivando-o a conhecer novos produtos de investimento.
3.  **Load (Carregamento):** Os dados originais, enriquecidos com as novas mensagens de marketing, são salvos em um novo arquivo chamado `users_with_messages.csv`.

## 🛠️ Tecnologias Utilizadas

- **Python:** Linguagem principal do projeto.
- **Pandas:** Para manipulação e processamento de dados.
- **OpenAI API:** Para a geração de texto com o modelo GPT.
- **Nix:** Para a criação de um ambiente de desenvolvimento 100% reproduzível (específico para gerenciador de pacotes Nix).

## ⚙️ Configuração e Execução

### Pré-requisitos

- Python 3.x instalado.
- Uma chave de API válida da [OpenAI](https://platform.openai.com/account/api-keys).

### 1. Clone o Repositório

```bash
# git clone <url-do-seu-repositorio>
# cd <nome-do-repositorio>
```

### 2. Configure o Ambiente

Temos duas abordagens para configurar o ambiente, uma para usuários NixOS e outra para sistemas operacionais convencionais.

#### Opção A: Para usuários de NixOS (Recomendado)

O arquivo `shell.nix` já define todas as dependências necessárias.

1.  **Inicie o ambiente Nix:**
    ```bash
    nix-shell
    ```
    Este comando criará um shell com Python, Pandas e a biblioteca da OpenAI prontos para uso.

#### Opção B: Para outros sistemas (Linux, macOS, Windows)

1.  **Crie e ative um ambiente virtual:**
    ```bash
    python -m venv .venv
    source .venv/bin/activate
    # No Windows, use: .venv\Scripts\activate
    ```

2.  **Instale as dependências:**
    ```bash
    pip install -r requirements.txt
    ```

### 3. Configure a Chave da API

O script precisa da sua chave da OpenAI para funcionar. Exporte-a como uma variável de ambiente:

```bash
export OPENAI_API_KEY='sua_chave_secreta_aqui'
```

### 4. Execute o Pipeline

Com o ambiente ativado e a chave configurada, execute o script principal:

```bash
python etl.py
```

## ✅ Resultado

Ao final da execução, um novo arquivo `users_with_messages.csv` será gerado no diretório, contendo os dados dos usuários e uma nova coluna `MarketingMessage` com as mensagens criadas pela IA.

## 📂 Estrutura do Projeto

```
.
├── etl.py                  # Script principal com a lógica do pipeline ETL
├── users.csv               # Arquivo de entrada com os dados dos clientes
├── users_with_messages.csv # Arquivo de saída gerado pelo script (após execução)
├── shell.nix               # Arquivo de configuração de ambiente para NixOS
├── requirements.txt        # Lista de dependências Python para ambientes não-Nix
└── README.md               # Este arquivo
```
