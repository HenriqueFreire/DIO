# Anti-fraud Document Analyzer with Azure AI

Este projeto utiliza o serviço **Azure AI Document Intelligence** para analisar documentos e realizar validações básicas anti-fraude.

## Funcionalidades
- Extração de dados de IDs, Recibos e Faturas.
- Validação de datas e campos obrigatórios.
- Interface simples para upload e análise.

## Pré-requisitos
- Python 3.10+
- Conta no Azure com recurso de Document Intelligence.

## Configuração
1. Clone o repositório.
2. Crie um arquivo `.env` baseado no `.env.example`.
3. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```
4. Execute a aplicação:
   ```bash
   streamlit run src/app.py
   ```
