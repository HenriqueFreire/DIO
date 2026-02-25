# Agente Virtual Financeiro com IA Generativa

Este projeto visa desenvolver um agente virtual financeiro que fornece informações sobre cotações, notícias e balanços financeiros de empresas de capital aberto.

## Funcionalidades
- Cotações de ações (B3)
- Notícias financeiras (mercado brasileiro)
- Balanços financeiros (B3/CVM)
- Análise e sumarização de dados financeiros via IA Generativa

## Tecnologias
- Python
- Google Gemini API (IA Generativa)
- brapi (API para cotações e dados financeiros B3/CVM)
- Dados de Mercado (API para notícias financeiras)

## Configuração do Ambiente de Desenvolvimento (Nix)

1.  **Crie o arquivo `shell.nix`:**
    ```nix
    { pkgs ? import <nixpkgs> {} }:

    pkgs.mkShell {
      buildInputs = with pkgs; [
        python3
        (python3.withPackages (p: with p; [
          python-dotenv
          requests
          google-generativeai
        ]))
      ];

      shellHook = ''
        export PYTHONPATH="$PWD/.venv/lib/python3.10/site-packages:$PYTHONPATH"
        echo "Nix shell entered. Python environment configured."
      '';
    }
    ```

2.  **Entre no ambiente Nix:**
    ```bash
    nix-shell
    ```

3.  **Instale as dependências Python:** Certifique-se de que você está dentro do shell Nix. Em seguida, execute:
    ```bash
    pip install -r requirements.txt
    ```

## Variáveis de Ambiente
O arquivo `.env` já foi criado. Por favor, preencha-o com suas chaves de API:

```
GEMINI_API_KEY=sua_chave_gemini
BRAPI_API_KEY=sua_chave_brapi
DADOSDEMERCADO_API_KEY=sua_chave_dadosdemercado
```

Substitua `sua_chave_gemini`, `sua_chave_brapi` e `sua_chave_dadosdemercado` pelas suas respectivas chaves de API.
