# Jogo de Quiz em C++ com Dicas de IA

Este é um jogo de quiz simples desenvolvido em C++ que integra a API do OpenAI (ChatGPT) para fornecer dicas aos jogadores.

## Funcionalidades

*   Jogo de perguntas e respostas de múltipla escolha.
*   Dicas geradas por Inteligência Artificial (OpenAI GPT-3.5-turbo) quando solicitado pelo jogador.
*   Ambiente de desenvolvimento configurado com Nix para fácil reprodução.

## Pré-requisitos

Para rodar este projeto, você precisará:

*   **Nix Package Manager:** Se você não o tem, pode instalá-lo seguindo as instruções em [nixos.org](https://nixos.org/download.html).
*   **Chave da API OpenAI:** Uma chave válida da API do OpenAI para acessar o modelo GPT-3.5-turbo. Você pode obtê-la em [platform.openai.com](https://platform.openai.com/account/api-keys).

## Configuração e Instalação

1.  **Navegue até o diretório do projeto:**
    ```bash
    cd /home/henrique/Documentos/DIO/Formações/C e C++/Desenvolva-um-Game-com-Suporte-da-Ferramenta-ChatGPT/
    ```

2.  **Entre no ambiente de desenvolvimento Nix:**
    Este projeto utiliza um `shell.nix` para gerenciar suas dependências (g++, libcurl, nlohmann/json).
    ```bash
    nix-shell
    ```
    Isso configurará automaticamente o ambiente com todas as ferramentas necessárias.

3.  **Configure sua Chave da API OpenAI:**
    Defina a variável de ambiente `OPENAI_API_KEY` com sua chave. **É crucial que você não inclua sua chave diretamente no código ou em arquivos que serão versionados.**
    ```bash
    export OPENAI_API_KEY="sua_chave_da_openai_aqui"
    ```
    (Substitua `"sua_chave_da_openai_aqui"` pela sua chave real. Esta variável só será válida para a sessão atual do terminal.)

## Como Compilar

Dentro do ambiente `nix-shell`, compile o projeto usando `make`:

```bash
make
```

## Como Rodar

Após a compilação, execute o jogo:

```bash
./quiz_game
```

## Como Jogar

O jogo apresentará perguntas de múltipla escolha. Você pode:

*   Digitar a letra correspondente à sua resposta (A, B, C ou D).
*   Digitar `dica` para receber uma dica gerada pela IA.

## Estrutura do Projeto

*   `shell.nix`: Define o ambiente de desenvolvimento Nix.
*   `Makefile`: Script para compilar o projeto.
*   `main.cpp`: Lógica principal do jogo, interação com o usuário.
*   `Quiz.h`, `Quiz.cpp`: Definição e implementação da classe `Quiz` que gerencia as perguntas e o estado do jogo.
*   `ApiAssistant.h`, `ApiAssistant.cpp`: Definição e implementação da classe `ApiAssistant` que lida com a comunicação com a API do OpenAI.

## Próximos Passos / Melhorias Potenciais

*   Carregar perguntas de um arquivo (JSON, CSV) em vez de hardcoded.
*   Adicionar pontuação e um placar final.
*   Implementar diferentes níveis de dificuldade.
*   Melhorar a interface do usuário (UI).
*   Adicionar tratamento de erros mais robusto para chamadas de API.
