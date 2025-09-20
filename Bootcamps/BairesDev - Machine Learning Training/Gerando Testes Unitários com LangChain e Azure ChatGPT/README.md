# Gerador de Testes Unitários com LangChain e Azure OpenAI

Este projeto implementa um **agente de Inteligência Artificial** robusto e modular, projetado para **gerar testes unitários (`pytest`)** para funções Python de forma autônoma. Desenvolvido como parte de um desafio do bootcamp da DIO, ele demonstra a aplicação prática de LLMs (Large Language Models) na automação de tarefas de desenvolvimento de software, especificamente na garantia de qualidade de código.

## Visão Geral e Propósito

O objetivo central deste projeto é simplificar e acelerar o processo de criação de testes unitários. Ao invés de escrever testes manualmente, o agente de IA analisa o código-fonte Python, compreende sua estrutura e lógica, e então gera testes abrangentes que cobrem diversos cenários, incluindo:
*   Caminhos de sucesso (happy path).
*   Casos de falha e tratamento de exceções.
*   Casos de borda (edge cases).

Isso não apenas economiza tempo, mas também ajuda a manter uma alta cobertura de testes e a identificar potenciais problemas no código de forma proativa.

## Arquitetura e Design

O projeto é construído com uma arquitetura modular e princípios de design de software sólidos, garantindo clareza, manutenibilidade e extensibilidade:

*   **Modularidade:** O código é dividido em módulos com responsabilidades claras:
    *   `src/agent.py`: Atua como uma **Facade** (`TestGeneratorAgent`), orquestrando o fluxo principal de análise e geração de testes.
    *   `src/analyzer.py`: Responsável pela **análise estática** do código Python, utilizando o módulo `ast` para extrair metadados e calcular métricas como a complexidade ciclomática.
    *   `src/config.py`: Gerencia as **configurações do sistema** e variáveis de ambiente (via `python-dotenv`), centralizando o acesso a credenciais e parâmetros.
    *   `src/llm.py`: Implementa um **Factory Method** (`create_llm`) para instanciar o modelo de linguagem correto (Azure OpenAI ou um simulado).
    *   `src/functions.py`: Contém as funções Python de exemplo para as quais os testes são gerados.
*   **Padrões de Projeto:** A aplicação de padrões como **Facade** e **Factory Method** contribui para um design limpo e desacoplado, facilitando futuras modificações ou a substituição de componentes.

## Tecnologias Chave

*   **LangChain:** Framework utilizado para orquestrar o agente de IA, gerenciar prompts e interagir com o LLM.
*   **Azure OpenAI:** O Large Language Model (LLM) principal que alimenta a inteligência do agente, responsável pela geração do código de teste.
*   **`pytest`:** Framework de testes Python, utilizado para a execução dos testes gerados.
*   **`ast` (Abstract Syntax Trees):** Módulo padrão do Python empregado em `src/analyzer.py` para realizar a análise estática do código-fonte.
*   **`python-dotenv`:** Biblioteca para carregar variáveis de ambiente de um arquivo `.env`, garantindo a segurança e flexibilidade das configurações.

## Funcionalidades Principais

*   **Geração Inteligente de Testes:** O agente utiliza o LLM para criar testes unitários contextualmente relevantes e abrangentes para funções Python.
*   **Análise de Código Contextual:** Fornece ao LLM informações detalhadas sobre a estrutura do código (funções, classes, complexidade), resultando em testes mais precisos.
*   **Modo de Simulação Robusto:** Inclui um `SimulatedLLM` que permite o desenvolvimento e a demonstração do projeto mesmo sem credenciais ativas do Azure OpenAI, retornando testes genéricos. Isso aumenta a acessibilidade e a resiliência do sistema.
*   **Saída Padronizada:** Os testes gerados são formatados para `pytest` e salvos em `tests/test_functions.py`, prontos para serem executados.

## Qualidade do Código

O projeto demonstra um alto padrão de qualidade de código, caracterizado por:
*   **Clareza e Legibilidade:** Código bem comentado e com nomes descritivos para variáveis, funções e classes.
*   **Manutenibilidade:** A estrutura modular e o uso de padrões de design facilitam a compreensão e a realização de futuras modificações.
*   **Robustez:** O tratamento de configurações sensíveis e o modo de simulação contribuem para um sistema mais robusto e adaptável.

---

## Como Utilizar o Projeto

Para começar a usar este gerador de testes, siga os passos abaixo:

### Configuração do Ambiente (Com Nix)

1.  **Instale o Nix:** Se você ainda não o tiver, instale o [Nix package manager](https://nixos.org/download.html).
2.  **Ative o Ambiente:** Na raiz do projeto, execute o comando:
    ```bash
    nix-shell
    ```
    Isso irá criar um ambiente isolado com Python 3.11 e instalará as dependências listadas em `requirements.txt` em um ambiente virtual `.venv`.

### Configuração Manual (Sem Nix)

Se você não utiliza Nix ou prefere uma configuração manual em um ambiente Python tradicional, siga estes passos:

1.  **Crie e Ative um Ambiente Virtual Python:**
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```
    *Certifique-se de estar na raiz do projeto ao executar esses comandos.* 

2.  **Instale as Dependências:**
    ```bash
    pip install -r requirements.txt
    ```

### Configuração das Variáveis de Ambiente (Comum a Ambas as Configurações)

1.  **Copie o arquivo `.env.example` para um novo arquivo chamado `.env`:**
    ```bash
    cp .env.example .env
    ```
2.  **Abra o arquivo `.env` e preencha com suas credenciais do Azure OpenAI.**

### Como Rodar

1.  **Execute o Agente para Gerar os Testes:**
    *   Uma vez que seu arquivo `.env` esteja configurado com as credenciais do Azure OpenAI, execute o script do agente:
    ```bash
    python src/agent.py
    ```
    *   O agente irá ler as funções em `src/functions.py`, chamar a IA e salvar os testes gerados no arquivo `tests/test_functions.py`.

2.  **Execute os Testes:**
    *   Para verificar se os testes (gerados pela IA ou o exemplo que criamos) funcionam, execute `pytest`:
    ```bash
    pytest
    ```
    *   Você deverá ver a saída dos testes indicando que passaram com sucesso.

---

## Próximos Passos e Melhorias Potenciais

Este projeto serve como uma base sólida e pode ser expandido com diversas melhorias, como:
*   **Suporte a Múltiplos Arquivos/Diretórios:** Permitir que o agente analise e gere testes para um conjunto maior de arquivos-fonte.
*   **Geração de Testes para Classes:** Estender a funcionalidade para gerar testes para métodos de classes, não apenas funções isoladas.
*   **Feedback Iterativo:** Implementar um mecanismo onde o agente possa receber feedback sobre a falha de testes gerados e tentar corrigi-los.
*   **Integração Contínua:** Explorar a integração com pipelines de CI/CD para automação completa da geração e execução de testes.
