# Desafio de Projeto: Consulta de CPF

Este projeto é uma simples aplicação de console que valida um número de CPF informado pelo usuário, utilizando a gem `cpf_cnpj`.

## Funcionalidades

*   Recebe um número de CPF do usuário.
*   Verifica se o CPF é válido ou inválido.

## Estrutura do Projeto

*   `CPF_validator.rb`: É o arquivo principal que executa a aplicação, solicita o CPF ao usuário e utiliza a gem `cpf_cnpj` para realizar a validação.
*   `bundler/Gemfile`: Arquivo que define as dependências do projeto, neste caso, a gem `cpf_cnpj`.

## Como executar

1.  **Instale as dependências:**

    Certifique-se de ter o [Bundler](https://bundler.io/) instalado. Em seguida, na pasta `bundler`, execute o comando:

    ```bash
    bundle install
    ```

2.  **Execute a aplicação:**

    Na pasta raiz do desafio, execute o seguinte comando no seu terminal:

    ```bash
    ruby CPF_validator.rb
    ```
