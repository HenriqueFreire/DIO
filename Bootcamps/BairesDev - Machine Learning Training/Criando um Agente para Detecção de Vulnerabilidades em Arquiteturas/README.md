# Agente de Cibersegurança para Modelagem de Ameaças STRIDE

Este projeto é um agente de IA que atua como um especialista em cibersegurança para realizar a modelagem de ameaças em arquiteturas de software. A aplicação utiliza a metodologia STRIDE (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) para analisar uma arquitetura e gerar um relatório detalhado de possíveis ameaças.

## Funcionalidades

*   **API de Análise:** Um backend construído com FastAPI que recebe detalhes da aplicação e um diagrama de arquitetura.
*   **Inteligência Artificial:** Utiliza um modelo de linguagem da Azure OpenAI para analisar as informações e gerar um modelo de ameaças.
*   **Frontend Interativo:** Uma interface de usuário para submeter os dados da aplicação e visualizar os resultados.
*   **Visualização Gráfica:** Exibe um grafo de ameaças (atualmente estático) utilizando Cytoscape.js.

## Estrutura do Projeto

O projeto é organizado em duas pastas principais:

```
.
├── backend/        # Contém a aplicação FastAPI em Python
├── frontend/       # Contém a interface do usuário (HTML, CSS, JS)
├── .gitignore
└── shell.nix       # Arquivo de configuração do ambiente Nix
```

## Como Executar

### Pré-requisitos

*   **Nix:** Para a Opção 1, é necessário ter o [Nix](https://nixos.org/download.html) instalado.
*   **Python 3.12+:** Para a Opção 2.
*   **Chaves da API Azure OpenAI:** É preciso ter um arquivo `.env` na pasta `backend` com as suas credenciais:
    ```
    AZURE_OPENAI_API_KEY="SUA_CHAVE_API"
    AZURE_OPENAI_ENDPOINT="SEU_ENDPOINT"
    AZURE_OPENAI_API_VERSION="SUA_VERSAO_API"
    AZURE_OPENAI_DEPLOYMENT_NAME="SEU_DEPLOYMENT_NAME"
    ```

---

### **Opção 1: Usando o Ambiente Nix (Recomendado)**

Esta é a forma mais simples de garantir que todas as dependências de sistema e de Python estejam corretas.

1.  **Inicie o ambiente Nix:**
    Na raiz do projeto, execute o comando:
    ```bash
    nix-shell
    ```
    Isso irá baixar e configurar todas as dependências definidas no arquivo `shell.nix`.

2.  **Execute o Backend:**
    Após entrar no `nix-shell`, navegue até a pasta do backend e inicie o servidor:
    ```bash
    cd backend
    uvicorn main:app --port 8001
    ```

---

### **Opção 2: Usando Ambiente Virtual Python (Alternativo)**

Se você não utiliza o Nix, pode configurar o ambiente manualmente.

1.  **Crie e ative um ambiente virtual:**
    Na raiz do projeto, execute:
    ```bash
    python -m venv .venv
    source .venv/bin/activate
    ```

2.  **Instale as dependências:**
    Navegue até a pasta do backend e instale as bibliotecas Python:
    ```bash
    cd backend
    pip install -r requirements.txt
    ```

3.  **Execute o Backend:**
    Ainda na pasta `backend`, inicie o servidor:
    ```bash
    uvicorn main:app --port 8001
    ```

---

### **Acessando o Frontend**

Com o servidor backend em execução, abra o arquivo `frontend/index.html` em seu navegador.

## Tecnologias Utilizadas

*   **Backend:** Python, FastAPI, Uvicorn
*   **Frontend:** HTML, CSS, JavaScript, Bootstrap, Cytoscape.js
*   **IA:** Azure OpenAI
*   **Ambiente:** Nix
